import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'package:lifemesh/core/database_service.dart';
import 'package:lifemesh/core/services/crypto_service.dart';
import 'package:lifemesh/core/services/nearby_service.dart';
import 'package:lifemesh/core/network/lan_discovery_service.dart';
import 'package:lifemesh/core/network/local_node_server.dart';
import 'package:lifemesh/core/network/message_bus.dart';
import 'package:lifemesh/core/network/payloads/chat_payloads.dart';
import 'package:lifemesh/core/constants/mesh_states.dart';
import 'package:lifemesh/models/nearby_user_model.dart';
import 'package:lifemesh/models/dashboard_stat_model.dart';
import 'package:lifemesh/models/chat_message_model.dart';
import 'package:lifemesh/models/chat_room_model.dart';
import 'package:lifemesh/models/onboarding_user_model.dart';

class MeshNetworkService extends GetxService {
  final DatabaseService _db = Get.find<DatabaseService>();
  
  late final NearbyService _nearbyService;
  late final LanDiscoveryService _lanService;
  late final LocalNodeServer _nodeServer;
  late final MessageBus _messageBus;

  final Rx<MeshConnectionState> globalState = MeshConnectionState.idle.obs;
  final RxBool isScanning = false.obs;
  
  // Single source of truth for UI
  final RxList<NearbyUserModel> activeNearbyUsers = <NearbyUserModel>[].obs;
  final RxDouble avgSignalStrength = 0.0.obs;
  
  Timer? _heartbeatPollerTimer;
  Timer? _cleanupTimer;
  
  static const int heartbeatTimeout = 15; // 15 seconds

  final List<StreamSubscription> _busSubscriptions = [];

  Future<MeshNetworkService> init() async {
    print("MeshNetworkService: Initializing...");
    
    _nearbyService = Get.find<NearbyService>();
    _lanService = Get.find<LanDiscoveryService>();
    _nodeServer = Get.find<LocalNodeServer>();
    _messageBus = Get.find<MessageBus>();
    
    // Pass local node port to LAN service
    _lanService.setNodePort(_nodeServer.port);
    
    _lanService.onPeerDiscovered = _handleLanPeerDiscovered;

    _setupIsarWatcher();
    _setupMessageBusListeners();
    
    _heartbeatPollerTimer = Timer.periodic(const Duration(seconds: 5), (_) => _pollLanHeartbeats());
    _cleanupTimer = Timer.periodic(const Duration(seconds: 5), (_) => _cleanupStaleUsers());
    
    print("MeshNetworkService: Initialized.");
    return this;
  }

  String? getEndpointForMeshId(String meshId) {
    // 1. Check active nearby users (reactive list)
    final activeUser = activeNearbyUsers.firstWhereOrNull((u) => u.meshId == meshId);
    if (activeUser?.endpointId != null) return activeUser!.endpointId;

    // 2. Check nearby service internal state (if needed, but usually isar is source of truth)
    // For now, Isar is our source of truth for all users.
    return null;
  }
  
  @override
  void onClose() {
    _heartbeatPollerTimer?.cancel();
    _cleanupTimer?.cancel();
    for (var sub in _busSubscriptions) {
      sub.cancel();
    }
    stopMesh();
    super.onClose();
  }

  void _setupMessageBusListeners() {
    _busSubscriptions.add(_messageBus.incomingChatMessages.listen(_handleIncomingChatMessage));
    _busSubscriptions.add(_messageBus.incomingAcks.listen(_handleIncomingAck));
    _busSubscriptions.add(_messageBus.incomingTypingEvents.listen(_handleIncomingTyping));
  }

