import 'package:isar/isar.dart';

part 'permission_model.g.dart';

@collection
class PermissionModel {
  Id id = Isar.autoIncrement;

  bool bluetoothGranted = false;
  bool locationGranted = false;
  bool cameraGranted = false;
  bool storageGranted = false;
  bool notificationGranted = false;
  bool microphoneGranted = false;
  bool nearbyDevicesGranted = false;
}
