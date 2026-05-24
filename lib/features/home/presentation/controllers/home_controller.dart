import 'dart:async';

import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../../../../core/database_service.dart';
import '../../../../core/constants/mesh_states.dart';
import '../../../../core/services/nearby_discovery_service.dart';
import '../../../../models/activity_model.dart';
import '../../../../models/nearby_user_model.dart';
import '../../../../models/onboarding_user_model.dart';

class HomeController extends GetxController {
  final DatabaseService _db = Get.find<DatabaseService>();
  final NearbyDiscoveryService _nearbyDiscovery =
      Get.find<NearbyDiscoveryService>();

  final RxInt currentIndex = 0.obs;

  final RxBool isProfileLoading = true.obs;
  final RxBool isDashboardLoading = true.obs;
  final RxBool isNearbyLoading = true.obs;
  final RxBool isActivityLoading = true.obs;
  final RxBool isQuickActionsLoading = true.obs;

  final Rxn<OnboardingUserModel> onboardingUser = Rxn<OnboardingUserModel>();
  final RxString userName = ''.obs;
  final RxString profileImage = ''.obs;

  final RxBool isMeshActive = false.obs;
  final RxString meshStatus = 'Mesh Standby'.obs;
  final RxInt nearbyCount = 0.obs;
  final RxInt connectionCount = 0.obs;
  final RxDouble signalStrength = 0.0.obs;
  final RxBool hasDashboardStats = false.obs;

  final RxList<NearbyUserModel> nearbyUsers = <NearbyUserModel>[].obs;
  final RxList<ActivityModel> recentActivities = <ActivityModel>[].obs;

  final List<StreamSubscription<dynamic>> _subscriptions = [];
  final List<Worker> _workers = [];

  RxBool get isAdvertising => _nearbyDiscovery.isAdvertising;
  RxBool get isDiscovering => _nearbyDiscovery.isDiscovering;
  RxBool get bluetoothEnabled => _nearbyDiscovery.bluetoothEnabled;
  RxBool get wifiEnabled => _nearbyDiscovery.wifiEnabled;
  RxInt get connectedEndpointCount => _nearbyDiscovery.connectedEndpointCount;
  RxList<String> get endpointIds => _nearbyDiscovery.endpointIds;
  RxString get lastPayload => _nearbyDiscovery.lastPayload;
  Rx<MeshConnectionState> get connectionState => _nearbyDiscovery.connectionState;

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  @override
  void onClose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    for (final worker in _workers) {
      worker.dispose();
    }
    super.onClose();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> _bootstrap() async {
    await _removeLegacySeedData();
    _watchProfile();
    _watchDashboardStats();
    _watchNearbyUsers();
    _watchActivities();
    _bindNearbyDiscovery();
    await _nearbyDiscovery.start();

    Future.delayed(const Duration(milliseconds: 700), () {
      isQuickActionsLoading.value = false;
    });
  }

  void _watchProfile() {
    final subscription = _db.isar.onboardingUserModels
        .where()
        .watch(fireImmediately: true)
        .listen(
          (users) {
            final completedUsers = users
                .where((user) => user.onboardingCompleted)
                .toList();
            final user = completedUsers.isNotEmpty
                ? completedUsers.last
                : (users.isNotEmpty ? users.last : null);

            onboardingUser.value = user;
            userName.value = _displayNameFor(user);
            profileImage.value = user?.profileImage ?? '';
            isProfileLoading.value = false;
          },
          onError: (error) {
            Get.log('Profile watcher error: $error');
            isProfileLoading.value = false;
          },
        );

    _subscriptions.add(subscription);
  }

  void _watchDashboardStats() {
    final subscription = _db.isar.dashboardStatModels
        .where()
        .watch(fireImmediately: true)
        .listen(
          (stats) {
            if (stats.isEmpty) {
              hasDashboardStats.value = false;
              _applyDerivedMeshStats();
            } else {
              final stat = stats.last;
              hasDashboardStats.value = true;
              connectionCount.value = stat.connectedNodes;
              signalStrength.value = stat.signalStrength.toDouble();
              _updateMeshStatus();
            }

            isDashboardLoading.value = false;
          },
          onError: (error) {
            Get.log('Dashboard watcher error: $error');
            isDashboardLoading.value = false;
          },
        );

    _subscriptions.add(subscription);
  }

