import 'package:isar/isar.dart';

part 'activity_model.g.dart';

@collection
class ActivityModel {
  Id id = Isar.autoIncrement;

  String? title;
  String? subtitle;
  String? timeAgo;
  String? iconType; // e.g., 'file', 'user', 'message'
  int? badgeCount;
  List<String>? imagePreviews;
}
