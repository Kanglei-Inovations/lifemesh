import 'dart:async';
import 'package:get/get.dart';

/// Data class representing a mock nearby discovered user.
class DiscoveredUser {
  final String name;
  final String avatarUrl;

  DiscoveredUser({required this.name, required this.avatarUrl});
}

/// Controller responsible for handling the onboarding mock mesh network discovery.
class NetworkDiscoveryController extends GetxController {
  // Reactive state variables tracking discovery progress
  final RxDouble discoveryProgress = 0.0.obs;
  final RxInt nearbyUsersCount = 0.obs;
  final RxString scanningStatus = 'Scanning nearby users'.obs;
  final RxBool isDiscoveryCompleted = false.obs;
  final RxBool isScanning = false.obs;

  // List holding the simulated discovered users
  final RxList<DiscoveredUser> discoveredUsers = <DiscoveredUser>[].obs;

  // Internal timer to drive fake progress
  Timer? _progressTimer;

  @override
  void onClose() {
    stopDiscovery();
    super.onClose();
  }

  /// Initiates the mock discovery process sequence.
  void startDiscovery() {
    isScanning.value = true;
    isDiscoveryCompleted.value = false;
    discoveryProgress.value = 0.0;
    nearbyUsersCount.value = 0;
    discoveredUsers.clear();
    
    scanningStatus.value = 'Scanning nearby users';
    
    // Timer running for approximately 4 seconds to animate progress bar
    _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (discoveryProgress.value >= 1.0) {
        completeDiscovery();
        timer.cancel();
      } else {
        discoveryProgress.value += 0.025; // Completes 100% in ~4 seconds
        _updateScanningStatus();
      }
    });

    simulateNearbyDiscovery();
  }

  /// Halts the current discovery session.
  void stopDiscovery() {
    isScanning.value = false;
    _progressTimer?.cancel();
  }

  /// Dynamically updates the scanning phase messaging based on completion percentage.
  void _updateScanningStatus() {
    final progress = discoveryProgress.value;
    if (progress < 0.33) {
      scanningStatus.value = 'Scanning nearby users...';
    } else if (progress < 0.66) {
      scanningStatus.value = 'Connecting securely...';
    } else if (progress < 0.95) {
      scanningStatus.value = 'Verifying connections...';
    } else {
      scanningStatus.value = 'Building LifeMesh network...';
    }
  }

  /// Populates the discovered network list over intervals to simulate radar sweeps.
  void simulateNearbyDiscovery() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!isScanning.value) return;
      discoveredUsers.add(DiscoveredUser(name: 'Rahul', avatarUrl: 'https://i.pravatar.cc/100?img=12'));
      nearbyUsersCount.value++;
    });
    
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (!isScanning.value) return;
      discoveredUsers.add(DiscoveredUser(name: 'Priya', avatarUrl: 'https://i.pravatar.cc/100?img=13'));
      nearbyUsersCount.value++;
    });
    
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (!isScanning.value) return;
      discoveredUsers.add(DiscoveredUser(name: 'Arjun', avatarUrl: 'https://i.pravatar.cc/100?img=14'));
      nearbyUsersCount.value++;
    });
    
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (!isScanning.value) return;
      discoveredUsers.add(DiscoveredUser(name: 'Neha', avatarUrl: 'https://i.pravatar.cc/100?img=15'));
      nearbyUsersCount.value++;
    });
    
    simulateConnectionVerification();
  }

  /// Simulates background cryptographic handshakes.
  void simulateConnectionVerification() {
    // Mock logic: Future cryptographic verification steps can be implemented here.
    Get.log("Mock connection verification passed.");
  }

  /// Finalizes the discovery process and signals a routing event.
  void completeDiscovery() {
    stopDiscovery();
    isDiscoveryCompleted.value = true;
    discoveryProgress.value = 1.0;
    scanningStatus.value = 'Network built successfully!';
    
    Get.log("Onboarding mesh discovery fully simulated and complete.");
    
    // Automatically transition to final Welcome screen after brief delay
    Future.delayed(const Duration(milliseconds: 500), () {
      // NOTE: Usually handled by OnboardingController or direct routing
      Get.offAllNamed('/welcome');
    });
  }
}
