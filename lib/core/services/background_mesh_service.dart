// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';

// This is the top-level background entry point.
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Keep the mesh active in the background
  Timer.periodic(const Duration(seconds: 15), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "LifeMesh Network Active",
          content: "Maintaining offline mesh connections",
        );
      }
    }
    
    // Periodically trigger a mesh health check/sync here if needed
    print("Background Service: Mesh heartbeat check");
  });
}

class BackgroundMeshService extends GetxService {
  final _service = FlutterBackgroundService();

  Future<void> init() async {
    print("BackgroundMeshService initializing...");
    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false, // We'll start it manually when the mesh is activated
        isForegroundMode: true,
        notificationChannelId: 'lifemesh_mesh_channel',
        initialNotificationTitle: 'LifeMesh Network',
        initialNotificationContent: 'Connecting to nearby devices...',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: (ServiceInstance service) {
          return true;
        },
      ),
    );
  }

  void start() {
    _service.startService();
  }

  void stop() {
    _service.invoke('stopService');
  }
}
