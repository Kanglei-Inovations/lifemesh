import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../models/activity_model.dart';
import '../../models/dashboard_stat_model.dart';
import '../../models/nearby_user_model.dart';
import '../../models/onboarding_user_model.dart';
import '../constants/mesh_states.dart';
import '../database_service.dart';

class NearbyDiscoveryService extends GetxService {
  static const String serviceId = 'com.kangleiinnovations.lifemesh.mesh';
  static const MethodChannel _platform = MethodChannel('lifemesh/ble_rssi');
  static const EventChannel _rssiEvents = EventChannel(
    'lifemesh/ble_rssi/events',
  );

  final DatabaseService _db = Get.find<DatabaseService>();
  final Nearby _nearby = Nearby();
  final Connectivity _connectivity = Connectivity();
  final NetworkInfo _networkInfo = NetworkInfo();

  final Rx<MeshConnectionState> connectionState =
      MeshConnectionState.idle.obs;
  final RxBool isAdvertising = false.obs;
  final RxBool isDiscovering = false.obs;
  final RxBool bluetoothEnabled = false.obs;
  final RxBool wifiEnabled = false.obs;
  final RxInt connectedEndpointCount = 0.obs;
  final RxDouble averageSignalStrength = 0.0.obs;
  final RxString localEndpointName = ''.obs;
  final RxString lastPayload = ''.obs;
  final RxString lastError = ''.obs;
  final RxList<String> endpointIds = <String>[].obs;
  final RxMap<String, int> rssiByFingerprint = <String, int>{}.obs;

  StreamSubscription<dynamic>? _rssiSubscription;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  Future<void> _writeQueue = Future<void>.value();

  final Set<String> _acceptedEndpoints = <String>{};
  final Set<String> _requestedEndpoints = <String>{};
  final Set<String> _connectedEndpoints = <String>{};
  final Map<String, String> _endpointNames = <String, String>{};
  final Map<String, String> _endpointMeshIds = <String, String>{};

  bool _isStarted = false;
  bool _isStarting = false;

  OnboardingUserModel? _localUser;
  String _localMeshId = '';
  String _localMeshFingerprint = '';
  String _localUsername = 'LifeMesh User';
  String _localProfileImage = '';
  String _localDeviceName = 'Android Device';

