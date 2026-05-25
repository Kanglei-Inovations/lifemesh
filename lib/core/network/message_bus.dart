import 'dart:async';
import 'package:get/get.dart';
import 'payloads/chat_payloads.dart';

class MessageBus extends GetxService {
  final _incomingChatController = StreamController<ChatMessagePayload>.broadcast();
  final _incomingAckController = StreamController<ChatAckPayload>.broadcast();
  final _incomingTypingController = StreamController<ChatTypingPayload>.broadcast();

  Stream<ChatMessagePayload> get incomingChatMessages => _incomingChatController.stream;
  Stream<ChatAckPayload> get incomingAcks => _incomingAckController.stream;
  Stream<ChatTypingPayload> get incomingTypingEvents => _incomingTypingController.stream;

  void publishChatMessage(ChatMessagePayload payload) {
    _incomingChatController.add(payload);
  }

  void publishAck(ChatAckPayload payload) {
    _incomingAckController.add(payload);
  }

  void publishTyping(ChatTypingPayload payload) {
    _incomingTypingController.add(payload);
  }

  @override
  void onClose() {
    _incomingChatController.close();
    _incomingAckController.close();
    _incomingTypingController.close();
    super.onClose();
  }
}