  Future<void> sendChatMessage({
    String? endpointId,
    required ChatMessagePayload payload,
  }) async {
    print("MeshNetworkService: Attempting to send chat message to ${payload.receiverMeshId}");
    
    // Resolve endpoint if not provided
    final targetEndpointId = endpointId ?? getEndpointForMeshId(payload.receiverMeshId);
    print("MeshNetworkService: Resolved endpoint ID: $targetEndpointId");

    // 1. Try Nearby Connections (P2P)
    if (targetEndpointId != null && targetEndpointId.isNotEmpty) {
      try {
        await _nearbyService.sendPayload(targetEndpointId, payload.toJson());
        await _updateMessageStatus(payload.messageId, DeliveryStatus.sent);
        print("MeshNetworkService: Message sent via Nearby Connections to $targetEndpointId");
        return;
      } catch (e) {
        print("MeshNetworkService: Nearby transmission failed: $e");
      }
    } else {
      print("MeshNetworkService: No Nearby endpoint found for ${payload.receiverMeshId}, trying LAN fallback...");
    }

    // 2. Try LAN Fallback (HTTP)
    final peer = await _db.isar.nearbyUserModels.filter().meshIdEqualTo(payload.receiverMeshId).findFirst();
    if (peer != null && peer.ipAddress != null && peer.port != null) {
      try {
        print("MeshNetworkService: Attempting LAN fallback to ${peer.ipAddress}:${peer.port}");
        final client = HttpClient();
        client.connectionTimeout = const Duration(seconds: 5);
        final request = await client.postUrl(Uri.parse('http://${peer.ipAddress}:${peer.port}/message'));
        request.headers.contentType = ContentType.json;
        
        final encryptedPayload = await Get.find<CryptoService>().encryptMessage(payload.toJson());
        request.add(encryptedPayload);
        
        final response = await request.close();
        if (response.statusCode == 200) {
          await _updateMessageStatus(payload.messageId, DeliveryStatus.sent);
          print("MeshNetworkService: Message sent via LAN HTTP.");
          return;
        } else {
          print("MeshNetworkService: LAN HTTP failed with status ${response.statusCode}");
        }
      } catch (e) {
        print("MeshNetworkService: LAN transmission failed: $e");
      }
    }

    print("MeshNetworkService: All transport paths failed for message ${payload.messageId}");
    await _updateMessageStatus(payload.messageId, DeliveryStatus.failed);
  }

  Future<void> sendAck(String endpointId, ChatAckPayload payload) async {
    try {
      await _nearbyService.sendPayload(endpointId, payload.toJson());
    } catch (e) {
      print("MeshNetworkService: Failed to send ACK: $e");
    }
  }

  Future<void> _handleIncomingChatMessage(ChatMessagePayload payload) async {
    print("MeshNetworkService: Processing incoming chat message: ${payload.messageId}");
    
    await _db.isar.writeTxn(() async {
      // 1. Save the message
      final model = ChatMessageModel()
        ..messageId = payload.messageId
        ..roomId = payload.roomId
        ..senderMeshId = payload.senderMeshId
        ..receiverMeshId = payload.receiverMeshId
        ..text = payload.message
        ..timestamp = payload.timestamp
        ..deliveryStatus = DeliveryStatus.delivered
        ..messageType = MessageType.values.firstWhere((e) => e.name == payload.messageType, orElse: () => MessageType.text)
        ..isMine = false
        ..isRead = false
        ..isDelivered = true;
      
      await _db.isar.chatMessageModels.put(model);

      // 2. Update/Create Room
      var room = await _db.isar.chatRoomModels.filter().roomIdEqualTo(payload.roomId).findFirst();
      if (room == null) {
        room = ChatRoomModel()
          ..roomId = payload.roomId
          ..participantMeshIds = [payload.senderMeshId, payload.receiverMeshId]
          ..createdAt = DateTime.now();
      }
      room.lastMessage = payload.message;
      room.lastMessageTime = payload.timestamp;
      room.unreadCount += 1;
      await _db.isar.chatRoomModels.put(room);
    });

    // 3. Send ACK back
    final ackTargetEndpointId = getEndpointForMeshId(payload.senderMeshId);
    if (ackTargetEndpointId != null) {
      final localUser = await _db.isar.onboardingUserModels.where().findFirst();
      final ack = ChatAckPayload(
        messageId: payload.messageId,
        roomId: payload.roomId,
        senderMeshId: localUser?.meshId ?? 'unknown',
      );
      await sendAck(ackTargetEndpointId, ack);
      print("MeshNetworkService: ACK sent to $ackTargetEndpointId");
    } else {
      print("MeshNetworkService: Could not send ACK, no active endpoint for ${payload.senderMeshId}");
    }
    
    print("MeshNetworkService: Incoming message saved and processed.");
  }

  Future<void> _handleIncomingAck(ChatAckPayload payload) async {
    print("MeshNetworkService: Received ACK for message ${payload.messageId}");
    await _updateMessageStatus(payload.messageId, DeliveryStatus.delivered);
  }

  void _handleIncomingTyping(ChatTypingPayload payload) {
    print("MeshNetworkService: Typing event from ${payload.senderMeshId}: ${payload.isTyping}");
    // TODO: Publish to a reactive state for UI
  }

  Future<void> _updateMessageStatus(String messageId, DeliveryStatus status) async {
    await _db.isar.writeTxn(() async {
      final msg = await _db.isar.chatMessageModels.filter().messageIdEqualTo(messageId).findFirst();
      if (msg != null) {
        msg.deliveryStatus = status;
        if (status == DeliveryStatus.delivered) {
          msg.isDelivered = true;
        }
        await _db.isar.chatMessageModels.put(msg);
      }
    });
  }

