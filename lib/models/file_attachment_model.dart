import 'package:isar/isar.dart';

part 'file_attachment_model.g.dart';

enum AttachmentType { text, image, video, document, audio }
enum TransferStatus { preparing, uploading, transferring, completed, failed, cancelled }

@collection
class FileAttachmentModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String transferSessionId;

  String? localPath;
  String? tempPath;
  late String fileName;
  late int fileSize;
  late String mimeType;
  
  late String fileHash;
  
  late int chunkCount;
  late int transferredChunks;
  
  @enumerated
  late TransferStatus transferStatus;

  late double transferProgress;

  int? previewWidth;
  int? previewHeight;

  FileAttachmentModel();
}