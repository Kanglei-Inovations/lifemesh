import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:isar/isar.dart';
import '../../../../core/database_service.dart';
import '../../../../models/permission_model.dart';
import 'onboarding_controller.dart';

/// Controller responsible for managing app permissions using the permission_handler package.
class PermissionController extends GetxController {
  final DatabaseService _db = Get.find<DatabaseService>();
  final OnboardingController onboardingController = Get.find<OnboardingController>();

  final RxBool bluetoothGranted = false.obs;
  final RxBool locationGranted = false.obs;
  final RxBool notificationGranted = false.obs;
  final RxBool storageGranted = false.obs;
  final RxBool cameraGranted = false.obs;
  final RxBool microphoneGranted = false.obs;
  
  final RxBool isAllGranted = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _restorePermissions();
    checkPermissionStatus();
  }

  Future<void> _restorePermissions() async {
    final model = await _db.isar.permissionModels.where().findFirst();
    if (model != null) {
      bluetoothGranted.value = model.bluetoothGranted;
      locationGranted.value = model.locationGranted;
      cameraGranted.value = model.cameraGranted;
      storageGranted.value = model.storageGranted;
      notificationGranted.value = model.notificationGranted;
      microphoneGranted.value = model.microphoneGranted;
      _updateOverallStatus();
    }
  }

  Future<void> _savePermissionsToIsar() async {
    final model = await _db.isar.permissionModels.where().findFirst() ?? PermissionModel();
    model.bluetoothGranted = bluetoothGranted.value;
    model.locationGranted = locationGranted.value;
    model.cameraGranted = cameraGranted.value;
    model.storageGranted = storageGranted.value;
    model.notificationGranted = notificationGranted.value;
    model.microphoneGranted = microphoneGranted.value;

    await _db.isar.writeTxn(() async {
      await _db.isar.permissionModels.put(model);
    });
  }

  Future<void> checkPermissionStatus() async {
    try {
      bluetoothGranted.value = await Permission.bluetooth.isGranted &&
          await Permission.bluetoothAdvertise.isGranted &&
          await Permission.bluetoothConnect.isGranted &&
          await Permission.bluetoothScan.isGranted;
      locationGranted.value = await Permission.location.isGranted;
      notificationGranted.value = await Permission.notification.isGranted;
      
      storageGranted.value = await Permission.storage.isGranted || await Permission.photos.isGranted;
      cameraGranted.value = await Permission.camera.isGranted;
      microphoneGranted.value = await Permission.microphone.isGranted;

      _updateOverallStatus();
      _savePermissionsToIsar();
    } catch (e) {
      Get.log("Error checking permission statuses: $e");
    }
  }

  void _updateOverallStatus() {
    isAllGranted.value = bluetoothGranted.value &&
        locationGranted.value &&
        notificationGranted.value &&
        storageGranted.value &&
        cameraGranted.value &&
        microphoneGranted.value;
  }

  Future<void> requestAllPermissions() async {
    isLoading.value = true;
    
    await requestLocationPermission();
    await requestBluetoothPermission();
    await requestNotificationPermission();
    await requestStoragePermission();
    await requestCameraPermission();
    await requestMicrophonePermission();
    
    isLoading.value = false;
  }

  Future<void> requestBluetoothPermission() async {
    final status = await [
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.nearbyWifiDevices,
    ].request();
    
    bool allGranted = status.values.every((s) => s.isGranted);
    bluetoothGranted.value = allGranted;
    _savePermissionsToIsar();
    _updateOverallStatus();
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    locationGranted.value = status.isGranted;
    _savePermissionsToIsar();
    _updateOverallStatus();
  }

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    notificationGranted.value = status.isGranted;
    _savePermissionsToIsar();
    _updateOverallStatus();
  }

  Future<void> requestStoragePermission() async {
    final status = await Permission.storage.request();
    final photosStatus = await Permission.photos.request(); 
    
    storageGranted.value = status.isGranted || photosStatus.isGranted;
    _savePermissionsToIsar();
    _updateOverallStatus();
  }

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    cameraGranted.value = status.isGranted;
    _savePermissionsToIsar();
    _updateOverallStatus();
  }

  Future<void> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    microphoneGranted.value = status.isGranted;
    _savePermissionsToIsar();
    _updateOverallStatus();
  }

  void continueToNextStep() {
    onboardingController.nextStep();
  }
}
