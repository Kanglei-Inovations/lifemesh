// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:uuid/uuid.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:lifemesh/core/database_service.dart';
import 'package:lifemesh/core/services/crypto_service.dart';
import 'package:lifemesh/core/constants/mesh_states.dart';
import 'package:lifemesh/models/nearby_user_model.dart';
import 'package:lifemesh/models/dashboard_stat_model.dart';
import 'package:lifemesh/models/onboarding_user_model.dart';

class NearbyService extends GetxService {
  static const String serviceId = 'com.kangleiinnovations.lifemesh.mesh';
  static const MethodChannel _platform = MethodChannel('lifemesh/ble_rssi');
  static const EventChannel _rssiEvents = EventChannel('lifemesh/ble_rssi/events');

  final Nearby _nearby = Nearby();
  final DatabaseService _db = Get.find<DatabaseService>();
  final CryptoService _cryptoService = Get.find<CryptoService>();

  final Rx<MeshConnectionState> globalState = MeshConnectionState.idle.obs;
  final RxBool isScanning = false.obs;
  final RxList<NearbyUserModel> activeNearbyUsers = <NearbyUserModel>[].obs;
  final RxList<NearbyUserModel> connectedNodes = <NearbyUserModel>[].obs;
  final RxDouble avgSignalStrength = 0.0.obs;

  final Set<String> _connectedEndpoints = {};
  final Map<String, String> _endpointMeshIds = {};
  final Map<String, int> _rssiByMeshId = {};

  String _localMeshId = '';
  String _localEndpointName = '';

  Timer? _heartbeatTimer;
  Timer? _cleanupTimer;
  static const int heartbeatTimeout = 15;

  Future<NearbyService> init() async {
    print("NearbyService initializing...");
    await _cryptoService.init();
    _listenForBleRssi();
    
    await _clearActiveStates();
    _setupIsarWatcher();

    _heartbeatTimer = Timer.periodic(const Duration(seconds: 5), (_) => _broadcastHeartbeat());
    _cleanupTimer = Timer.periodic(const Duration(seconds: 5), (_) => _cleanupStaleUsers());
    
    print("NearbyService initialized.");
    return this;
  }

  @override
  void onClose() {
    _heartbeatTimer?.cancel();
    _cleanupTimer?.cancel();
    stopMesh();
    super.onClose();
  }

  Future<void> startMesh() async {
    print("Starting NearbyService mesh discovery...");
    globalState.value = MeshConnectionState.discovering;
    isScanning.value = true;

    await _loadLocalIdentity();

    if (Platform.isAndroid) {
      final status = await _requestPermissions();
      if (!status) {
        print("NearbyService: Permissions denied.");
        globalState.value = MeshConnectionState.failed;
        isScanning.value = false;
        
        // Navigate to permissions screen if critical permissions are missing
        if (Get.currentRoute != '/permissions') {
          Get.toNamed('/permissions');
        }
        return;
      }
    }

    try {
      await _startAdvertising();
      await _startDiscovery();
      await _startBleIdentityBeacon();
      print("NearbyService: Mesh active.");
    } catch (e) {
      print("NearbyService: Start error: $e");
      globalState.value = MeshConnectionState.failed;
      isScanning.value = false;
    }
  }

  Future<void> stopMesh() async {
    print("Stopping NearbyService mesh discovery...");
    isScanning.value = false;
    globalState.value = MeshConnectionState.idle;

    await _nearby.stopDiscovery();
    await _nearby.stopAdvertising();
    await _nearby.stopAllEndpoints();
    await _stopBleIdentityBeacon();

    _connectedEndpoints.clear();
    _endpointMeshIds.clear();
    await _clearActiveStates();
  }

  Future<void> _loadLocalIdentity() async {
    final users = await _db.isar.onboardingUserModels.where().findAll();
    final user = users.isNotEmpty ? users.first : null;

    _localMeshId = user?.meshId ?? const Uuid().v4();
    final username = user?.displayName ?? 'LifeMesh User';
    final deviceName = Platform.isAndroid ? await _platform.invokeMethod<String>('getDeviceName') : 'Device';

    _localEndpointName = 'LM|$_localMeshId|$username|$deviceName';
  }