  void _watchNearbyUsers() {
    final subscription = _db.isar.nearbyUserModels
        .where()
        .watch(fireImmediately: true)
        .listen(
          (users) {
            final sortedUsers = users.where(_isActiveNearbyUser).toList()
              ..sort((a, b) {
                final aTime =
                    a.lastSeen ??
                    a.connectedAt ??
                    DateTime.fromMillisecondsSinceEpoch(0);
                final bTime =
                    b.lastSeen ??
                    b.connectedAt ??
                    DateTime.fromMillisecondsSinceEpoch(0);
                return bTime.compareTo(aTime);
              });

            nearbyUsers.assignAll(sortedUsers);
            nearbyCount.value = sortedUsers.length;
            if (!hasDashboardStats.value) {
              _applyDerivedMeshStats();
            }

            isNearbyLoading.value = false;
          },
          onError: (error) {
            Get.log('Nearby watcher error: $error');
            isNearbyLoading.value = false;
          },
        );

    _subscriptions.add(subscription);
  }

  void _bindNearbyDiscovery() {
    _workers.add(
      ever<MeshConnectionState>(_nearbyDiscovery.connectionState, (_) {
        _updateMeshStatus();
      }),
    );
    _workers.add(
      ever<int>(_nearbyDiscovery.connectedEndpointCount, (count) {
        connectionCount.value = count;
      }),
    );
    _workers.add(
      ever<double>(_nearbyDiscovery.averageSignalStrength, (signal) {
        if (!hasDashboardStats.value) {
          signalStrength.value = signal * 100;
        }
      }),
    );
  }

  void _watchActivities() {
    final subscription = _db.isar.activityModels
        .where()
        .watch(fireImmediately: true)
        .listen(
          (activities) {
            final sortedActivities = activities.toList()
              ..sort((a, b) => b.id.compareTo(a.id));

            recentActivities.assignAll(sortedActivities.take(8));
            isActivityLoading.value = false;
          },
          onError: (error) {
            Get.log('Activity watcher error: $error');
            isActivityLoading.value = false;
          },
        );

    _subscriptions.add(subscription);
  }

  String _displayNameFor(OnboardingUserModel? user) {
    if (user == null) return '';
    final displayName = user.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) return displayName;

    final fullName = user.fullName?.trim();
    if (fullName != null && fullName.isNotEmpty) return fullName;

    final username = user.username?.trim();
    if (username != null && username.isNotEmpty) return username;

