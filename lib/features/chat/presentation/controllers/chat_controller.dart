import 'dart:async';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import '../../../../core/database_service.dart';
import '../../../../core/services/mesh_network_service.dart';
import '../../../../models/chat_room_model.dart';
import '../../../../models/nearby_user_model.dart';

class ChatController extends GetxController {
  final DatabaseService _db = Get.find<DatabaseService>();
  final MeshNetworkService _meshService = Get.find<MeshNetworkService>();

  var chats = <ChatRoomModel>[].obs;
  var groups = <GroupSummary>[].obs;
  var nearbyUsers = <NearbyUserModel>[].obs;
  var selectedTab = 0.obs;

  StreamSubscription? _chatSubscription;
  StreamSubscription? _nearbySubscription;

  @override
  void onInit() {
    super.onInit();
    _setupWatchers();
  }

  @override
  void onClose() {
    _chatSubscription?.cancel();
    _nearbySubscription?.cancel();
    super.onClose();
  }

  void _setupWatchers() {
    _chatSubscription = _db.isar.chatRoomModels
        .where()
        .sortByLastMessageTimeDesc()
        .watch(fireImmediately: true)
        .listen((data) {
          chats.assignAll(data);
        });

    _nearbySubscription = _db.isar.nearbyUserModels
        .filter()
        .isOnlineEqualTo(true)
        .watch(fireImmediately: true)
        .listen((data) {
          nearbyUsers.assignAll(data);
        });
  }
}

class ChatSummary {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isWaiting;
  final String distance;
  final bool isDirect;
  final bool isMuted;
  final String? avatar;

  ChatSummary({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    this.isOnline = false,
    this.isWaiting = false,
    this.distance = "",
    this.isDirect = true,
    this.isMuted = false,
    this.avatar,
  });
}

class GroupSummary {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final int memberCount;
  final String status;
  final bool isMuted;

  GroupSummary({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.memberCount,
    required this.status,
    this.isMuted = false,
  });
}

class NearbyMeshUser {
  final String id;
  final String name;
  final String meshId;
  final String distance;
  final String connectionType;
  final int signalStrength;
  final String signalLabel;
  final String statusBadge;

  NearbyMeshUser({
    required this.id,
    required this.name,
    required this.meshId,
    required this.distance,
    required this.connectionType,
    required this.signalStrength,
    required this.signalLabel,
    required this.statusBadge,
  });
}
