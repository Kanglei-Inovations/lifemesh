import 'package:isar/isar.dart';

part 'nearby_user_model.g.dart';

@collection
class NearbyUserModel {
  Id id = Isar.autoIncrement;

  String? name;
  String? avatar;
  String? distance;
  double? signalStrength;
  DateTime? connectedAt;
}
