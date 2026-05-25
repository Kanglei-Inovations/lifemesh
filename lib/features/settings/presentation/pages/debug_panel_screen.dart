import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/services/mesh_network_service.dart';
import '../../../../core/network/local_node_server.dart';
import '../../../../core/network/lan_discovery_service.dart';
import '../../../../core/constants/mesh_states.dart';
import '../../../../models/nearby_user_model.dart';

class DebugPanelScreen extends StatefulWidget {
  const DebugPanelScreen({super.key});

  @override
  State<DebugPanelScreen> createState() => _DebugPanelScreenState();
}

class _DebugPanelScreenState extends State<DebugPanelScreen> {
  final MeshNetworkService _meshService = Get.find<MeshNetworkService>();
  final LocalNodeServer _nodeServer = Get.find<LocalNodeServer>();
  final LanDiscoveryService _lanService = Get.find<LanDiscoveryService>();
  
  String _localIp = 'Unknown';
  String _subnet = 'Unknown';
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _fetchNetworkInfo();
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchNetworkInfo() async {
    final info = NetworkInfo();
    final wifiIP = await info.getWifiIP();
    if (wifiIP != null) {
      final parts = wifiIP.split('.');
      if (parts.length == 4) {
        setState(() {
          _localIp = wifiIP;
          _subnet = '${parts[0]}.${parts[1]}.${parts[2]}.x';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Developer Debug Panel', style: TextStyle(color: AppColors.cyanBlue, fontSize: 16)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Network Info'),
            _buildInfoRow('Local IP', _localIp),
            _buildInfoRow('Subnet', _subnet),
            
            const SizedBox(height: 20),
            _buildSectionTitle('Node Server Status'),
            _buildInfoRow('Running', _nodeServer.isRunning.toString()),
            _buildInfoRow('Port', _nodeServer.port.toString()),
            _buildInfoRow('Connected Sockets', '0'), // Socket count placeholder
            
            const SizedBox(height: 20),
            _buildSectionTitle('Mesh State'),
            _buildInfoRow('Global State', _meshService.globalState.value.name),
            _buildInfoRow('Is Scanning', _meshService.isScanning.value.toString()),
            _buildInfoRow('BLE State', _meshService.globalState.value != MeshConnectionState.failed ? 'Active' : 'Failed'),
            _buildInfoRow('LAN State', _meshService.isScanning.value ? 'Discovering' : 'Closed'),
            _buildInfoRow('WiFi Direct State', 'Idle'), // Placeholder as it's not implemented yet
            
            const SizedBox(height: 20),
            _buildSectionTitle('Discovered Peers (${_meshService.activeNearbyUsers.length})'),
            ..._meshService.activeNearbyUsers.map(_buildPeerCard),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 14)),
          Text(value, style: const TextStyle(color: Colors.greenAccent, fontSize: 14, fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget _buildPeerCard(NearbyUserModel user) {
    final now = DateTime.now();
    final age = user.lastHeartbeat != null ? now.difference(user.lastHeartbeat!).inSeconds : -1;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.meshId ?? 'Unknown ID', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          _buildInfoRow('Name', user.name ?? 'Unknown'),
          _buildInfoRow('IP:Port', '${user.ipAddress ?? 'N/A'}:${user.port ?? 'N/A'}'),
          _buildInfoRow('Source', user.discoverySource ?? 'N/A'),
          _buildInfoRow('Heartbeat Age', '${age}s ago'),
        ],
      ),
    );
  }
}
