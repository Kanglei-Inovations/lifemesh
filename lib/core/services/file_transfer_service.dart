import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../database_service.dart';
import 'mesh_network_service.dart';
import '../network/message_bus.dart';
import '../network/payloads/file_payloads.dart';
import '../../models/file_attachment_model.dart';
import '../../models/chat_message_model.dart';

class FileTransferService extends GetxService {
  final DatabaseService _db = Get.find<DatabaseService>();
  final MessageBus _messageBus = Get.find<MessageBus>();
  
  // We cannot inject MeshNetworkService immediately if it depends on us, 
  // but we can look it up lazily to avoid circular dependency.
  MeshNetworkService get _meshService => Get.find<MeshNetworkService>();

  final List<StreamSubscription> _busSubscriptions = [];

  // Active transfer trackers
  final Map<String, _ActiveSendSession> _activeSends = {};
  final Map<String, _ActiveReceiveSession> _activeReceives = {};

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  @override
  void onClose() {
    for (var sub in _busSubscriptions) {
      sub.cancel();
    }
    for (var session in _activeSends.values) {
      session.cancel();
    }
    super.onClose();
  }

  void _setupListeners() {
    _busSubscriptions.add(_messageBus.incomingFileStarts.listen(_handleIncomingFileStart));
    _busSubscriptions.add(_messageBus.incomingFileChunks.listen(_handleIncomingFileChunk));
    _busSubscriptions.add(_messageBus.incomingFileAcks.listen(_handleIncomingFileAck));
  }

  // Adaptive chunk sizes based on transport capability
  // BLE typically handles smaller chunks better. LAN can handle large.
  static const int _bleChunkSize = 32 * 1024; // 32KB
  static const int _lanChunkSize = 128 * 1024; // 128KB

  /// Initiates a file transfer. Calculates hash asynchronously, creates models, and queues transfer.
  Future<void> startFileTransfer({
    required String filePath,
    required String fileName,
    required String mimeType,
    required String roomId,
    required String receiverMeshId,
    required String senderMeshId,
    required MessageType messageType,
  }) async {
    print("FileTransferService: Preparing transfer for $fileName");
    final file = File(filePath);
    if (!await file.exists()) {
      print("FileTransferService: File does not exist at $filePath");
      return;
    }

    final fileSize = await file.length();
    final transferSessionId = 'ts_${DateTime.now().millisecondsSinceEpoch}_${fileName.hashCode}';
    final messageId = 'msg_${DateTime.now().millisecondsSinceEpoch}';

    // Hash file in background to avoid blocking UI
    final fileHash = await _calculateFileHash(filePath);
    print("FileTransferService: Hash calculated for $fileName - $fileHash");

    // Determine chunk size (naive assumption here, mesh network service will adapt based on actual transport)
    // For counting chunks, we use the smaller size as a baseline or agree on a fixed logical chunk size,
    // and transport can aggregate them, or we just stick to 32KB logical chunks.
    final chunkSize = _bleChunkSize; 
    final totalChunks = (fileSize / chunkSize).ceil();

    final attachment = FileAttachmentModel()
      ..transferSessionId = transferSessionId
      ..localPath = filePath
      ..fileName = fileName
      ..fileSize = fileSize
      ..mimeType = mimeType
      ..fileHash = fileHash
      ..chunkCount = totalChunks
      ..transferredChunks = 0
      ..transferStatus = TransferStatus.preparing
      ..transferProgress = 0.0;

    final message = ChatMessageModel()
      ..messageId = messageId
      ..roomId = roomId
      ..senderMeshId = senderMeshId
      ..receiverMeshId = receiverMeshId
      ..text = "Sent a file" // Fallback text
      ..timestamp = DateTime.now()
      ..deliveryStatus = DeliveryStatus.sending
      ..messageType = messageType
      ..isMine = true
      ..isRead = true
      ..isDelivered = false;

    // Save to DB
    await _db.isar.writeTxn(() async {
      final attachmentId = await _db.isar.fileAttachmentModels.put(attachment);
      message.attachmentId = attachmentId;
      await _db.isar.chatMessageModels.put(message);
    });

    // Create Start Payload
    final startPayload = FileTransferStartPayload(
      messageId: messageId,
      transferSessionId: transferSessionId,
      fileName: fileName,
      fileSize: fileSize,
      totalChunks: totalChunks,
      mimeType: mimeType,
      fileHash: fileHash,
      senderMeshId: senderMeshId,
      receiverMeshId: receiverMeshId,
      roomId: roomId,
    );

    // Register active send session
    final session = _ActiveSendSession(
      sessionId: transferSessionId,
      file: file,
      chunkSize: chunkSize,
      totalChunks: totalChunks,
      receiverMeshId: receiverMeshId,
      onProgress: (progress, chunks) => _updateSendProgress(transferSessionId, progress, chunks),
      onComplete: () => _handleSendComplete(transferSessionId, messageId),
      onError: (e) => _handleSendError(transferSessionId, messageId, e),
      meshService: _meshService,
    );
    _activeSends[transferSessionId] = session;

    // Send the start payload via Priority Queue in MeshNetworkService
    await _meshService.sendPriorityPayload(
      receiverMeshId: receiverMeshId, 
      payload: startPayload.toJson(), 
      priority: 1 // High priority for control messages
    );
    
    print("FileTransferService: Start payload sent for $fileName. Waiting for ACK to begin chunk stream.");
    // Note: Actual chunk sending begins when the receiver ACKs the start payload.
  }

