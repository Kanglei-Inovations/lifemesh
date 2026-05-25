import 'package:isar/isar.dart';

part 'chat_message_model.g.dart';

enum MessageType { text, voice, location, image, file }
enum DeliveryStatus { sending, sent, delivered, read, failed }

@collection
class ChatMessageModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String messageId;

  @Index()
  late String roomId;

  @Index()
  late String senderMeshId;

  @Index()
  late String receiverMeshId;

  late String text;

  @Index()
  late DateTime timestamp;

  @enumerated
  late DeliveryStatus deliveryStatus;

  @enumerated
  late MessageType messageType;

  late bool isMine;
  late bool isRead;
  late bool isDelivered;

  String? endpointId;

  ChatMessageModel();
}
