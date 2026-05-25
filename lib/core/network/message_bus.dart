import 'dart:async';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'payloads/chat_payloads.dart';
import 'payloads/file_payloads.dart';

class MessageBus extends GetxService {
  final _incomingChatController = StreamController<ChatMessagePayload>.broadcast();
  final _incomingAckController = StreamController<ChatAckPayload>.broadcast();
  final _incomingTypingController = StreamController<ChatTypingPayload>.broadcast();
  
  // File Transfer Streams
  final _incomingFileStartController = StreamController<FileTransferStartPayload>.broadcast();
  final _incomingFileChunkController = StreamController<FileChunkPayload>.broadcast();
  final _incomingFileAckController = StreamController<FileTransferAckPayload>.broadcast();

  Stream<ChatMessagePayload> get incomingChatMessages => _incomingChatController.stream;
  Stream<ChatAckPayload> get incomingAcks => _incomingAckController.stream;
  Stream<ChatTypingPayload> get incomingTypingEvents => _incomingTypingController.stream;
  
  Stream<FileTransferStartPayload> get incomingFileStarts => _incomingFileStartController.stream;
  Stream<FileChunkPayload> get incomingFileChunks => _incomingFileChunkController.stream;
  Stream<FileTransferAckPayload> get incomingFileAcks => _incomingFileAckController.stream;

  void publishChatMessage(ChatMessagePayload payload) {
    _incomingChatController.add(payload);
  }

  void publishAck(ChatAckPayload payload) {
    _incomingAckController.add(payload);
  }

  void publishTyping(ChatTypingPayload payload) {
    _incomingTypingController.add(payload);
  }

  void publishFileStart(FileTransferStartPayload payload) {
    _incomingFileStartController.add(payload);
  }

  void publishFileChunk(FileChunkPayload payload) {
    _incomingFileChunkController.add(payload);
  }

  void publishFileAck(FileTransferAckPayload payload) {
    _incomingFileAckController.add(payload);
  }

  @override
  void onClose() {
    _incomingChatController.close();
    _incomingAckController.close();
    _incomingTypingController.close();
    _incomingFileStartController.close();
    _incomingFileChunkController.close();
    _incomingFileAckController.close();
    super.onClose();
  }
}