  // Calculate SHA256 in a background isolate/thread
  Future<String> _calculateFileHash(String filePath) async {
    final file = File(filePath);
    final hash = await sha256.bind(file.openRead()).first;
    return hash.toString();
  }

  Future<void> _updateSendProgress(String sessionId, double progress, int chunks) async {
    final attachment = await _db.isar.fileAttachmentModels.filter().transferSessionIdEqualTo(sessionId).findFirst();
    if (attachment != null) {
      attachment.transferProgress = progress;
      attachment.transferredChunks = chunks;
      attachment.transferStatus = TransferStatus.uploading;
      await _db.isar.writeTxn(() async {
        await _db.isar.fileAttachmentModels.put(attachment);
      });
    }
  }

  Future<void> _handleSendComplete(String sessionId, String messageId) async {
    print("FileTransferService: Send completed for session $sessionId");
    _activeSends.remove(sessionId);
    await _db.isar.writeTxn(() async {
      final attachment = await _db.isar.fileAttachmentModels.filter().transferSessionIdEqualTo(sessionId).findFirst();
      if (attachment != null) {
        attachment.transferStatus = TransferStatus.completed;
        attachment.transferProgress = 1.0;
        await _db.isar.fileAttachmentModels.put(attachment);
      }
      final msg = await _db.isar.chatMessageModels.filter().messageIdEqualTo(messageId).findFirst();
      if (msg != null) {
        msg.deliveryStatus = DeliveryStatus.sent;
        await _db.isar.chatMessageModels.put(msg);
      }
    });
  }

  Future<void> _handleSendError(String sessionId, String messageId, String error) async {
    print("FileTransferService: Send failed for session $sessionId - $error");
    _activeSends.remove(sessionId);
    await _db.isar.writeTxn(() async {
      final attachment = await _db.isar.fileAttachmentModels.filter().transferSessionIdEqualTo(sessionId).findFirst();
      if (attachment != null) {
        attachment.transferStatus = TransferStatus.failed;
        await _db.isar.fileAttachmentModels.put(attachment);
      }
      final msg = await _db.isar.chatMessageModels.filter().messageIdEqualTo(messageId).findFirst();
      if (msg != null) {
        msg.deliveryStatus = DeliveryStatus.failed;
        await _db.isar.chatMessageModels.put(msg);
      }
    });
  }

  // --- RECEIVER LOGIC ---

