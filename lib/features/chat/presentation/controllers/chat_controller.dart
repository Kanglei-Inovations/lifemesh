import 'package:get/get.dart';

class ChatController extends GetxController {
  var chats = <ChatSummary>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockChats();
  }

  void loadMockChats() {
    chats.value = [
      ChatSummary(
        id: "1",
        name: "Nexus-Alpha",
        lastMessage: "The mesh protocol update is live!",
        time: "2m ago",
        unreadCount: 2,
        isOnline: true,
      ),
      ChatSummary(
        id: "2",
        name: "Cyber_Punk",
        lastMessage: "Can you relay this file to Sector 4?",
        time: "15m ago",
        unreadCount: 0,
        isOnline: true,
      ),
      ChatSummary(
        id: "3",
        name: "Ghost-Node",
        lastMessage: "Understood. Signal strength is nominal.",
        time: "1h ago",
        unreadCount: 0,
        isOnline: false,
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

  ChatSummary({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
  });
}
