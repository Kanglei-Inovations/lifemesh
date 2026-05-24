import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:isar/isar.dart';
import '../../../../core/database_service.dart';
import '../../../../models/permission_model.dart';
import 'onboarding_controller.dart';

/// Controller responsible for managing app permissions using the permission_handler package.
class PermissionController extends GetxController {
  final DatabaseService _db = Get.find<DatabaseService>();
  final OnboardingController onboardingController =
      Get.find<OnboardingController>();

  final RxBool bluetoothGranted = false.obs;
  final RxBool locationGranted = false.obs;
  final RxBool notificationGranted = false.obs;
  final RxBool storageGranted = false.obs;
  final RxBool cameraGranted = false.obs;
  final RxBool microphoneGranted = false.obs;
  final RxBool gpsGranted = false.obs;

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
      gpsGranted.value = model.gpsGranted;
      _updateOverallStatus();
    }
  }

  Future<void> _savePermissionsToIsar() async {
    final model =
        await _db.isar.permissionModels.where().findFirst() ??
        PermissionModel();
    model.bluetoothGranted = bluetoothGranted.value;
    model.locationGranted = locationGranted.value;
    model.cameraGranted = cameraGranted.value;
    model.storageGranted = storageGranted.value;
    model.notificationGranted = notificationGranted.value;
    model.microphoneGranted = microphoneGranted.value;
    model.gpsGranted = gpsGranted.value;

    await _db.isar.writeTxn(() async {
      await _db.isar.permissionModels.put(model);
    });
  }

  Future<void> checkPermissionStatus() async {
    try {
      // For Bluetooth, we check both legacy and new permissions
      // On Android 12+, Scan/Connect/Advertise are primary.
      // On Android <12, Bluetooth is primary.
      
      // Use status to avoid issues with "missing in manifest" if one is not applicable
      final bt = await Permission.bluetooth.isGranted;
      final btScan = await Permission.bluetoothScan.isGranted;
      final btConnect = await Permission.bluetoothConnect.isGranted;
      final btAdvertise = await Permission.bluetoothAdvertise.isGranted;

      bluetoothGranted.value = (btScan && btConnect && btAdvertise) || bt;
          
      locationGranted.value = await Permission.location.isGranted;
      gpsGranted.value = await Permission.location.isGranted; // GPS uses same permission check in this context
      
      notificationGranted.value = await Permission.notification.isGranted;

      storageGranted.value =
          await Permission.storage.isGranted ||
          await Permission.photos.isGranted;
      cameraGranted.value = await Permission.camera.isGranted;
      microphoneGranted.value = await Permission.microphone.isGranted;

      _updateOverallStatus();
      _savePermissionsToIsar();
    } catch (e) {
      Get.log("Error checking permission statuses: $e");
    }
  }

  void _updateOverallStatus() {
    // Essential permissions for core mesh functionality
    isAllGranted.value =
        bluetoothGranted.value &&
        locationGranted.value &&
        gpsGranted.value;
  }

  Future<void> requestAllPermissions() async {
    isLoading.value = true;
    try {
      await requestLocationPermission();
      await requestBluetoothPermission();
      await requestNotificationPermission();
      await requestStoragePermission();
      await requestCameraPermission();
      await requestMicrophonePermission();
    } catch (e) {
      Get.log("Error requesting all permissions: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestBluetoothPermission() async {
    final List<Permission> toRequest = [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.nearbyWifiDevices,
    ];
    
    // We don't request Permission.bluetooth (legacy) at runtime on Android 12+
    // as it's not a "dangerous" permission that needs a dialog.
    // Requesting it often causes "missing in manifest" errors if not handled correctly by the plugin.

    try {
      final status = await toRequest.request();

      bool modernBt = (status[Permission.bluetoothScan]?.isGranted ?? true) &&
          (status[Permission.bluetoothConnect]?.isGranted ?? true) &&
          (status[Permission.bluetoothAdvertise]?.isGranted ?? true);
          
      // Nearby WiFi is Android 13+ only
      // bool wifi = (status[Permission.nearbyWifiDevices]?.isGranted ?? true);
          
      bluetoothGranted.value = modernBt;
    } catch (e) {
      Get.log("Error requesting bluetooth permissions: $e");
      // Fallback check
      await checkPermissionStatus();
    }
    
    _savePermissionsToIsar();
    _updateOverallStatus();
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    locationGranted.value = status.isGranted;
    gpsGranted.value = status.isGranted;
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
