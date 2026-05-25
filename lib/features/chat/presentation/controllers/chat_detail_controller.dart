import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum MessageStatus { sending, sent, received, read }
enum MessageType { text, voice, location, image, file }

class MessageReaction {
  final String emoji;
  final int count;
  MessageReaction({required this.emoji, required this.count});
}

class ChatMessage {
  final String? text;
  final bool isMe;
  final String time;
  final MessageStatus status;
  final MessageType type;
  final int meshHops;
  final String? voiceDuration;
  final String? imageUrl;
  final String? fileName;
  final String? fileSize;
  final String? fileType;
  final List<MessageReaction>? reactions;

  ChatMessage({
    this.text,
    required this.isMe,
    required this.time,
    required this.status,
    this.type = MessageType.text,
    this.meshHops = 1,
    this.voiceDuration,
    this.imageUrl,
    this.fileName,
    this.fileSize,
    this.fileType,
    this.reactions,
  });
}

class ChatDetailController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var aiSuggestions = <String>[
    "See you there! 🎉",
    "What time?",
    "Which stage?",
  ].obs;
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    messages.value = [];
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    final now = DateTime.now();
    final timeStr = "${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";

    messages.add(
      ChatMessage(
        text: text.trim(),
        isMe: true,
        time: timeStr,
        status: MessageStatus.sending,
        meshHops: 1,
      ),
    );
    textController.clear();

    // Simulate message flow through mesh
    Future.delayed(const Duration(milliseconds: 500), () {
      final index = messages.length - 1;
      final msg = messages[index];
      messages[index] = ChatMessage(
        text: msg.text,
        isMe: true,
        time: msg.time,
        status: MessageStatus.sent,
        meshHops: 1,
        type: msg.type,
      );
      messages.refresh();
    });
  }
}