    return '';
  }

  void _applyDerivedMeshStats() {
    final count = nearbyUsers.length;
    final averageSignal = _averageSignal(nearbyUsers);

    isMeshActive.value =
        _nearbyDiscovery.connectionState.value != MeshConnectionState.idle &&
        _nearbyDiscovery.connectionState.value != MeshConnectionState.failed;
    connectionCount.value = count;
    signalStrength.value = averageSignal;
    _updateMeshStatus();
  }

  double _averageSignal(List<NearbyUserModel> users) {
    if (users.isEmpty) return 0;

    final total = users.fold<double>(
      0,
      (sum, user) => sum + ((user.signalStrength ?? 0) * 100),
    );
    return total / users.length;
  }

  void _updateMeshStatus() {
    final state = _nearbyDiscovery.connectionState.value;
    isMeshActive.value =
        state != MeshConnectionState.idle && state != MeshConnectionState.failed;
    meshStatus.value = state.display;
  }

  bool _isActiveNearbyUser(NearbyUserModel user) {
    final status = user.connectionStatus ?? '';
    return status == MeshConnectionState.discovering.name ||
        status == MeshConnectionState.connecting.name ||
        status == MeshConnectionState.connected.name;
  }

  String signalLabel() {
    final signal = signalStrength.value;
    if (signal >= 75) return 'Strong Signal';
    if (signal >= 45) return 'Stable Signal';
    if (signal > 0) return 'Weak Signal';
    return 'No Signal';
  }

  String formatSignal(double value) => '${value.round()}%';

  Future<void> _removeLegacySeedData() async {
    final users = await _db.isar.nearbyUserModels.where().findAll();
    final legacyUserIds = users
        .where(
          (user) =>
              user.connectedAt == null &&
              (user.avatar?.contains('i.pravatar.cc') ?? false),
        )
        .map((user) => user.id)
        .toList();

    final activities = await _db.isar.activityModels.where().findAll();
    final legacyActivityIds = activities
        .where((activity) {
          final title = activity.title ?? '';
          final previews = activity.imagePreviews ?? const <String>[];
          return title.contains('You shared 3 files with Arjun') ||
              title.contains('Priya is now connected') ||
              title.contains('New message from Neha') ||
              previews.any((preview) => preview.startsWith('img'));
        })
        .map((activity) => activity.id)
        .toList();

    final stats = await _db.isar.dashboardStatModels.where().findFirst();
    final shouldResetLegacyStats =
        stats != null &&
        stats.lastUpdated == null &&
        stats.connectedNodes == 8 &&
        stats.signalStrength == 92;

    if (legacyUserIds.isEmpty &&
        legacyActivityIds.isEmpty &&
        !shouldResetLegacyStats) {
      return;
    }

    await _db.isar.writeTxn(() async {
      if (legacyUserIds.isNotEmpty) {
        await _db.isar.nearbyUserModels.deleteAll(legacyUserIds);
      }
      if (legacyActivityIds.isNotEmpty) {
        await _db.isar.activityModels.deleteAll(legacyActivityIds);
      }
      if (shouldResetLegacyStats) {
        stats
          ..isMeshActive = false
          ..connectedNodes = 0
          ..signalStrength = 0
          ..lastUpdated = DateTime.now();
        await _db.isar.dashboardStatModels.put(stats);
      }
    });
  }

  void _startRealtimeNearbySimulation() {
    _simulationTimer?.cancel();
    _simulationTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _simulateNearbyTick();
    });
  }

  Future<void> _simulateNearbyTick() async {
    if (_isSimulatingTick || isNearbyLoading.value) return;

    _isSimulatingTick = true;
    try {
      final roll = _random.nextDouble();
      if (nearbyUsers.isEmpty || roll < 0.35) {
        await _addRealtimeNearbyUser();
      } else if (nearbyUsers.length > 1 && roll < 0.55) {
        await _removeRealtimeNearbyUser();
      } else {
        await _updateRealtimeSignal();
      }

      await _syncDashboardStatsToIsar();
    } catch (error) {
      Get.log('Nearby simulation error: $error');
    } finally {
      _isSimulatingTick = false;
    }
  }

  Future<void> _addRealtimeNearbyUser() async {
    final now = DateTime.now();
    final user = NearbyUserModel()
      ..name = 'Mesh User ${100 + _random.nextInt(900)}'
      ..avatar = ''
      ..distance = '${20 + _random.nextInt(280)} m'
      ..signalStrength = double.parse(
        (0.45 + _random.nextDouble() * 0.5).toStringAsFixed(2),
      )
      ..connectedAt = now;

    await _db.isar.writeTxn(() async {
      await _db.isar.nearbyUserModels.put(user);
      await _db.isar.activityModels.put(
        ActivityModel()
          ..title = '${user.name} joined the nearby mesh'
          ..subtitle = 'Nearby discovery update'
          ..timeAgo = 'just now'
          ..iconType = 'user',
      );
    });
  }

  Future<void> _removeRealtimeNearbyUser() async {
    final user = nearbyUsers[_random.nextInt(nearbyUsers.length)];

    await _db.isar.writeTxn(() async {
      await _db.isar.nearbyUserModels.delete(user.id);
      await _db.isar.activityModels.put(
        ActivityModel()
          ..title = '${user.name ?? 'A nearby user'} left the mesh'
          ..subtitle = 'Connection count updated'
          ..timeAgo = 'just now'
          ..iconType = 'mesh',
      );
    });
  }

  Future<void> _updateRealtimeSignal() async {
    if (nearbyUsers.isEmpty) return;

    final user = nearbyUsers[_random.nextInt(nearbyUsers.length)];
    final currentSignal = user.signalStrength ?? 0.5;
    final nextSignal = (currentSignal + ((_random.nextDouble() - 0.5) * 0.22))
        .clamp(0.25, 0.98)
        .toDouble();

    user
      ..signalStrength = double.parse(nextSignal.toStringAsFixed(2))
      ..distance = '${18 + _random.nextInt(300)} m'
      ..connectedAt = DateTime.now();

    await _db.isar.writeTxn(() async {
      await _db.isar.nearbyUserModels.put(user);
    });
  }

  Future<void> _syncDashboardStatsToIsar() async {
    final users = await _db.isar.nearbyUserModels.where().findAll();
    final stats =
        await _db.isar.dashboardStatModels.where().findFirst() ??
        DashboardStatModel();
    final signal = _averageSignal(users).round();

    await _db.isar.writeTxn(() async {
      stats
        ..isMeshActive = users.isNotEmpty
        ..connectedNodes = users.length
        ..signalStrength = signal
        ..lastUpdated = DateTime.now();
      await _db.isar.dashboardStatModels.put(stats);
    });
  }
}
