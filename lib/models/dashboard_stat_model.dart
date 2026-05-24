import 'package:isar/isar.dart';

part 'dashboard_stat_model.g.dart';

@collection
class DashboardStatModel {
  Id id = Isar.autoIncrement;

  bool isMeshActive = false;
  int connectedNodes = 0;
  int signalStrength = 0;
  DateTime? lastUpdated;
}
