import 'dart:async';

import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../../../../core/database_service.dart';
import '../../../../core/constants/mesh_states.dart';
import '../../../../core/services/mesh_network_service.dart';
import '../../../../core/network/local_node_server.dart';
import '../../../../core/network/lan_discovery_service.dart';
import '../../../../features/auth/presentation/controllers/permission_controller.dart';
import '../../../../models/activity_model.dart';
import '../../../../models/dashboard_stat_model.dart';
import '../../../../models/nearby_user_model.dart';
import '../../../../models/onboarding_user_model.dart';

class HomeController extends GetxController {
  final DatabaseService _db = Get.find<DatabaseService>();
  final MeshNetworkService _meshService = Get.find<MeshNetworkService>();
  final LocalNodeServer _nodeServer = Get.find<LocalNodeServer>();
  final LanDiscoveryService _lanService = Get.find<LanDiscoveryService>();
  final PermissionController _permissionController = Get.put(PermissionController());

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

  final RxString lastPayload = ''.obs;
  final RxString lastError = ''.obs;
  final RxList<String> logs = <String>[].obs;

  RxBool get bluetoothEnabled => _permissionController.bluetoothGranted;
  RxBool get wifiEnabled => _permissionController.locationGranted; 

  RxBool get isAdvertising => _meshService.isScanning;
  RxBool get isDiscovering => _meshService.isScanning;
  
  RxBool get isLanActive => _lanService.isDiscovering.obs;
  RxBool get isServerRunning => _nodeServer.isRunning.obs;
  RxInt get serverPort => _nodeServer.port.obs;

  RxInt get connectedEndpointCount => _meshService.activeNearbyUsers.length.obs;
  RxList<String> get endpointIds => _meshService.activeNearbyUsers.map((u) => u.endpointId ?? u.meshId?.substring(0,8) ?? 'unknown').toList().obs;
  Rx<MeshConnectionState> get connectionState => _meshService.globalState;

  void addLog(String message) {
    final time = DateTime.now().toString().split(' ').last.substring(0, 8);
    logs.insert(0, '[$time] $message');
    if (logs.length > 20) logs.removeLast();
  }

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  Future<void> startDiscovery() async {
    await _permissionController.checkPermissionStatus();
    await _meshService.startMesh();
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
    await _permissionController.checkPermissionStatus();
    _watchProfile();
    _watchDashboardStats();
    _watchNearbyUsers();
    _watchActivities();
    _bindMeshService();
    await _meshService.startMesh();

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

  void _bindMeshService() {
    _workers.add(
      ever<MeshConnectionState>(_meshService.globalState, (state) {
        addLog('Mesh State: ${state.name}');
        _updateMeshStatus();
      }),
    );
    _workers.add(
      ever(_meshService.activeNearbyUsers, (nodes) {
        addLog('Active Peers: ${nodes.length}');
        connectionCount.value = nodes.length;
      }),
    );
    _workers.add(
      ever<double>(_meshService.avgSignalStrength, (signal) {
        signalStrength.value = signal * 100;
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

    isMeshActive.value = _meshService.globalState.value != MeshConnectionState.idle &&
                         _meshService.globalState.value != MeshConnectionState.failed;
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
    final state = _meshService.globalState.value;
    isMeshActive.value =
        state != MeshConnectionState.idle &&
        state != MeshConnectionState.failed;
    meshStatus.value = state.display;
  }

  bool _isActiveNearbyUser(NearbyUserModel user) {
    return user.isOnline;
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
              user.endpointId == null ||
              user.meshId == null ||
              (user.avatar?.contains('i.pravatar.cc') ?? false) ||
              (user.name?.startsWith('Mesh User ') ?? false),
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
}
