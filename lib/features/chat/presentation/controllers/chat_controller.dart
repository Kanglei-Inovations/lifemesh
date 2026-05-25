import 'package:get/get.dart';

class ChatController extends GetxController {
  var chats = <ChatSummary>[].obs;
  var groups = <GroupSummary>[].obs;
  var nearbyUsers = <NearbyMeshUser>[].obs;
  var selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadMockChats();
    loadMockGroups();
    loadMockNearby();
  }

  void loadMockChats() {
    chats.value = [];
  }

  void loadMockGroups() {
    groups.value = [];
  }

  void loadMockNearby() {
    nearbyUsers.value = [];
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