  Future<void> _handleIncomingFileStart(FileTransferStartPayload payload) async {
    print("FileTransferService: Received start payload for ${payload.fileName}");
    
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${payload.transferSessionId}.tmp');

    // Create db models
    final attachment = FileAttachmentModel()
      ..transferSessionId = payload.transferSessionId
      ..tempPath = tempFile.path
      ..fileName = payload.fileName
      ..fileSize = payload.fileSize
      ..mimeType = payload.mimeType
      ..fileHash = payload.fileHash
      ..chunkCount = payload.totalChunks
      ..transferredChunks = 0
      ..transferStatus = TransferStatus.transferring
      ..transferProgress = 0.0;

    final messageType = _getMessageTypeFromMime(payload.mimeType);

    final message = ChatMessageModel()
      ..messageId = payload.messageId
      ..roomId = payload.roomId
      ..senderMeshId = payload.senderMeshId
      ..receiverMeshId = payload.receiverMeshId
      ..text = "File: ${payload.fileName}"
      ..timestamp = DateTime.now() // Use device timestamp for received time
      ..deliveryStatus = DeliveryStatus.delivered
      ..messageType = messageType
      ..isMine = false
      ..isRead = false
      ..isDelivered = true;

    await _db.isar.writeTxn(() async {
      final attachmentId = await _db.isar.fileAttachmentModels.put(attachment);
      message.attachmentId = attachmentId;
      await _db.isar.chatMessageModels.put(message);
    });

    final session = _ActiveReceiveSession(
      sessionId: payload.transferSessionId,
      tempFile: tempFile,
      totalChunks: payload.totalChunks,
      expectedHash: payload.fileHash,
      fileName: payload.fileName,
    );
    _activeReceives[payload.transferSessionId] = session;

    // ACK the start payload so sender begins chunking
    final ack = FileTransferAckPayload(
      transferSessionId: payload.transferSessionId, 
      chunkIndex: -1, // -1 means start acknowledged
      status: 'received'
    );
    await _meshService.sendPriorityPayload(
      receiverMeshId: payload.senderMeshId, 
      payload: ack.toJson(), 
      priority: 1
    );
  }

  Future<void> _handleIncomingFileChunk(FileChunkPayload payload) async {
    final session = _activeReceives[payload.transferSessionId];
    if (session == null) return; // Ignored if session doesn't exist

    try {
      await session.appendChunk(payload.chunkIndex, payload.chunkData);
      
      // Update local progress
      final progress = session.receivedChunks.length / session.totalChunks;
      await _updateReceiveProgress(payload.transferSessionId, progress, session.receivedChunks.length);

      // Send ACK back for backpressure control
      final ack = FileTransferAckPayload(
        transferSessionId: payload.transferSessionId,
        chunkIndex: payload.chunkIndex,
        status: 'received'
      );
      // Sender Mesh ID would normally be looked up, simplified here for architecture outline
      // In real implementation, the receive session needs to track who sent it.
      
      if (session.isComplete) {
        await _finalizeReceiveSession(payload.transferSessionId);
      }

    } catch (e) {
      print("FileTransferService: Error appending chunk ${payload.chunkIndex} - $e");
    }
  }

  Future<void> _updateReceiveProgress(String sessionId, double progress, int chunks) async {
    final attachment = await _db.isar.fileAttachmentModels.filter().transferSessionIdEqualTo(sessionId).findFirst();
    if (attachment != null) {
      attachment.transferProgress = progress;
      attachment.transferredChunks = chunks;
      await _db.isar.writeTxn(() async {
        await _db.isar.fileAttachmentModels.put(attachment);
      });
    }
  }

  Future<void> _finalizeReceiveSession(String sessionId) async {
    print("FileTransferService: Finalizing receive for session $sessionId");
    final session = _activeReceives.remove(sessionId);
    if (session == null) return;

    // Verify Hash
    final calculatedHash = await _calculateFileHash(session.tempFile.path);
    if (calculatedHash != session.expectedHash) {
      print("FileTransferService: HASH MISMATCH for $sessionId! Expected ${session.expectedHash}, got $calculatedHash");
      // Mark as failed in DB
      return;
    }

    print("FileTransferService: Hash verified successfully.");

    // Move to permanent directory
    final appDir = await getApplicationDocumentsDirectory(); // Or specific LifeMesh/Media folder
    final mediaDir = Directory('${appDir.path}/LifeMesh/Media');
    if (!await mediaDir.exists()) await mediaDir.create(recursive: true);
    
    final finalFile = File('${mediaDir.path}/${session.fileName}');
    await session.tempFile.copy(finalFile.path);
    await session.tempFile.delete();

    // Update DB
    await _db.isar.writeTxn(() async {
      final attachment = await _db.isar.fileAttachmentModels.filter().transferSessionIdEqualTo(sessionId).findFirst();
      if (attachment != null) {
        attachment.localPath = finalFile.path;
        attachment.transferStatus = TransferStatus.completed;
        attachment.transferProgress = 1.0;
        await _db.isar.fileAttachmentModels.put(attachment);
      }
    });
    
    print("FileTransferService: Transfer completed and file saved to ${finalFile.path}");
  }