  Future<void> startMesh() async {
    print("MeshNetworkService: Starting Hybrid Mesh...");
    isScanning.value = true;
    globalState.value = MeshConnectionState.discovering;
    
    // Start node server
    await _nodeServer.startServer();
    
    // Update LAN service with the actual bound port
    _lanService.setNodePort(_nodeServer.port);
    
    // Start LAN Discovery (UDP)
    await _lanService.startDiscovery();
    
    // Start BLE Nearby (Google Nearby Connections)
    await _nearbyService.startMesh();
  }

  Future<void> stopMesh() async {
    print("MeshNetworkService: Stopping Hybrid Mesh...");
    isScanning.value = false;
    globalState.value = MeshConnectionState.idle;
    
    await _nearbyService.stopMesh();
    await _lanService.stopDiscovery();
    await _nodeServer.stopServer();
  }
  
  void _setupIsarWatcher() {
    _db.isar.nearbyUserModels.where().watch().listen((users) {
      final active = users.where((u) => u.isOnline).toList();
      activeNearbyUsers.assignAll(active);
      _updateStats(active);
    });
  }

  void _updateStats(List<NearbyUserModel> activeUsers) {
    if (activeUsers.isEmpty) {
      avgSignalStrength.value = 0.0;
    } else {
      final total = activeUsers.fold<double>(0, (sum, u) => sum + (u.signalStrength ?? 0));
      avgSignalStrength.value = total / activeUsers.length;
    }
  }

  void _handleLanPeerDiscovered(Map<String, dynamic> data) async {
    final meshId = data['meshId'];
    final ip = data['ip'];
    final port = data['port'];
    
    // Check if we already have them online via LAN
    final existing = await _db.isar.nearbyUserModels.filter().meshIdEqualTo(meshId).findFirst();
    if (existing != null && existing.isOnline && existing.discoverySource == 'lan') {
      // Just update heartbeat
      await _db.isar.writeTxn(() async {
        existing.lastHeartbeat = DateTime.now();
        existing.ipAddress = ip;
        existing.port = port;
        await _db.isar.nearbyUserModels.put(existing);
      });
      return;
    }
    
    print("MeshNetworkService: Peer discovered via LAN: $meshId at $ip:$port");
    
    // Upsert user
    final user = existing ?? NearbyUserModel();
    user.meshId = meshId;
    user.name = data['username'];
    user.deviceName = data['deviceName'];
    user.ipAddress = ip;
    user.port = port;
    user.discoverySource = 'lan';
    user.connectionType = 'lan';
    user.isOnline = true;
    user.lastSeen = DateTime.now();
    user.lastHeartbeat = DateTime.now();
    user.connectionStatus = MeshConnectionState.connected.name;
    user.connectedAt ??= DateTime.now();
    
    await _db.isar.writeTxn(() async {
      await _db.isar.nearbyUserModels.put(user);
    });
  }

  Future<void> _pollLanHeartbeats() async {
    final allUsers = await _db.isar.nearbyUserModels.where().findAll();
    final lanUsers = allUsers.where((u) => u.isOnline && u.discoverySource == 'lan' && u.ipAddress != null && u.port != null).toList();
    
    for (final user in lanUsers) {
      _checkNodeHeartbeat(user);
    }
  }

  Future<void> _checkNodeHeartbeat(NearbyUserModel user) async {
    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 3);
      final request = await client.getUrl(Uri.parse('http://${user.ipAddress}:${user.port}/heartbeat'));
      final response = await request.close();
      
      if (response.statusCode == 200) {
        // Heartbeat ok
        await _db.isar.writeTxn(() async {
          final dbUser = await _db.isar.nearbyUserModels.get(user.id);
          if (dbUser != null) {
            dbUser.lastHeartbeat = DateTime.now();
            dbUser.lastSeen = DateTime.now();
            await _db.isar.nearbyUserModels.put(dbUser);
          }
        });
      }
    } catch (e) {
      // Heartbeat failed, let cleanup timer handle it
      // print("MeshNetworkService: Heartbeat check failed for ${user.meshId}: $e");
    }
  }

  Future<void> _cleanupStaleUsers() async {
    final now = DateTime.now();
    final allUsers = await _db.isar.nearbyUserModels.where().findAll();
    final users = allUsers.where((u) => u.isOnline).toList();
    final toUpdate = <NearbyUserModel>[];

    for (final user in users) {
      final lastInteraction = user.lastHeartbeat ?? user.lastSeen ?? user.connectedAt;
      if (lastInteraction == null || now.difference(lastInteraction).inSeconds > heartbeatTimeout) {
        print("MeshNetworkService: Peer offline removed: ${user.meshId}");
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
  }
}
