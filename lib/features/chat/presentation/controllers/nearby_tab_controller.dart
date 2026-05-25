// ignore_for_file: avoid_print

import 'dart:async';
import 'package:get/get.dart';
import '../../../../core/services/mesh_network_service.dart';
import '../../../../models/nearby_user_model.dart';

class NearbyTabController extends GetxController {
  final MeshNetworkService _meshService = Get.find<MeshNetworkService>();

  // Observable states for UI - Listen to central service
  RxList<NearbyUserModel> get nearbyUsers => _meshService.activeNearbyUsers;
  var filteredUsers = <NearbyUserModel>[].obs;
  var selectedFilter = 'All'.obs;
  
  // Real-time stats from central service
  RxInt get nearbyDevicesCount => _meshService.activeNearbyUsers.length.obs;
  RxInt get signalAvg => (_meshService.avgSignalStrength.value * 100).round().obs; 
  var meshStability = 88.obs; 
  RxString get discoveryStatus => _meshService.isScanning.value ? 'Active'.obs : 'Idle'.obs;
  
  final List<Worker> _workers = [];

  @override
  void onInit() {
    super.onInit();
    print("Nearby tab opened, syncing with MeshNetworkService");
    
    // Bind filters to update when central list changes
    _workers.add(ever(_meshService.activeNearbyUsers, (_) => _applyFilter()));
    _workers.add(ever(selectedFilter, (_) => _applyFilter()));
    
    _applyFilter();
  }

  @override
  void onClose() {
    for (final worker in _workers) {
      worker.dispose();
    }
    print("Nearby tab closed");
    super.onClose();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void _applyFilter() {
    List<NearbyUserModel> results = List.from(_meshService.activeNearbyUsers);

    switch (selectedFilter.value) {
      case 'Strong Signal':
        results = results.where((u) => (u.signalStrength ?? 0) >= 0.7).toList();
        break;
      case 'Connected':
        // All active users are "online", but some might be explicitly connected as nodes
        results = results.where((u) => u.isOnline).toList();
        break;
      case 'Recently Seen':
        results.sort((a, b) => (b.lastSeen ?? DateTime(0)).compareTo(a.lastSeen ?? DateTime(0)));
        break;
      case 'Friends':
        // Mock friends logic
        results = results.take(1).toList(); 
        break;
    }

    filteredUsers.assignAll(results);
  }

  Future<void> restartDiscovery() async {
    print("Restarting global discovery");
    await _meshService.stopMesh();
    await _meshService.startMesh();
  }
}