  void _handleIncomingFileAck(FileTransferAckPayload payload) {
    // Used by sender to manage backpressure
    final session = _activeSends[payload.transferSessionId];
    if (session != null) {
      if (payload.chunkIndex == -1) {
        print("FileTransferService: Start payload ACKed, beginning chunk transmission.");
        session.startSending();
      } else {
        session.ackReceived(payload.chunkIndex);
      }
    }
  }

  MessageType _getMessageTypeFromMime(String mimeType) {
    if (mimeType.startsWith('image/')) return MessageType.image;
    if (mimeType.startsWith('video/')) return MessageType.video;
    return MessageType.document;
  }
}

// Helper class to manage state of an active outgoing transfer
class _ActiveSendSession {
  final String sessionId;
  final File file;
  final int chunkSize;
  final int totalChunks;
  final String receiverMeshId;
  final MeshNetworkService meshService;
  
  final Function(double, int) onProgress;
  final Function() onComplete;
  final Function(String) onError;

  int _currentChunkIndex = 0;
  bool _isSending = false;
  bool _isCancelled = false;
  RandomAccessFile? _raf;

  // Simple backpressure: max un-acked chunks in flight
  static const int _maxInFlight = 5;
  int _inFlightCount = 0;

  _ActiveSendSession({
    required this.sessionId,
    required this.file,
    required this.chunkSize,
    required this.totalChunks,
    required this.receiverMeshId,
    required this.meshService,
    required this.onProgress,
    required this.onComplete,
    required this.onError,
  });

  Future<void> startSending() async {
    if (_isSending || _isCancelled) return;
    _isSending = true;
    try {
      _raf = await file.open(mode: FileMode.read);
      _sendNextChunks();
    } catch (e) {
      onError(e.toString());
    }
  }

  void _sendNextChunks() async {
    if (_isCancelled || _raf == null) return;

    while (_inFlightCount < _maxInFlight && _currentChunkIndex < totalChunks) {
      final index = _currentChunkIndex;
      _currentChunkIndex++;
      _inFlightCount++;

      await _raf!.setPosition(index * chunkSize);
      final bytes = await _raf!.read(chunkSize);
      
      final chunkPayload = FileChunkPayload(
        transferSessionId: sessionId,
        chunkIndex: index,
        chunkData: bytes,
      );

      // We send chunks at lower priority than text messages/heartbeats
      // We need raw payload support in MeshNetworkService for Uint8List
      meshService.sendRawPriorityPayload(
        receiverMeshId: receiverMeshId,
        session: sessionId,
        index: index,
        data: bytes,
        priority: 5 // Lowest priority
      );
    }
  }

  void ackReceived(int chunkIndex) {
    _inFlightCount--;
    onProgress(_currentChunkIndex / totalChunks, _currentChunkIndex);
    
    if (_currentChunkIndex >= totalChunks && _inFlightCount == 0) {
      _finish();
    } else {
      _sendNextChunks();
    }
  }

  Future<void> _finish() async {
    await _raf?.close();
    _raf = null;
    onComplete();
  }

  void cancel() async {
    _isCancelled = true;
    await _raf?.close();
  }
}

// Helper class to manage state of incoming chunks
class _ActiveReceiveSession {
  final String sessionId;
  final File tempFile;
  final int totalChunks;
  final String expectedHash;
  final String fileName;
  
  final Set<int> receivedChunks = {};
  RandomAccessFile? _raf;

  _ActiveReceiveSession({
    required this.sessionId,
    required this.tempFile,
    required this.totalChunks,
    required this.expectedHash,
    required this.fileName,
  });

  Future<void> appendChunk(int index, Uint8List data) async {
    if (receivedChunks.contains(index)) return; // Duplicate
    
    _raf ??= await tempFile.open(mode: FileMode.append); // For simplicity, assumes ordered delivery. 
    // If unordered, use FileMode.write and seek to offset: index * chunkSize.
    
    await _raf!.writeFrom(data);
    receivedChunks.add(index);
  }

  bool get isComplete => receivedChunks.length == totalChunks;

  Future<void> close() async {
    await _raf?.close();
    _raf = null;
  }
}