  Future<NearbyDiscoveryService> init() async {
    print('LifeMesh initialized');
    _listenForBleRssi();
    await refreshRadioState();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      result,
    ) {
      wifiEnabled.value = result == ConnectivityResult.wifi;
      print('WiFi state changed: ${wifiEnabled.value}');
    });
    return this;
  }

  @override
  void onClose() {
    stop();
    _rssiSubscription?.cancel();
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  Future<void> start() async {
    if (_isStarted || _isStarting) {
      print('Nearby discovery already running');
      return;
    }

    _isStarting = true;
    lastError.value = '';

    try {
      print('Starting nearby discovery...');
      await _loadLocalIdentity();
      await _requestNearbyPermissions();
      await refreshRadioState();
      await _startBleIdentityBeacon();
      await _startAdvertising();
      await _startDiscovery();
      _isStarted = true;
      print('LifeMesh nearby discovery started');
    } catch (e) {
      connectionState.value = MeshConnectionState.failed;
      lastError.value = e.toString();
      print('Discovery error: $e');
    } finally {
      _isStarting = false;
      await _syncDashboardStatsToIsar();
    }
  }

  Future<void> stop() async {
    print('Stopping nearby discovery...');
    _isStarted = false;
    _isStarting = false;

    try {
      await _nearby.stopDiscovery();
    } catch (e) {
      print('Discovery stop error: $e');
    }
    try {
      await _nearby.stopAdvertising();
    } catch (e) {
      print('Advertising stop error: $e');
    }
    try {
      await _nearby.stopAllEndpoints();
    } catch (e) {
      print('Endpoint stop error: $e');
    }
    await _stopBleIdentityBeacon();

    isAdvertising.value = false;
    isDiscovering.value = false;
    _connectedEndpoints.clear();
    endpointIds.clear();
    connectedEndpointCount.value = 0;
    connectionState.value = MeshConnectionState.idle;
    await _syncDashboardStatsToIsar();
  }

  Future<void> refreshRadioState() async {
    try {
      if (Platform.isAndroid) {
        bluetoothEnabled.value =
            await _platform.invokeMethod<bool>('isBluetoothEnabled') ?? false;
        final nativeWifiEnabled =
            await _platform.invokeMethod<bool>('isWifiEnabled') ?? false;
        final connectivity = await _connectivity.checkConnectivity();
        final wifiName = await _networkInfo.getWifiName();
        wifiEnabled.value =
            nativeWifiEnabled ||
            connectivity == ConnectivityResult.wifi ||
            (wifiName != null && wifiName.isNotEmpty);
      }
    } catch (e) {
      print('Radio state error: $e');
    }

    print('Bluetooth state: ${bluetoothEnabled.value}');
    print('WiFi state: ${wifiEnabled.value}');
  }

  String meshStateLabel() => connectionState.value.display;

  double signalFromRssi(int rssi) {
    final normalized = ((rssi + 100) / 70).clamp(0.0, 1.0);
    return double.parse(normalized.toStringAsFixed(2));
  }

  Future<void> _loadLocalIdentity() async {
    final user = await _db.isar.onboardingUserModels.where().findFirst();
    if (user == null) {
      throw StateError('Cannot start nearby discovery without a local profile');
    }

    final meshId = _validText(user.meshId) ? user.meshId!.trim() : const Uuid().v4();
    if (user.meshId != meshId) {
      await _db.isar.writeTxn(() async {
        user.meshId = meshId;
        await _db.isar.onboardingUserModels.put(user);
      });
    }

    _localUser = user;
    _localMeshId = meshId;
    _localMeshFingerprint = _fingerprintFor(meshId);
    _localUsername = _displayNameFor(user);
    _localProfileImage = user.profileImage?.trim() ?? '';
    _localDeviceName = await _deviceName();
    localEndpointName.value = _buildEndpointName(
      meshId: _localMeshId,
      username: _localUsername,
      deviceName: _localDeviceName,
    );

    print('Advertising device: $_localUsername');
    print('Local mesh ID: $_localMeshId');
    print('Local device name: $_localDeviceName');
  }

  Future<void> _requestNearbyPermissions() async {
    final permissions = <Permission>[
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.nearbyWifiDevices,
    ];

    final statuses = await permissions.request();
    final summary = statuses.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join(', ');
    print('Nearby permissions: $summary');

    final locationEnabled = await Permission.location.serviceStatus.isEnabled;
    print('Location service enabled: $locationEnabled');
  }

  Future<void> _startAdvertising() async {
    try {
      connectionState.value = MeshConnectionState.advertising;
      final started = await _nearby.startAdvertising(
        localEndpointName.value,
        Strategy.P2P_CLUSTER,
        serviceId: serviceId,
        onConnectionInitiated: _handleConnectionInitiated,
        onConnectionResult: _handleConnectionResult,
        onDisconnected: _handleDisconnected,
      );

      isAdvertising.value = started;
      print('Advertising state: $started');
      if (!started) {
        throw StateError('Nearby advertising returned false');
      }
    } catch (e) {
      isAdvertising.value = false;
      connectionState.value = MeshConnectionState.failed;
      print('Discovery error: $e');
      rethrow;
    }
  }

  Future<void> _startDiscovery() async {
    try {
      connectionState.value = MeshConnectionState.discovering;
      final started = await _nearby.startDiscovery(
        localEndpointName.value,
        Strategy.P2P_CLUSTER,
        serviceId: serviceId,
        onEndpointFound: _handleEndpointFound,
        onEndpointLost: _handleEndpointLost,
      );

      isDiscovering.value = started;
      print('Discovery state: $started');
      if (!started) {
        throw StateError('Nearby discovery returned false');
      }
    } catch (e) {
      isDiscovering.value = false;
      connectionState.value = MeshConnectionState.failed;
      print('Discovery error: $e');
      rethrow;
    }
  }

  void _handleEndpointFound(
    String endpointId,
    String endpointName,
    String discoveredServiceId,
  ) {
    if (discoveredServiceId != serviceId) {
      print('Ignoring endpoint from another service: $discoveredServiceId');
      return;
    }

    final identity = _identityFromEndpointName(endpointName);
    if (identity.meshId == _localMeshId) {
      print('Ignoring local endpoint echo: $endpointId');
      return;
    }

    print('Nearby device found: ${identity.username}');
    _endpointNames[endpointId] = endpointName;
    if (_validText(identity.meshId)) {
      _endpointMeshIds[endpointId] = identity.meshId!;
    }

    unawaited(
      _upsertNearbyUser(
        endpointId: endpointId,
        endpointName: endpointName,
        status: MeshConnectionState.discovering,
      ),
    );
    unawaited(_requestConnection(endpointId));
  }

  void _handleEndpointLost(String? endpointId) {
    if (endpointId == null) return;
    print('Nearby endpoint lost: $endpointId');
    _requestedEndpoints.remove(endpointId);
    _acceptedEndpoints.remove(endpointId);
    _connectedEndpoints.remove(endpointId);
    endpointIds.assignAll(_connectedEndpoints.toList());
    connectedEndpointCount.value = _connectedEndpoints.length;

    unawaited(
      _updateEndpointStatus(endpointId, MeshConnectionState.idle),
    );
  }

  Future<void> _requestConnection(String endpointId) async {
    if (_requestedEndpoints.contains(endpointId) ||
        _connectedEndpoints.contains(endpointId)) {
      return;
    }

    try {
      _requestedEndpoints.add(endpointId);
      connectionState.value = MeshConnectionState.connecting;
      print('Connection initiated');
      final requested = await _nearby.requestConnection(
        localEndpointName.value,
        endpointId,
        onConnectionInitiated: _handleConnectionInitiated,
        onConnectionResult: _handleConnectionResult,
        onDisconnected: _handleDisconnected,
      );
      print('Connection request sent: $requested');
    } catch (e) {
      _requestedEndpoints.remove(endpointId);
      print('Discovery error: $e');
      unawaited(_updateEndpointStatus(endpointId, MeshConnectionState.failed));
    }
  }

  void _handleConnectionInitiated(String endpointId, ConnectionInfo info) {
    print('Connection initiated with ${info.endpointName}');
    _endpointNames[endpointId] = info.endpointName;

    final identity = _identityFromEndpointName(info.endpointName);
    if (_validText(identity.meshId)) {
      _endpointMeshIds[endpointId] = identity.meshId!;
    }

    connectionState.value = MeshConnectionState.connecting;
    unawaited(
      _upsertNearbyUser(
        endpointId: endpointId,
        endpointName: info.endpointName,
        status: MeshConnectionState.connecting,
      ),
    );
    unawaited(_acceptConnection(endpointId));
  }

  Future<void> _acceptConnection(String endpointId) async {
    if (_acceptedEndpoints.contains(endpointId)) return;
    _acceptedEndpoints.add(endpointId);

    try {
      final accepted = await _nearby.acceptConnection(
        endpointId,
        onPayLoadRecieved: _handlePayloadReceived,
        onPayloadTransferUpdate: (endpointId, update) {
          print(
            'Payload transfer update: $endpointId ${update.status} '
            '${update.bytesTransferred}/${update.totalBytes}',
          );
        },
      );
      print('Connection accepted: $accepted');
    } catch (e) {
      _acceptedEndpoints.remove(endpointId);
      print('Discovery error: $e');
      unawaited(_updateEndpointStatus(endpointId, MeshConnectionState.failed));
    }
  }

  void _handleConnectionResult(String endpointId, Status status) {
    print('Connection result for $endpointId: $status');
    if (status == Status.CONNECTED) {
      _connectedEndpoints.add(endpointId);
      endpointIds.assignAll(_connectedEndpoints.toList());
      connectedEndpointCount.value = _connectedEndpoints.length;
      connectionState.value = MeshConnectionState.connected;
      unawaited(
        _upsertNearbyUser(
          endpointId: endpointId,
          endpointName: _endpointNames[endpointId],
          status: MeshConnectionState.connected,
        ),
      );
      unawaited(_sendIdentityPayload(endpointId));
    } else {
      _connectedEndpoints.remove(endpointId);
      endpointIds.assignAll(_connectedEndpoints.toList());
      connectedEndpointCount.value = _connectedEndpoints.length;
      connectionState.value = MeshConnectionState.failed;
      unawaited(_updateEndpointStatus(endpointId, MeshConnectionState.failed));
    }

    unawaited(_syncDashboardStatsToIsar());
  }

  void _handleDisconnected(String endpointId) {
    print('Disconnected from endpoint: $endpointId');
    _connectedEndpoints.remove(endpointId);
    endpointIds.assignAll(_connectedEndpoints.toList());
    connectedEndpointCount.value = _connectedEndpoints.length;
    connectionState.value = _connectedEndpoints.isEmpty
        ? MeshConnectionState.discovering
        : MeshConnectionState.connected;
    unawaited(_updateEndpointStatus(endpointId, MeshConnectionState.idle));
    unawaited(_syncDashboardStatsToIsar());
  }

  Future<void> _sendIdentityPayload(String endpointId) async {
    final payload = <String, dynamic>{
      'type': 'lifemesh.identity.v1',
      'username': _localUsername,
      'meshId': _localMeshId,
      'profileImage': _localProfileImage,
      'deviceName': _localDeviceName,
      'fingerprint': _localMeshFingerprint,
      'sentAt': DateTime.now().toIso8601String(),
    };
    final jsonPayload = jsonEncode(payload);

    try {
      await _nearby.sendBytesPayload(
        endpointId,
        Uint8List.fromList(utf8.encode(jsonPayload)),
      );
      lastPayload.value = jsonPayload;
      print('Identity payload sent to $endpointId');
    } catch (e) {
      print('Discovery error: $e');
    }
  }

  void _handlePayloadReceived(String endpointId, Payload payload) {
    print('Payload received');
    if (payload.type != PayloadType.BYTES || payload.bytes == null) {
      print('Ignored non-byte payload from $endpointId');
      return;
    }

    final message = utf8.decode(payload.bytes!);
    lastPayload.value = message;
    print('Payload received from $endpointId: $message');

    try {
      final data = jsonDecode(message);
      if (data is! Map<String, dynamic>) return;
      if (data['type'] != 'lifemesh.identity.v1') return;

      final meshId = data['meshId']?.toString();
      if (_validText(meshId)) {
        _endpointMeshIds[endpointId] = meshId!.trim();
      }

      unawaited(
        _upsertNearbyUser(
          endpointId: endpointId,
          payload: data,
          status: MeshConnectionState.connected,
        ),
      );
    } catch (e) {
      print('Discovery error: $e');
    }
  }

  Future<void> _upsertNearbyUser({
    required String endpointId,
    String? endpointName,
    Map<String, dynamic>? payload,
    required MeshConnectionState status,
  }) {
    return _queueWrite(() async {
      final now = DateTime.now();
      final endpointIdentity = _identityFromEndpointName(endpointName);
      final payloadMeshId = payload?['meshId']?.toString().trim();
      final meshId = _validText(payloadMeshId)
          ? payloadMeshId!
          : endpointIdentity.meshId ?? _endpointMeshIds[endpointId] ?? '';

      if (meshId == _localMeshId) return;

      final username = _firstNonEmpty([
        payload?['username']?.toString(),
        endpointIdentity.username,
        'LifeMesh Device',
      ]);
      final profileImage = payload?['profileImage']?.toString().trim() ?? '';
      final deviceName = _firstNonEmpty([
        payload?['deviceName']?.toString(),
        endpointIdentity.deviceName,
        'Nearby Android',
      ]);
      final signal = _signalForMesh(meshId);

      final users = await _db.isar.nearbyUserModels.where().findAll();
      NearbyUserModel? existing;
      for (final user in users) {
        if (user.endpointId == endpointId ||
            (_validText(meshId) && user.meshId == meshId)) {
          existing = user;
          break;
        }
      }

      final isNewUser = existing == null;
      final user = existing ?? NearbyUserModel();
      user
        ..endpointId = endpointId
        ..meshId = meshId
        ..name = username
        ..avatar = profileImage
        ..deviceName = deviceName
        ..signalStrength = signal
        ..connectionStatus = status.name
        ..lastSeen = now
        ..connectedAt ??= now;

      if (status == MeshConnectionState.connected) {
        user.connectedAt = user.connectedAt ?? now;
      }

      await _db.isar.writeTxn(() async {
        await _db.isar.nearbyUserModels.put(user);
        if (isNewUser || status == MeshConnectionState.connected) {
          await _db.isar.activityModels.put(
            ActivityModel()
              ..title = '$username joined the nearby mesh'
              ..subtitle = 'Real LifeMesh discovery'
              ..timeAgo = 'just now'
              ..iconType = 'user',
          );
        }
      });

      print('Nearby user saved to Isar');
      print('Dashboard updated');
      await _syncDashboardStatsToIsarLocked();
    });
  }

  Future<void> _updateEndpointStatus(
    String endpointId,
    MeshConnectionState status,
  ) {
    return _queueWrite(() async {
      final users = await _db.isar.nearbyUserModels.where().findAll();
      NearbyUserModel? user;
      for (final candidate in users) {
        if (candidate.endpointId == endpointId) {
          user = candidate;
          break;
        }
      }
      if (user == null) return;

      user
        ..connectionStatus = status.name
        ..lastSeen = DateTime.now();

      await _db.isar.writeTxn(() async {
        await _db.isar.nearbyUserModels.put(user!);
      });
      print('Dashboard updated');
      await _syncDashboardStatsToIsarLocked();
    });
  }

  Future<void> _syncDashboardStatsToIsar() {
    return _queueWrite(_syncDashboardStatsToIsarLocked);
  }

  Future<void> _syncDashboardStatsToIsarLocked() async {
    final users = await _db.isar.nearbyUserModels.where().findAll();
    final activeUsers = users.where(_isActiveNearbyUser).toList();
    final stats =
        await _db.isar.dashboardStatModels.where().findFirst() ??
        DashboardStatModel();
    final signal = activeUsers.isEmpty
        ? 0
        : (activeUsers.fold<double>(
                    0,
                    (sum, user) => sum + ((user.signalStrength ?? 0) * 100),
                  ) /
                  activeUsers.length)
              .round();

    averageSignalStrength.value = signal / 100;

    await _db.isar.writeTxn(() async {
      stats
        ..isMeshActive =
            connectionState.value != MeshConnectionState.idle &&
            connectionState.value != MeshConnectionState.failed
        ..connectedNodes = _connectedEndpoints.length
        ..signalStrength = signal
        ..lastUpdated = DateTime.now();
      await _db.isar.dashboardStatModels.put(stats);
    });
  }

  Future<void> _startBleIdentityBeacon() async {
    if (!Platform.isAndroid) return;
    try {
      final advertiseStarted =
          await _platform.invokeMethod<bool>('startBleAdvertising', {
            'fingerprint': _localMeshFingerprint,
          }) ??
          false;
      final scanStarted =
          await _platform.invokeMethod<bool>('startBleScanning') ?? false;
      print('BLE identity advertising: $advertiseStarted');
      print('BLE RSSI scanning: $scanStarted');
    } catch (e) {
      print('BLE RSSI error: $e');
    }
  }

  Future<void> _stopBleIdentityBeacon() async {
    if (!Platform.isAndroid) return;
    try {
      await _platform.invokeMethod<void>('stopBleAdvertising');
      await _platform.invokeMethod<void>('stopBleScanning');
    } catch (e) {
      print('BLE RSSI stop error: $e');
    }
  }

  void _listenForBleRssi() {
    if (!Platform.isAndroid) return;
    _rssiSubscription = _rssiEvents.receiveBroadcastStream().listen(
      (event) {
        if (event is! Map) return;
        final fingerprint = event['fingerprint']?.toString();
        final rssi = event['rssi'];
        if (!_validText(fingerprint) || rssi is! int) return;
        if (fingerprint == _localMeshFingerprint) return;

        rssiByFingerprint[fingerprint!] = rssi;
        print('BLE RSSI update: $fingerprint $rssi dBm');
        unawaited(_applyRssiUpdate(fingerprint, rssi));
      },
      onError: (error) {
        print('BLE RSSI error: $error');
      },
    );
  }

  Future<void> _applyRssiUpdate(String fingerprint, int rssi) {
    return _queueWrite(() async {
      final signal = signalFromRssi(rssi);
      final users = await _db.isar.nearbyUserModels.where().findAll();
      final matchingUsers = users
          .where((user) => _fingerprintFor(user.meshId ?? '') == fingerprint)
          .toList();

      if (matchingUsers.isEmpty) return;

      final now = DateTime.now();
      await _db.isar.writeTxn(() async {
        for (final user in matchingUsers) {
          user
            ..signalStrength = signal
            ..lastSeen = now;
          await _db.isar.nearbyUserModels.put(user);
        }
      });
      print('Dashboard updated');
      await _syncDashboardStatsToIsarLocked();
    });
  }

  Future<void> _queueWrite(Future<void> Function() operation) {
    _writeQueue = _writeQueue.then((_) => operation()).catchError((error) {
      print('Discovery error: $error');
    });
    return _writeQueue;
  }

  Future<String> _deviceName() async {
    if (!Platform.isAndroid) return Platform.localHostname;
    try {
      final deviceName = await _platform.invokeMethod<String>('getDeviceName');
      if (_validText(deviceName)) return deviceName!.trim();
    } catch (e) {
      print('Device name error: $e');
    }
    return Platform.localHostname;
  }

  String _displayNameFor(OnboardingUserModel user) {
    return _firstNonEmpty([
      user.displayName,
      user.fullName,
      user.username,
      'LifeMesh User',
    ]);
  }

  String _buildEndpointName({
    required String meshId,
    required String username,
    required String deviceName,
  }) {
    final safeUser = _trimEndpointPart(username, 26);
    final safeDevice = _trimEndpointPart(deviceName, 32);
    return 'LM|$meshId|$safeUser|$safeDevice';
  }

  _EndpointIdentity _identityFromEndpointName(String? endpointName) {
    if (!_validText(endpointName)) {
      return const _EndpointIdentity();
    }

    final parts = endpointName!.split('|');
    if (parts.length >= 4 && parts.first == 'LM') {
      return _EndpointIdentity(
        meshId: parts[1],
        username: parts[2],
        deviceName: parts.sublist(3).join('|'),
      );
    }

    return _EndpointIdentity(username: endpointName);
  }

  double _signalForMesh(String meshId) {
    final fingerprint = _fingerprintFor(meshId);
    final rssi = rssiByFingerprint[fingerprint];
    if (rssi == null) return 0.0;
    return signalFromRssi(rssi);
  }

  bool _isActiveNearbyUser(NearbyUserModel user) {
    final status = user.connectionStatus ?? '';
    return status == MeshConnectionState.discovering.name ||
        status == MeshConnectionState.connecting.name ||
        status == MeshConnectionState.connected.name;
  }

  String _fingerprintFor(String meshId) {
    final clean = meshId.replaceAll(RegExp(r'[^a-fA-F0-9]'), '');
    if (clean.length >= 8) return clean.substring(0, 8).toLowerCase();
    return clean.padRight(8, '0').toLowerCase();
  }

  String _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      if (_validText(value)) return value!.trim();
    }
    return '';
  }

  String _trimEndpointPart(String value, int maxLength) {
    final compact = value.replaceAll('|', ' ').trim();
    if (compact.length <= maxLength) return compact;
    return compact.substring(0, maxLength);
  }

  bool _validText(String? value) => value != null && value.trim().isNotEmpty;
}

class _EndpointIdentity {
  final String? meshId;
  final String? username;
  final String? deviceName;

  const _EndpointIdentity({
    this.meshId,
    this.username,
    this.deviceName,
  });
}
