import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

/// Controller responsible for managing app permissions using the permission_handler package.
class PermissionController extends GetxController {
  // Reactive state variables for individual permission statuses
  final RxBool bluetoothGranted = false.obs;
  final RxBool locationGranted = false.obs;
  final RxBool notificationGranted = false.obs;
  final RxBool storageGranted = false.obs;
  final RxBool cameraGranted = false.obs;
  final RxBool microphoneGranted = false.obs;
  
  // Master switch status
  final RxBool isAllGranted = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermissionStatus();
  }

  /// Checks the current status of all necessary permissions.
  Future<void> checkPermissionStatus() async {
    try {
      bluetoothGranted.value = await Permission.bluetooth.isGranted && 
                               await Permission.bluetoothConnect.isGranted && 
                               await Permission.bluetoothScan.isGranted;
      locationGranted.value = await Permission.location.isGranted;
      notificationGranted.value = await Permission.notification.isGranted;
      
      // Fallback check: Some OS versions use storage, others use photos
      storageGranted.value = await Permission.storage.isGranted || await Permission.photos.isGranted;
      cameraGranted.value = await Permission.camera.isGranted;
      microphoneGranted.value = await Permission.microphone.isGranted;

      _updateOverallStatus();
    } catch (e) {
      Get.log("Error checking permission statuses: $e");
    }
  }

  /// Aggregates all permission statuses to update the master granted state.
  void _updateOverallStatus() {
    isAllGranted.value = bluetoothGranted.value &&
        locationGranted.value &&
        notificationGranted.value &&
        storageGranted.value &&
        cameraGranted.value &&
        microphoneGranted.value;
  }

  /// Bulk requests all permissions sequentially.
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

  /// Requests Bluetooth discovery and connection permissions.
  Future<void> requestBluetoothPermission() async {
    final status = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
    ].request();
    
    bool allGranted = status.values.every((s) => s.isGranted);
    bluetoothGranted.value = allGranted;
    
    if (status.values.any((s) => s.isPermanentlyDenied)) {
      _handlePermanentlyDenied('Bluetooth');
    }
    _updateOverallStatus();
  }

  /// Requests GPS Location permission.
  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    locationGranted.value = status.isGranted;
    
    if (status.isPermanentlyDenied) _handlePermanentlyDenied('Location');
    _updateOverallStatus();
  }

  /// Requests System Push Notification permission.
  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    notificationGranted.value = status.isGranted;
    
    if (status.isPermanentlyDenied) _handlePermanentlyDenied('Notifications');
    _updateOverallStatus();
  }

  /// Requests file Storage/Photos read & write permissions.
  Future<void> requestStoragePermission() async {
    final status = await Permission.storage.request();
    final photosStatus = await Permission.photos.request(); 
    
    storageGranted.value = status.isGranted || photosStatus.isGranted;
    
    if (status.isPermanentlyDenied || photosStatus.isPermanentlyDenied) {
      _handlePermanentlyDenied('Storage/Photos');
    }
    _updateOverallStatus();
  }

  /// Requests Camera access.
  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    cameraGranted.value = status.isGranted;
    
    if (status.isPermanentlyDenied) _handlePermanentlyDenied('Camera');
    _updateOverallStatus();
  }

  /// Requests Microphone access.
  Future<void> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    microphoneGranted.value = status.isGranted;
    
    if (status.isPermanentlyDenied) _handlePermanentlyDenied('Microphone');
    _updateOverallStatus();
  }

  /// Handles scenarios where the user has permanently denied a permission in system dialogs.
  void _handlePermanentlyDenied(String permissionName) {
    Get.snackbar(
      'Permission Required',
      '$permissionName access is permanently denied. Please enable it in your system settings to continue.',
      mainButton: TextButton(
        onPressed: () => openAppSettings(),
        child: const Text('Open Settings', style: TextStyle(color: Colors.white)),
      ),
      duration: const Duration(seconds: 5),
    );
  }
}
