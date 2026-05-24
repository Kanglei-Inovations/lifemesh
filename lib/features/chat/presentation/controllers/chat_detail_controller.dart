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
    loadMockMessages();
  }

  void loadMockMessages() {
    messages.value = [
      ChatMessage(
        text: "Hey! Are you coming to the fest tonight?",
        isMe: false,
        time: "2:47 PM",
        status: MessageStatus.received,
        meshHops: 2,
      ),
      ChatMessage(
        text: "Yes! I'll be there.",
        isMe: true,
        time: "2:48 PM",
        status: MessageStatus.read,
        meshHops: 1,
      ),
      ChatMessage(
        isMe: false,
        time: "2:49 PM",
        status: MessageStatus.received,
        type: MessageType.voice,
        voiceDuration: "0:18",
        meshHops: 3,
      ),
      ChatMessage(
        isMe: true,
        time: "2:50 PM",
        status: MessageStatus.read,
        type: MessageType.location,
        meshHops: 2,
      ),
      ChatMessage(
        isMe: false,
        time: "2:51 PM",
        status: MessageStatus.received,
        type: MessageType.image,
        imageUrl: "https://example.com/fest.jpg",
        meshHops: 2,
      ),
      ChatMessage(
        isMe: true,
        time: "2:52 PM",
        status: MessageStatus.read,
        type: MessageType.file,
        fileName: "DJ_Night_Setlist.pdf",
        fileSize: "2.4 MB",
        fileType: "PDF",
        meshHops: 1,
      ),
      ChatMessage(
        text: "Nice! 🔥",
        isMe: false,
        time: "2:52 PM",
        status: MessageStatus.received,
        meshHops: 2,
        reactions: [MessageReaction(emoji: "❤️", count: 1)],
      ),
    ];
  }

  void sendMessage(String text) {
    if (text.isEmpty) return;
    messages.add(
      ChatMessage(
        text: text,
        isMe: true,
        time: "2:53 PM",
        status: MessageStatus.sending,
        meshHops: 1,
      ),
    );
    textController.clear();

    // Simulate message sent
    Future.delayed(const Duration(seconds: 1), () {
      final index = messages.length - 1;
      messages[index] = ChatMessage(
        text: messages[index].text,
        isMe: true,
        time: "2:53 PM",
        status: MessageStatus.sent,
        meshHops: 1,
      );
      messages.refresh();
    });
  }
}
