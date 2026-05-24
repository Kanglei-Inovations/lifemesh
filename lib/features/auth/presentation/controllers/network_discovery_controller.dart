// ignore_for_file: avoid_print

import 'dart:async';

import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../../../../core/constants/mesh_states.dart';
import '../../../../core/database_service.dart';
import '../../../../core/services/nearby_discovery_service.dart';
import '../../../../models/nearby_user_model.dart';
import '../../../../models/onboarding_state_model.dart';
import '../../../../models/onboarding_user_model.dart';

class DiscoveredUser {
  final String name;
  final String avatarUrl;
  final String distance;
  final double signalStrength;

  const DiscoveredUser({
    required this.name,
    required this.avatarUrl,
    required this.distance,
    required this.signalStrength,
  });
}

class NetworkDiscoveryController extends GetxController {
  final DatabaseService dbService = Get.find<DatabaseService>();
  final NearbyDiscoveryService nearbyDiscovery =
      Get.find<NearbyDiscoveryService>();

  final RxDouble discoveryProgress = 0.0.obs;
  final RxInt nearbyUsersCount = 0.obs;
  final RxString scanningStatus = 'Preparing nearby scan'.obs;
  final RxBool isDiscoveryCompleted = false.obs;
  final RxBool isScanning = false.obs;
  final RxList<DiscoveredUser> discoveredUsers = <DiscoveredUser>[].obs;

  final List<Worker> _workers = <Worker>[];
  StreamSubscription<List<NearbyUserModel>>? _nearbySubscription;
  Timer? _homeTimer;
  bool _hasStarted = false;
  Future<void>? _startFuture;

  @override
  void onInit() {
    super.onInit();
    _watchRealNearbyUsers();
    _bindDiscoveryState();
  }

  @override
  void onClose() {
    _homeTimer?.cancel();
    _nearbySubscription?.cancel();
    for (final worker in _workers) {
      worker.dispose();
    }
    super.onClose();
  }

  Future<void> startDiscovery() async {
    if (_hasStarted) return;
    if (_startFuture != null) return _startFuture;

    _hasStarted = true;
    _startFuture = _internalStartDiscovery();
    return _startFuture;
  }

  Future<void> _internalStartDiscovery() async {
    isScanning.value = true;
    isDiscoveryCompleted.value = false;
    discoveryProgress.value = 0.08;
    scanningStatus.value = 'Starting nearby discovery...';

    try {
      print('Starting nearby discovery...');
      await nearbyDiscovery.start();
      _scheduleHomeTransition();
    } catch (e) {
      print('Network discovery start error: $e');
      scanningStatus.value = 'Error starting discovery: $e';
      _hasStarted = false; // Allow retry if it failed
    } finally {
      _startFuture = null;
    }
  }

  void stopDiscovery() {
    isScanning.value = false;
    _homeTimer?.cancel();
  }

  void _watchRealNearbyUsers() {
    _nearbySubscription = dbService.isar.nearbyUserModels
        .where()
        .watch(fireImmediately: true)
        .listen(
          (users) {
            final activeUsers = users.where(_isActiveNearbyUser).toList()
              ..sort((a, b) {
                final aSeen =
                    a.lastSeen ?? DateTime.fromMillisecondsSinceEpoch(0);
                final bSeen =
                    b.lastSeen ?? DateTime.fromMillisecondsSinceEpoch(0);
                return bSeen.compareTo(aSeen);
              });

            discoveredUsers.assignAll(
              activeUsers.map(_discoveredUserFromModel),
            );
            nearbyUsersCount.value = discoveredUsers.length;

            if (discoveredUsers.isNotEmpty &&
                nearbyDiscovery.connectionState.value !=
                    MeshConnectionState.connected) {
              discoveryProgress.value = 0.78;
              scanningStatus.value = 'Nearby LifeMesh device found...';
            }
          },
          onError: (error) {
            print('Discovery error: $error');
          },
        );
  }

  void _bindDiscoveryState() {
    _workers.add(
      ever<MeshConnectionState>(nearbyDiscovery.connectionState, (state) {
        _applyMeshState(state);
        if (state == MeshConnectionState.connected) {
          _scheduleHomeTransition(delay: const Duration(milliseconds: 1200));
        }
      }),
    );
    _workers.add(
      ever<String>(nearbyDiscovery.lastError, (error) {
        if (error.isNotEmpty) {
          scanningStatus.value = 'Discovery error: $error';
        }
      }),
    );
  }

  void _applyMeshState(MeshConnectionState state) {
    switch (state) {
      case MeshConnectionState.idle:
        discoveryProgress.value = 0.08;
        scanningStatus.value = 'Preparing nearby scan...';
        break;
      case MeshConnectionState.advertising:
        discoveryProgress.value = 0.32;
        scanningStatus.value = 'Advertising your LifeMesh identity...';
        break;
      case MeshConnectionState.discovering:
        discoveryProgress.value = discoveredUsers.isEmpty ? 0.58 : 0.78;
        scanningStatus.value = 'Scanning for nearby LifeMesh devices...';
        break;
      case MeshConnectionState.connecting:
        discoveryProgress.value = 0.88;
        scanningStatus.value = 'Connection initiated...';
        break;
      case MeshConnectionState.connected:
        discoveryProgress.value = 1.0;
        scanningStatus.value = 'Nearby mesh connection established.';
        break;
      case MeshConnectionState.failed:
        discoveryProgress.value = 0.0;
        scanningStatus.value = 'Discovery failed. Check Bluetooth and Wi-Fi.';
        break;
    }
  }

  void _scheduleHomeTransition({Duration delay = const Duration(seconds: 5)}) {
    if (isDiscoveryCompleted.value) return;

    _homeTimer?.cancel();
    _homeTimer = Timer(delay, completeDiscovery);
  }

  Future<void> completeDiscovery() async {
    if (isDiscoveryCompleted.value) return;

    isDiscoveryCompleted.value = true;
    isScanning.value = false;
    discoveryProgress.value = nearbyUsersCount.value > 0 ? 1.0 : 0.72;
    scanningStatus.value = nearbyUsersCount.value > 0
        ? 'Network built successfully!'
        : 'Discovery active. Continuing in the dashboard...';

    final isar = dbService.isar;
    final state = await isar.onboardingStateModels.where().findFirst();
    final user =
        await isar.onboardingUserModels.where().findFirst() ??
        OnboardingUserModel();
    final now = DateTime.now();

    await isar.writeTxn(() async {
      final nextState = state ?? OnboardingStateModel();
      nextState
        ..onboardingCompleted = true
        ..currentStep = 5
        ..lastUpdated = now;
      await isar.onboardingStateModels.put(nextState);

      user
        ..onboardingCompleted = true
        ..createdAt ??= now;
      await isar.onboardingUserModels.put(user);
    });

    print('Dashboard updated');
    Get.offAllNamed('/home');
  }

  DiscoveredUser _discoveredUserFromModel(NearbyUserModel user) {
    return DiscoveredUser(
      name: user.name ?? user.deviceName ?? 'LifeMesh Device',
      avatarUrl: user.avatar ?? '',
      distance: user.connectionStatus ?? 'nearby',
      signalStrength: user.signalStrength ?? 0,
    );
  }

  bool _isActiveNearbyUser(NearbyUserModel user) {
    final status = user.connectionStatus ?? '';
    return status == MeshConnectionState.discovering.name ||
        status == MeshConnectionState.connecting.name ||
        status == MeshConnectionState.connected.name;
  }
}
