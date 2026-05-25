import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:uuid/uuid.dart';

import 'package:lifemesh/core/database_service.dart';
import 'package:lifemesh/core/services/crypto_service.dart';
import 'package:lifemesh/core/network/message_bus.dart';
import 'package:lifemesh/core/network/payloads/chat_payloads.dart';
import 'package:lifemesh/core/network/payloads/file_payloads.dart';
import 'package:lifemesh/core/constants/mesh_states.dart';
import 'package:lifemesh/models/nearby_user_model.dart';
import 'package:lifemesh/models/onboarding_user_model.dart';
import 'package:isar/isar.dart';

class NearbyService extends GetxService {
  static const String serviceId = 'com.kangleiinnovations.lifemesh.mesh';
  static const MethodChannel _platform = MethodChannel('lifemesh/ble_rssi');
  static const EventChannel _rssiEvents = EventChannel('lifemesh/ble_rssi/events');

  final Nearby _nearby = Nearby();
  final DatabaseService _db = Get.find<DatabaseService>();
  final CryptoService _cryptoService = Get.find<CryptoService>();
  final MessageBus _messageBus = Get.find<MessageBus>();

  final Rx<MeshConnectionState> globalState = MeshConnectionState.idle.obs;
  final RxBool isScanning = false.obs;

  final Set<String> _connectedEndpoints = {};
  final Map<String, String> _endpointMeshIds = {};
  final Map<String, int> _rssiByMeshId = {};

  String _localMeshId = '';
  String _localEndpointName = '';

  Timer? _heartbeatTimer;

