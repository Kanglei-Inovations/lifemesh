import 'package:isar/isar.dart';

part 'chat_room_model.g.dart';

@collection
class ChatRoomModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String roomId;

  late List<String> participantMeshIds;

  String? lastMessage;
  DateTime? lastMessageTime;
  int unreadCount = 0;

  @Index()
  late DateTime createdAt;

  ChatRoomModel();
}
