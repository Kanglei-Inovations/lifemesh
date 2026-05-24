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
    chats.value = [
      ChatSummary(
        id: "1",
        name: "Rahul Kumar",
        lastMessage: "Hey! Are you coming to the fest tonight?",
        time: "2m ago",
        unreadCount: 2,
        isOnline: true,
        distance: "12 m away",
        isDirect: true,
      ),
      ChatSummary(
        id: "2",
        name: "Priya Singh",
        lastMessage: "Shared location",
        time: "5m ago",
        unreadCount: 1,
        isOnline: true,
        distance: "8 m away",
        isDirect: true,
      ),
      ChatSummary(
        id: "3",
        name: "College Friends 🎓",
        lastMessage: "Arjun: Party at 6PM at old ground?",
        time: "15m ago",
        unreadCount: 5,
        isOnline: false,
        distance: "12 members",
        isDirect: false,
        isMuted: true,
      ),
      ChatSummary(
        id: "4",
        name: "Project Team",
        lastMessage: "Neha: File received ✅",
        time: "30m ago",
        unreadCount: 2,
        isOnline: false,
        distance: "6 members",
        isDirect: false,
      ),
    ];
  }

  void loadMockGroups() {
    groups.value = [
      GroupSummary(
        id: "g1",
        name: "College Friends 🎓",
        lastMessage: "Arjun: Party at 6PM at old ground?",
        time: "2m ago",
        unreadCount: 5,
        memberCount: 12,
        status: "Active now",
        isMuted: true,
      ),
      GroupSummary(
        id: "g2",
        name: "Project Team",
        lastMessage: "Neha: File received ✅",
        time: "15m ago",
        unreadCount: 2,
        memberCount: 6,
        status: "Active now",
      ),
      GroupSummary(
        id: "g3",
        name: "Event Committee 📢",
        lastMessage: "Rohit: New announcement!",
        time: "30m ago",
        unreadCount: 3,
        memberCount: 9,
        status: "Active 5m ago",
      ),
      GroupSummary(
        id: "g4",
        name: "Gaming Squad 🎮",
        lastMessage: "Dev: Who's online tonight?",
        time: "45m ago",
        unreadCount: 1,
        memberCount: 5,
        status: "Active now",
      ),
      GroupSummary(
        id: "g5",
        name: "Buy & Sell 🛍️",
        lastMessage: "Priya: New product added",
        time: "1h ago",
        unreadCount: 4,
        memberCount: 18,
        status: "Active 10m ago",
      ),
      GroupSummary(
        id: "g6",
        name: "Family Group 👨‍👩‍👧‍👦",
        lastMessage: "Mom: Dinner at 8PM",
        time: "2h ago",
        unreadCount: 2,
        memberCount: 7,
        status: "Active 1h ago",
      ),
    ];
  }

  void loadMockNearby() {
    nearbyUsers.value = [
      NearbyMeshUser(
        id: "n1",
        name: "Rahul Kumar",
        meshId: "YVDV-A7F3",
        distance: "12 m away",
        connectionType: "Direct",
        signalStrength: 82,
        signalLabel: "Strong",
        statusBadge: "Connected",
      ),
      NearbyMeshUser(
        id: "n2",
        name: "Priya Singh",
        meshId: "UH9K-L2B1",
        distance: "15 m away",
        connectionType: "Direct",
        signalStrength: 74,
        signalLabel: "Strong",
        statusBadge: "Direct",
      ),
      NearbyMeshUser(
        id: "n3",
        name: "Arjun Dev",
        meshId: "X9PL-M0D2",
        distance: "25 m away",
        connectionType: "Wi-Fi Direct",
        signalStrength: 56,
        signalLabel: "Medium",
        statusBadge: "Discovering",
      ),
      NearbyMeshUser(
        id: "n4",
        name: "Neha Verma",
        meshId: "QW2E-P8K7",
        distance: "30 m away",
        connectionType: "Bluetooth LE",
        signalStrength: 32,
        signalLabel: "Weak",
        statusBadge: "New",
      ),
      NearbyMeshUser(
        id: "n5",
        name: "Dev Mehta",
        meshId: "D2FK-J7H8",
        distance: "22 m away",
        connectionType: "Direct",
        signalStrength: 68,
        signalLabel: "Strong",
        statusBadge: "Direct",
      ),
    ];
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
