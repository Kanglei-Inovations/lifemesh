import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatDetailController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var aiSuggestions = <String>["I'll relay that.", "Signal is strong.", "Meeting at the node?"].obs;
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMockMessages();
  }

  void loadMockMessages() {
    messages.value = [
      ChatMessage(
        text: "Are you connected to the Sector 4 relay?",
        isMe: false,
        time: "10:05 AM",
        status: MessageStatus.received,
      ),
      ChatMessage(
        text: "Yes, just joined. The throughput is around 2MB/s.",
        isMe: true,
        time: "10:06 AM",
        status: MessageStatus.read,
      ),
      ChatMessage(
        text: "Great. Can you relay the encrypted packet I just sent?",
        isMe: false,
        time: "10:07 AM",
        status: MessageStatus.received,
      ),
    ];
  }

  void sendMessage(String text) {
    if (text.isEmpty) return;
    messages.add(ChatMessage(
      text: text,
      isMe: true,
      time: "Now",
      status: MessageStatus.sending,
    ));
    textController.clear();
    
    // Simulate message sent
    Future.delayed(const Duration(seconds: 1), () {
      final index = messages.length - 1;
      messages[index] = ChatMessage(
        text: messages[index].text,
        isMe: true,
        time: "10:08 AM",
        status: MessageStatus.sent,
      );
      messages.refresh();
    });
  }
}

enum MessageStatus { sending, sent, received, read }

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final MessageStatus status;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.status,
  });
}