  Future<bool> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.nearbyWifiDevices,
    ].request();

    // Location is always required
    if (!(statuses[Permission.location]?.isGranted ?? false)) {
      return false;
    }

    // Bluetooth permissions: 
    // On Android 12+, Scan/Connect/Advertise are required.
    // On Android <12, legacy Bluetooth is required.
    // permission_handler manages some of this, but let's be safe.
    bool btScan = statuses[Permission.bluetoothScan]?.isGranted ?? true;
    bool btConnect = statuses[Permission.bluetoothConnect]?.isGranted ?? true;
    bool btAdvertise = statuses[Permission.bluetoothAdvertise]?.isGranted ?? true;
    bool btLegacy = statuses[Permission.bluetooth]?.isGranted ?? true;

    // Nearby WiFi is Android 13+ only
    // bool wifi = statuses[Permission.nearbyWifiDevices]?.isGranted ?? true;

    return btScan && btConnect && btAdvertise && btLegacy;
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
    if (payload.type != PayloadType.BYTES) return;
    
    // Decrypt the payload
    final decryptedMap = await _cryptoService.decryptMessage(payload.bytes!.toList());
    if (decryptedMap == null) return;

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
      final user = NearbyUserModel()
        ..endpointId = endpointId
        ..meshId = decryptedMap['meshId']
        ..isOnline = true
        ..lastSeen = DateTime.now()
        ..lastHeartbeat = DateTime.now()
        ..connectionStatus = MeshConnectionState.connected.name;
      
      await _upsertUser(user);
    } else if (decryptedMap['type'] == 'lifemesh.chat.v1') {
      // Handle incoming encrypted chat messages here later
      print("Received secure chat message: ${decryptedMap['text']}");
    }
  }

  Future<void> _sendIdentity(String endpointId) async {
    final payload = {
      'type': 'lifemesh.identity.v1',
      'meshId': _localMeshId,
      'username': _localEndpointName.split('|')[2],
      'deviceName': _localEndpointName.split('|')[3],
    };
    
    final encryptedBytes = await _cryptoService.encryptMessage(payload);
    await _nearby.sendBytesPayload(endpointId, Uint8List.fromList(encryptedBytes));
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

  void _onUserLost(String endpointId) {
    // We let the heartbeat cleanup handle Isar status, but we can do immediate local cleanup if desired.
  }

  Future<void> _upsertUser(NearbyUserModel user) async {
    await _db.isar.writeTxn(() async {
      final existing = await _db.isar.nearbyUserModels
          .filter()
          .meshIdEqualTo(user.meshId)
          .or()
          .endpointIdEqualTo(user.endpointId)
          .findFirst();

      if (existing != null) {
        user.id = existing.id;
        user.connectedAt ??= existing.connectedAt;
        user.name ??= existing.name;
        user.deviceName ??= existing.deviceName;
        user.discoverySource ??= existing.discoverySource;
        user.connectionType ??= existing.connectionType;
      }
      
      await _db.isar.nearbyUserModels.put(user);
    });
  }

  void _setupIsarWatcher() {
    _db.isar.nearbyUserModels.where().watch().listen((users) {
      final active = users.where((u) => u.isOnline).toList();
      activeNearbyUsers.assignAll(active);
      
      final connected = active.where((u) => u.connectionStatus == MeshConnectionState.connected.name).toList();
      connectedNodes.assignAll(connected);
      
      _updateStats(active);
    });
  }

  Future<void> _clearActiveStates() async {
    final users = await _db.isar.nearbyUserModels.where().findAll();
    await _db.isar.writeTxn(() async {
      for (final user in users) {
        user.isOnline = false;
        user.connectionStatus = MeshConnectionState.idle.name;
      }
      await _db.isar.nearbyUserModels.putAll(users);
    });
  }

  Future<void> _cleanupStaleUsers() async {
    final now = DateTime.now();
    final allUsers = await _db.isar.nearbyUserModels.where().findAll();
    final users = allUsers.where((u) => u.isOnline).toList();
    final toUpdate = <NearbyUserModel>[];

    for (final user in users) {
      final lastInteraction = user.lastHeartbeat ?? user.lastSeen ?? user.connectedAt;
      if (lastInteraction == null || now.difference(lastInteraction).inSeconds > heartbeatTimeout) {
        user.isOnline = false;
        user.connectionStatus = MeshConnectionState.idle.name;
        toUpdate.add(user);
      }
    }

    if (toUpdate.isNotEmpty) {
      await _db.isar.writeTxn(() async {
        await _db.isar.nearbyUserModels.putAll(toUpdate);
      });
    }
    
    // Purge very old records (> 24h)
    final oneDayAgo = now.subtract(const Duration(hours: 24));
    final toDelete = allUsers.where((u) => (u.lastSeen ?? DateTime(0)).isBefore(oneDayAgo)).map((u) => u.id).toList();
    if (toDelete.isNotEmpty) {
      await _db.isar.writeTxn(() async {
        await _db.isar.nearbyUserModels.deleteAll(toDelete);
      });
    }
  }

  void _updateStats(List<NearbyUserModel> activeUsers) {
    if (activeUsers.isEmpty) {
      avgSignalStrength.value = 0.0;
    } else {
      final total = activeUsers.fold<double>(0, (sum, u) => sum + (u.signalStrength ?? 0));
      avgSignalStrength.value = total / activeUsers.length;
    }
    unawaited(_syncDashboardStats());
  }

  Future<void> _syncDashboardStats() async {
    final stats = await _db.isar.dashboardStatModels.where().findFirst() ?? DashboardStatModel();
    await _db.isar.writeTxn(() async {
      stats.isMeshActive = isScanning.value;
      stats.connectedNodes = connectedNodes.length;
      stats.signalStrength = (avgSignalStrength.value * 100).round();
      stats.lastUpdated = DateTime.now();
      await _db.isar.dashboardStatModels.put(stats);
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
