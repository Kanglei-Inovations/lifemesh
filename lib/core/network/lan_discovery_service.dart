import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:udp/udp.dart';
import 'package:uuid/uuid.dart';
import 'package:isar/isar.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'package:lifemesh/core/database_service.dart';
import 'package:lifemesh/models/onboarding_user_model.dart';

class LanDiscoveryService extends GetxService {
  final DatabaseService _db = Get.find<DatabaseService>();
  
  UDP? _udpReceiver;
  UDP? _udpSender;
  
  static const int _broadcastPort = 53318;
  
  String _localMeshId = '';
  String _username = '';
  String _deviceName = '';
  
  Timer? _broadcastTimer;
  bool _isDiscovering = false;
  int _nodeServerPort = 53317;

  bool get isDiscovering => _isDiscovering;
  int get nodeServerPort => _nodeServerPort;

  // Callback to pass discovered info up to MeshNetworkService
  Function(Map<String, dynamic>)? onPeerDiscovered;

  Future<LanDiscoveryService> init() async {
    await _loadLocalIdentity();
    return this;
  }
  
  void setNodePort(int port) {
    _nodeServerPort = port;
  }

  Future<void> startDiscovery() async {
    if (_isDiscovering) return;
    print("LanDiscoveryService: Starting LAN discovery on port $_broadcastPort...");
    
    await _loadLocalIdentity();
    
    try {
      // Setup receiver
      _udpReceiver = await UDP.bind(Endpoint.any(port: const Port(_broadcastPort)));
      
      _udpReceiver?.asStream().listen((datagram) {
        if (datagram != null) {
          _handleDatagram(datagram);
        }
      });

      // Setup sender
      _udpSender = await UDP.bind(Endpoint.any());
      
      // Broadcast interval
      _broadcastTimer = Timer.periodic(const Duration(seconds: 4), (_) => _broadcastPresence());
      
      // Fire one immediately
      _broadcastPresence();
      
      _isDiscovering = true;
      print("LanDiscoveryService: Discovery active.");
    } catch (e) {
      print("LanDiscoveryService: Failed to start UDP $e");
    }
  }

  Future<void> stopDiscovery() async {
    if (!_isDiscovering) return;
    print("LanDiscoveryService: Stopping discovery...");
    
    _broadcastTimer?.cancel();
    _broadcastTimer = null;
    
    _udpReceiver?.close();
    _udpReceiver = null;
    
    _udpSender?.close();
    _udpSender = null;
    
    _isDiscovering = false;
  }

  Future<void> _loadLocalIdentity() async {
    final users = await _db.isar.onboardingUserModels.where().findAll();
    final user = users.isNotEmpty ? users.first : null;

    _localMeshId = user?.meshId ?? Uuid().v4();
    _username = user?.displayName ?? 'LifeMesh User';
    _deviceName = Platform.operatingSystem;
  }

  void _handleDatagram(Datagram datagram) {
    try {
      final str = utf8.decode(datagram.data);
      final data = jsonDecode(str);
      
      if (data['type'] == 'lifemesh_discovery') {
        final peerMeshId = data['meshId'];
        if (peerMeshId == _localMeshId) return; // Ignore own broadcast
        
        final peerIp = datagram.address.address;
        
        // Let's add IP to the data payload so the mesh network service knows how to connect
        data['ip'] = peerIp;
        
        if (onPeerDiscovered != null) {
          onPeerDiscovered!(data);
        }
      }
    } catch (e) {
      // Not our JSON, ignore
    }
  }

  Future<void> _broadcastPresence() async {
    if (_udpSender == null) return;
    
    // Attempt to get local IP (useful for subnet broadcast if 255.255.255.255 fails)
    final info = NetworkInfo();
    final wifiIP = await info.getWifiIP();
    
    final payload = {
      'type': 'lifemesh_discovery',
      'meshId': _localMeshId,
      'username': _username,
      'deviceName': _deviceName,
      'port': _nodeServerPort,
      'timestamp': DateTime.now().toIso8601String(),
    };
    
    final data = utf8.encode(jsonEncode(payload));
    
    try {
      // Global broadcast
      await _udpSender?.send(data, Endpoint.broadcast(port: const Port(_broadcastPort)));
      print("LanDiscoveryService: UDP broadcast sent");
    } catch (e) {
      print("LanDiscoveryService: Broadcast error: $e");
    }
  }
}
