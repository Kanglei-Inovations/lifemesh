import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database_service.dart';
import '../../../../core/services/mesh_network_service.dart';
import '../../../../core/network/payloads/chat_payloads.dart';
import '../../../../models/chat_message_model.dart';
import '../../../../models/chat_room_model.dart';
import '../../../../models/nearby_user_model.dart';
import '../../../../models/onboarding_user_model.dart';

class ChatDetailController extends GetxController {
  final DatabaseService _db = Get.find<DatabaseService>();
  final MeshNetworkService _meshService = Get.find<MeshNetworkService>();
  
  final String roomId;
  final NearbyUserModel peer;

  ChatDetailController({required this.roomId, required this.peer});

  var messages = <ChatMessageModel>[].obs;
  var aiSuggestions = <String>[
    "See you there! 🎉",
    "What time?",
    "Which stage?",
  ].obs;
  final TextEditingController textController = TextEditingController();
  
  StreamSubscription? _messageSubscription;

  @override
  void onInit() {
    super.onInit();
    _setupMessageWatcher();
    _markAsRead();
  }

  @override
  void onClose() {
    _messageSubscription?.cancel();
    super.onClose();
  }

  void _setupMessageWatcher() {
    _messageSubscription = _db.isar.chatMessageModels
        .filter()
        .roomIdEqualTo(roomId)
        .sortByTimestamp()
        .watch(fireImmediately: true)
        .listen((data) {
          messages.assignAll(data);
        });
  }

  Future<void> _markAsRead() async {
    final unread = await _db.isar.chatMessageModels
        .filter()
        .roomIdEqualTo(roomId)
        .isReadEqualTo(false)
        .isMineEqualTo(false)
        .findAll();
    
    if (unread.isNotEmpty) {
      await _db.isar.writeTxn(() async {
        for (var msg in unread) {
          msg.isRead = true;
        }
        await _db.isar.chatMessageModels.putAll(unread);
        
        // Update room unread count
        final room = await _db.isar.chatRoomModels.filter().roomIdEqualTo(roomId).findFirst();
        if (room != null) {
          room.unreadCount = 0;
          await _db.isar.chatRoomModels.put(room);
        }
      });
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    
    final localUser = await _db.isar.onboardingUserModels.where().findFirst();
    if (localUser == null || localUser.meshId == null) {
      print("ChatDetailController: Local user or MeshID is null. Cannot send message.");
      return;
    }

    if (peer.meshId == null) {
      print("ChatDetailController: Peer MeshID is null. Cannot send message.");
      return;
    }

    final messageId = const Uuid().v4();
    final now = DateTime.now();

    print("ChatDetailController: Attempting to send message $messageId");
    print("ChatDetailController: Sender MeshID: ${localUser.meshId}");
    print("ChatDetailController: Receiver MeshID: ${peer.meshId}");
    print("ChatDetailController: Room ID: $roomId");

    // 1. Save locally first (status: sending)
    final model = ChatMessageModel()
      ..messageId = messageId
      ..roomId = roomId
      ..senderMeshId = localUser.meshId!
      ..receiverMeshId = peer.meshId!
      ..text = text.trim()
      ..timestamp = now
      ..deliveryStatus = DeliveryStatus.sending
      ..messageType = MessageType.text
      ..isMine = true
      ..isRead = true
      ..isDelivered = false
      ..endpointId = peer.endpointId;

    await _db.isar.writeTxn(() async {
      await _db.isar.chatMessageModels.put(model);
      
      // Update room
      var room = await _db.isar.chatRoomModels.filter().roomIdEqualTo(roomId).findFirst();
      if (room != null) {
        room.lastMessage = text.trim();
        room.lastMessageTime = now;
        await _db.isar.chatRoomModels.put(room);
      }
    });

    textController.clear();

    // 2. Transmit via Mesh
    // Resolve fresh endpoint from service instead of relying on stale constructor peer
    final activeEndpointId = _meshService.getEndpointForMeshId(peer.meshId!);
    print("ChatDetailController: Resolved active endpoint ID: $activeEndpointId");

    // Check if we have ANY way to reach them (Nearby or LAN)
    final peerInDb = await _db.isar.nearbyUserModels.filter().meshIdEqualTo(peer.meshId!).findFirst();
    final hasLanFallback = peerInDb != null && peerInDb.ipAddress != null && peerInDb.port != null;
    
    if (activeEndpointId == null && !hasLanFallback) {
      print("ChatDetailController: Peer offline and no LAN fallback. Showing UI warning.");
      Get.snackbar(
        'User Offline',
        '${peer.name ?? "User"} is currently offline. Message will be sent when they reconnect.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.1),
        colorText: Colors.white,
      );
      await _updateStatus(messageId, DeliveryStatus.failed);
      return;
    }

    final payload = ChatMessagePayload(
      messageId: messageId,
      roomId: roomId,
      senderMeshId: localUser.meshId!,
      receiverMeshId: peer.meshId!,
      message: text.trim(),
      timestamp: now,
      messageType: 'text',
      deviceTimestamp: now.toIso8601String(),
    );
    
    await _meshService.sendChatMessage(
      endpointId: activeEndpointId,
      payload: payload,
    );
  }

  Future<void> _updateStatus(String messageId, DeliveryStatus status) async {
    await _db.isar.writeTxn(() async {
      final msg = await _db.isar.chatMessageModels.filter().messageIdEqualTo(messageId).findFirst();
      if (msg != null) {
        msg.deliveryStatus = status;
        await _db.isar.chatMessageModels.put(msg);
      }
    });
  }
}
