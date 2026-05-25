import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'package:lifemesh/core/database_service.dart';
import 'package:lifemesh/core/services/nearby_service.dart';
import 'package:lifemesh/core/network/lan_discovery_service.dart';
import 'package:lifemesh/core/network/local_node_server.dart';
import 'package:lifemesh/core/constants/mesh_states.dart';
import 'package:lifemesh/models/nearby_user_model.dart';
import 'package:lifemesh/models/dashboard_stat_model.dart';

class MeshNetworkService extends GetxService {
  final DatabaseService _db = Get.find<DatabaseService>();
  
  late final NearbyService _nearbyService;
  late final LanDiscoveryService _lanService;
  late final LocalNodeServer _nodeServer;

  final Rx<MeshConnectionState> globalState = MeshConnectionState.idle.obs;
  final RxBool isScanning = false.obs;
  
  // Single source of truth for UI
  final RxList<NearbyUserModel> activeNearbyUsers = <NearbyUserModel>[].obs;
  final RxDouble avgSignalStrength = 0.0.obs;
  
  Timer? _heartbeatPollerTimer;
  Timer? _cleanupTimer;
  
  static const int heartbeatTimeout = 15; // 15 seconds

  Future<MeshNetworkService> init() async {
    print("MeshNetworkService: Initializing...");
    
    _nearbyService = Get.find<NearbyService>();
    _lanService = Get.find<LanDiscoveryService>();
    _nodeServer = Get.find<LocalNodeServer>();
    
    // Pass local node port to LAN service
    _lanService.setNodePort(_nodeServer.port);
    
    _lanService.onPeerDiscovered = _handleLanPeerDiscovered;

    _setupIsarWatcher();
    
    _heartbeatPollerTimer = Timer.periodic(const Duration(seconds: 5), (_) => _pollLanHeartbeats());
    _cleanupTimer = Timer.periodic(const Duration(seconds: 5), (_) => _cleanupStaleUsers());
    
    print("MeshNetworkService: Initialized.");
    return this;
  }
  
  @override
  void onClose() {
    _heartbeatPollerTimer?.cancel();
    _cleanupTimer?.cancel();
    stopMesh();
    super.onClose();
  }

  Future<void> startMesh() async {
    print("MeshNetworkService: Starting Hybrid Mesh...");
    isScanning.value = true;
    globalState.value = MeshConnectionState.discovering;
    
    // Start node server
    await _nodeServer.startServer();
    
    // Update LAN service with the actual bound port
    _lanService.setNodePort(_nodeServer.port);
    
    // Start LAN Discovery (UDP)
    await _lanService.startDiscovery();
    
    // Start BLE Nearby (Google Nearby Connections)
    await _nearbyService.startMesh();
  }

  Future<void> stopMesh() async {
    print("MeshNetworkService: Stopping Hybrid Mesh...");
    isScanning.value = false;
    globalState.value = MeshConnectionState.idle;
    
    await _nearbyService.stopMesh();
    await _lanService.stopDiscovery();
    await _nodeServer.stopServer();
  }
  
  void _setupIsarWatcher() {
    _db.isar.nearbyUserModels.where().watch().listen((users) {
      final active = users.where((u) => u.isOnline).toList();
      activeNearbyUsers.assignAll(active);
      _updateStats(active);
    });
  }

  void _updateStats(List<NearbyUserModel> activeUsers) {
    if (activeUsers.isEmpty) {
      avgSignalStrength.value = 0.0;
    } else {
      final total = activeUsers.fold<double>(0, (sum, u) => sum + (u.signalStrength ?? 0));
      avgSignalStrength.value = total / activeUsers.length;
    }
  }

  void _handleLanPeerDiscovered(Map<String, dynamic> data) async {
    final meshId = data['meshId'];
    final ip = data['ip'];
    final port = data['port'];
    
    // Check if we already have them online via LAN
    final existing = await _db.isar.nearbyUserModels.filter().meshIdEqualTo(meshId).findFirst();
    if (existing != null && existing.isOnline && existing.discoverySource == 'lan') {
      // Just update heartbeat
      await _db.isar.writeTxn(() async {
        existing.lastHeartbeat = DateTime.now();
        existing.ipAddress = ip;
        existing.port = port;
        await _db.isar.nearbyUserModels.put(existing);
      });
      return;
    }
    
    print("MeshNetworkService: Peer discovered via LAN: $meshId at $ip:$port");
    
    // Upsert user
    final user = existing ?? NearbyUserModel();
    user.meshId = meshId;
    user.name = data['username'];
    user.deviceName = data['deviceName'];
    user.ipAddress = ip;
    user.port = port;
    user.discoverySource = 'lan';
    user.connectionType = 'lan';
    user.isOnline = true;
    user.lastSeen = DateTime.now();
    user.lastHeartbeat = DateTime.now();
    user.connectionStatus = MeshConnectionState.connected.name;
    user.connectedAt ??= DateTime.now();
    
    await _db.isar.writeTxn(() async {
      await _db.isar.nearbyUserModels.put(user);
    });
  }

  Future<void> _pollLanHeartbeats() async {
    final allUsers = await _db.isar.nearbyUserModels.where().findAll();
    final lanUsers = allUsers.where((u) => u.isOnline && u.discoverySource == 'lan' && u.ipAddress != null && u.port != null).toList();
    
    for (final user in lanUsers) {
      _checkNodeHeartbeat(user);
    }
  }

  Future<void> _checkNodeHeartbeat(NearbyUserModel user) async {
    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 3);
      final request = await client.getUrl(Uri.parse('http://${user.ipAddress}:${user.port}/heartbeat'));
      final response = await request.close();
      
      if (response.statusCode == 200) {
        // Heartbeat ok
        await _db.isar.writeTxn(() async {
          final dbUser = await _db.isar.nearbyUserModels.get(user.id);
          if (dbUser != null) {
            dbUser.lastHeartbeat = DateTime.now();
            dbUser.lastSeen = DateTime.now();
            await _db.isar.nearbyUserModels.put(dbUser);
          }
        });
      }
    } catch (e) {
      // Heartbeat failed, let cleanup timer handle it
      // print("MeshNetworkService: Heartbeat check failed for ${user.meshId}: $e");
    }
  }

  Future<void> _cleanupStaleUsers() async {
    final now = DateTime.now();
    final allUsers = await _db.isar.nearbyUserModels.where().findAll();
    final users = allUsers.where((u) => u.isOnline).toList();
    final toUpdate = <NearbyUserModel>[];

    for (final user in users) {
      final lastInteraction = user.lastHeartbeat ?? user.lastSeen ?? user.connectedAt;
      if (lastInteraction == null || now.difference(lastInteraction).inSeconds > heartbeatTimeout) {
        print("MeshNetworkService: Peer offline removed: ${user.meshId}");
        user.isOnline = false;
        user.connectionStatus = MeshConnectionState.idle.name;
        toUpdate.add(user);
      }
    }

    if (toUpdate.isNotEmpty) {
      await _db.isar.writeTxn(() async {
        await _db.isar.nearbyUserModels.putAll(toUpdate);
      });
    }
  }
}