  Future<NearbyService> init() async {
    print("NearbyService: Initializing Transport Layer...");
    await _cryptoService.init();
    _listenForBleRssi();
    
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 5), (_) => _broadcastHeartbeat());
    
    print("NearbyService: Transport Layer Initialized.");
    return this;
  }

  @override
  void onClose() {
    _heartbeatTimer?.cancel();
    stopMesh();
    super.onClose();
  }

  Future<void> startMesh() async {
    print("NearbyService: Starting mesh transport...");
    globalState.value = MeshConnectionState.discovering;
    isScanning.value = true;

    await _loadLocalIdentity();

    try {
      await _startAdvertising();
      await _startDiscovery();
      await _startBleIdentityBeacon();
      print("NearbyService: Mesh transport active.");
    } catch (e) {
      print("NearbyService: Start error: $e");
      globalState.value = MeshConnectionState.failed;
      isScanning.value = false;
    }
  }

  Future<void> stopMesh() async {
    print("NearbyService: Stopping mesh transport...");
    isScanning.value = false;
    globalState.value = MeshConnectionState.idle;

    await _nearby.stopDiscovery();
    await _nearby.stopAdvertising();
    await _nearby.stopAllEndpoints();
    await _stopBleIdentityBeacon();

    _connectedEndpoints.clear();
    _endpointMeshIds.clear();
  }

  Future<void> _loadLocalIdentity() async {
    final user = await _db.isar.onboardingUserModels.where().findFirst();
    if (user != null && user.meshId != null) {
      _localMeshId = user.meshId!;
    } else {
      _localMeshId = const Uuid().v4();
      if (user != null) {
        await _db.isar.writeTxn(() async {
          user.meshId = _localMeshId;
          await _db.isar.onboardingUserModels.put(user);
        });
        print("NearbyService: Generated and saved new MeshID: $_localMeshId");
      }
    }
    
    final username = user?.displayName ?? 'LifeMesh User';
    final deviceName = Platform.isAndroid ? await _platform.invokeMethod<String>('getDeviceName') : 'Device';

    _localEndpointName = 'LM|$_localMeshId|$username|$deviceName';
  }

  Future<void> _startAdvertising() async {
    await _nearby.startAdvertising(
      _localEndpointName,
      Strategy.P2P_CLUSTER,
      serviceId: serviceId,
      onConnectionInitiated: _onConnectionInitiated,
      onConnectionResult: _onConnectionResult,
      onDisconnected: _onDisconnected,
    );
  }

  Future<void> _startDiscovery() async {
    await _nearby.startDiscovery(
      _localEndpointName,
      Strategy.P2P_CLUSTER,
      serviceId: serviceId,
      onEndpointFound: (id, name, sid) {
        if (sid == serviceId) _onEndpointFound(id, name);
      },
      onEndpointLost: (id) => _onUserLost(id!),
    );
  }

  void _onEndpointFound(String endpointId, String endpointName) {
    print("NearbyService: Found endpoint $endpointName");
    final parts = endpointName.split('|');
    if (parts.length >= 4 && parts[0] == 'LM') {
      final meshId = parts[1];
      if (meshId == _localMeshId) return;

      _endpointMeshIds[endpointId] = meshId;
      _nearby.requestConnection(
        _localEndpointName,
        endpointId,
        onConnectionInitiated: _onConnectionInitiated,
        onConnectionResult: _onConnectionResult,
        onDisconnected: _onDisconnected,
      );
    }
  }

  void _onConnectionInitiated(String endpointId, ConnectionInfo info) {
    print("NearbyService: Connection initiated with ${info.endpointName}");
    _nearby.acceptConnection(
      endpointId,
      onPayLoadRecieved: _handlePayload,
    );
  }

  void _onConnectionResult(String endpointId, Status status) {
    if (status == Status.CONNECTED) {
      print("NearbyService: Connected to $endpointId");
      _connectedEndpoints.add(endpointId);
      _sendIdentity(endpointId);
    } else {
      _connectedEndpoints.remove(endpointId);
    }
  }

  void _onDisconnected(String endpointId) {
    print("NearbyService: Disconnected $endpointId");
    _connectedEndpoints.remove(endpointId);
    _onUserLost(endpointId);
  }

  Future<void> _handlePayload(String endpointId, Payload payload) async {
    if (payload.type != PayloadType.BYTES || payload.bytes == null) return;
    
    final clearText = await _cryptoService.decryptRaw(payload.bytes!.toList());
    if (clearText == null || clearText.isEmpty) return;

    if (clearText[0] == 0x02) { // Magic byte for FileChunkPayload
      final chunkPayload = FileChunkPayload.fromBytes(Uint8List.fromList(clearText));
      if (chunkPayload != null) {
        _messageBus.publishFileChunk(chunkPayload);
      }
      return;
    }

    // Otherwise, attempt to decode as JSON
    Map<String, dynamic>? decryptedMap;
    try {
      final jsonStr = utf8.decode(clearText);
      decryptedMap = jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (e) {
      print("NearbyService: Failed to parse decrypted payload as JSON");
      return;
    }

    if (decryptedMap['type'] == 'lifemesh.identity.v1') {
      final user = NearbyUserModel()
        ..endpointId = endpointId
        ..meshId = decryptedMap['meshId']
        ..name = decryptedMap['username']
        ..deviceName = decryptedMap['deviceName']
        ..isOnline = true
        ..lastSeen = DateTime.now()
        ..lastHeartbeat = DateTime.now()
        ..connectionStatus = MeshConnectionState.connected.name
        ..discoverySource = 'nearby_connections'
        ..connectionType = 'p2p'
        ..signalStrength = _calculateSignal(decryptedMap['meshId']);
      
      await _upsertUser(user);
    } else if (decryptedMap['type'] == 'lifemesh.heartbeat.v1') {
      final existing = await _db.isar.nearbyUserModels.filter().meshIdEqualTo(decryptedMap['meshId']).findFirst();
      if (existing != null) {
        await _db.isar.writeTxn(() async {
          existing.isOnline = true;
          existing.lastHeartbeat = DateTime.now();
          existing.lastSeen = DateTime.now();
          existing.connectionStatus = MeshConnectionState.connected.name;
          await _db.isar.nearbyUserModels.put(existing);
        });
      }
    } else if (decryptedMap['type'] == 'lifemesh.chat.message.v1') {
      print("NearbyService: Incoming Chat Payload");
      _messageBus.publishChatMessage(ChatMessagePayload.fromJson(decryptedMap));
    } else if (decryptedMap['type'] == 'lifemesh.chat.ack.v1') {
      print("NearbyService: Incoming ACK Payload");
      _messageBus.publishAck(ChatAckPayload.fromJson(decryptedMap));
    } else if (decryptedMap['type'] == 'lifemesh.chat.typing.v1') {
      print("NearbyService: Incoming Typing Payload");
      _messageBus.publishTyping(ChatTypingPayload.fromJson(decryptedMap));
    } else if (decryptedMap['type'] == 'lifemesh.file.start.v1') {
      print("NearbyService: Incoming File Start Payload");
      _messageBus.publishFileStart(FileTransferStartPayload.fromJson(decryptedMap));
    } else if (decryptedMap['type'] == 'lifemesh.file.ack.v1') {
      print("NearbyService: Incoming File ACK Payload");
      _messageBus.publishFileAck(FileTransferAckPayload.fromJson(decryptedMap));
    }
  }

  Future<void> sendPayload(String endpointId, Map<String, dynamic> payload) async {
    print("NearbyService: Transmitting encrypted ${payload['type']}");
    final encryptedBytes = await _cryptoService.encryptMessage(payload);
    await _nearby.sendBytesPayload(endpointId, Uint8List.fromList(encryptedBytes));
  }

  Future<void> sendRawPayload(String endpointId, Uint8List rawBytes) async {
    // We assume rawBytes is already structured (e.g., FileChunkPayload.toBytes())
    final encryptedBytes = await _cryptoService.encryptRaw(rawBytes.toList());
    await _nearby.sendBytesPayload(endpointId, Uint8List.fromList(encryptedBytes));
  }

  Future<void> _sendIdentity(String endpointId) async {
    final payload = {
      'type': 'lifemesh.identity.v1',
      'meshId': _localMeshId,
      'username': _localEndpointName.split('|')[2],
      'deviceName': _localEndpointName.split('|')[3],
    };
    await sendPayload(endpointId, payload);
  }

  Future<void> _broadcastHeartbeat() async {
    if (_connectedEndpoints.isEmpty) return;
    final payload = {
      'type': 'lifemesh.heartbeat.v1',
      'meshId': _localMeshId,
    };
    final encryptedBytes = await _cryptoService.encryptMessage(payload);
    final bytesList = Uint8List.fromList(encryptedBytes);
    
    for (final id in _connectedEndpoints) {
      _nearby.sendBytesPayload(id, bytesList);
    }
  }

  void _onUserLost(String endpointId) async {
    final meshId = _endpointMeshIds[endpointId];
    if (meshId != null) {
      final user = await _db.isar.nearbyUserModels.filter().meshIdEqualTo(meshId).findFirst();
      if (user != null) {
        await _db.isar.writeTxn(() async {
          user.isOnline = false;
          user.connectionStatus = MeshConnectionState.idle.name;
          await _db.isar.nearbyUserModels.put(user);
        });
      }
    }
  }

  Future<void> _upsertUser(NearbyUserModel user) async {
    await _db.isar.writeTxn(() async {
      final existing = await _db.isar.nearbyUserModels
          .filter()
          .meshIdEqualTo(user.meshId)
          .findFirst();

      if (existing != null) {
        user.id = existing.id;
        user.connectedAt ??= existing.connectedAt;
        user.name ??= existing.name;
        user.deviceName ??= existing.deviceName;
      }
      user.connectedAt ??= DateTime.now();
      await _db.isar.nearbyUserModels.put(user);
    });
  }

  double _calculateSignal(String meshId) {
    final rssi = _rssiByMeshId[meshId.substring(0, 8)] ?? -70;
    return ((rssi + 100) / 70).clamp(0.0, 1.0);
  }

  void _listenForBleRssi() {
    if (!Platform.isAndroid) return;
    _rssiEvents.receiveBroadcastStream().listen((event) {
      if (event is Map) {
        final finger = event['fingerprint']?.toString();
        final rssi = event['rssi'] as int?;
        if (finger != null && rssi != null) {
          _rssiByMeshId[finger] = rssi;
        }
      }
    });
  }

  Future<void> _startBleIdentityBeacon() async {
    if (!Platform.isAndroid) return;
    final finger = _localMeshId.replaceAll('-', '').substring(0, 8).toLowerCase();
    await _platform.invokeMethod('startBleAdvertising', {'fingerprint': finger});
    await _platform.invokeMethod('startBleScanning');
  }

  Future<void> _stopBleIdentityBeacon() async {
    if (!Platform.isAndroid) return;
    await _platform.invokeMethod('stopBleAdvertising');
    await _platform.invokeMethod('stopBleScanning');
  }
}
