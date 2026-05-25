import 'dart:convert';
import 'dart:typed_data';

class FileTransferStartPayload {
  final String messageId;
  final String transferSessionId;
  final String fileName;
  final int fileSize;
  final int totalChunks;
  final String mimeType;
  final String fileHash;
  final String senderMeshId;
  final String receiverMeshId;
  final String roomId;

  FileTransferStartPayload({
    required this.messageId,
    required this.transferSessionId,
    required this.fileName,
    required this.fileSize,
    required this.totalChunks,
    required this.mimeType,
    required this.fileHash,
    required this.senderMeshId,
    required this.receiverMeshId,
    required this.roomId,
  });

  Map<String, dynamic> toJson() => {
        'type': 'lifemesh.file.start.v1',
        'messageId': messageId,
        'transferSessionId': transferSessionId,
        'fileName': fileName,
        'fileSize': fileSize,
        'totalChunks': totalChunks,
        'mimeType': mimeType,
        'fileHash': fileHash,
        'senderMeshId': senderMeshId,
        'receiverMeshId': receiverMeshId,
        'roomId': roomId,
      };

  factory FileTransferStartPayload.fromJson(Map<String, dynamic> json) {
    return FileTransferStartPayload(
      messageId: json['messageId'],
      transferSessionId: json['transferSessionId'],
      fileName: json['fileName'],
      fileSize: json['fileSize'],
      totalChunks: json['totalChunks'],
      mimeType: json['mimeType'],
      fileHash: json['fileHash'],
      senderMeshId: json['senderMeshId'],
      receiverMeshId: json['receiverMeshId'],
      roomId: json['roomId'],
    );
  }
}

class FileChunkPayload {
  final String transferSessionId;
  final int chunkIndex;
  final Uint8List chunkData;

  FileChunkPayload({
    required this.transferSessionId,
    required this.chunkIndex,
    required this.chunkData,
  });

  // Binary Serialization for raw byte transfer
  // Format: [MagicByte(0x02)] + [SessionIdLength(1 byte)] + [SessionIdBytes] + [ChunkIndex(4 bytes)] + [ChunkData]
  Uint8List toBytes() {
    final sessionBytes = utf8.encode(transferSessionId);
    final buffer = BytesBuilder();
    buffer.addByte(0x02); // Magic byte for chunk
    buffer.addByte(sessionBytes.length);
    buffer.add(sessionBytes);
    
    // 4-byte chunk index
    final indexData = ByteData(4);
    indexData.setUint32(0, chunkIndex, Endian.big);
    buffer.add(indexData.buffer.asUint8List());
    
    // Raw chunk
    buffer.add(chunkData);
    
    return buffer.toBytes();
  }

  static FileChunkPayload? fromBytes(Uint8List bytes) {
    try {
      if (bytes.isEmpty || bytes[0] != 0x02) return null;
      
      int offset = 1;
      final sessionLength = bytes[offset++];
      final sessionBytes = bytes.sublist(offset, offset + sessionLength);
      final sessionId = utf8.decode(sessionBytes);
      offset += sessionLength;
      
      final indexData = ByteData.sublistView(bytes, offset, offset + 4);
      final index = indexData.getUint32(0, Endian.big);
      offset += 4;
      
      final chunkData = bytes.sublist(offset);
      
      return FileChunkPayload(
        transferSessionId: sessionId,
        chunkIndex: index,
        chunkData: chunkData,
      );
    } catch (e) {
      return null;
    }
  }
}

class FileTransferAckPayload {
  final String transferSessionId;
  final int chunkIndex;
  final String status; // 'received', 'completed', 'failed'

  FileTransferAckPayload({
    required this.transferSessionId,
    required this.chunkIndex,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'type': 'lifemesh.file.ack.v1',
        'transferSessionId': transferSessionId,
        'chunkIndex': chunkIndex,
        'status': status,
      };

  factory FileTransferAckPayload.fromJson(Map<String, dynamic> json) {
    return FileTransferAckPayload(
      transferSessionId: json['transferSessionId'],
      chunkIndex: json['chunkIndex'],
      status: json['status'],
    );
  }
}