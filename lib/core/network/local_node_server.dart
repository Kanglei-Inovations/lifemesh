import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart' hide Response;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';
import 'package:isar/isar.dart';

import 'package:lifemesh/core/database_service.dart';
import 'package:lifemesh/models/onboarding_user_model.dart';

import 'package:network_info_plus/network_info_plus.dart';

class LocalNodeServer extends GetxService {
  final DatabaseService _db = Get.find<DatabaseService>();
  
  HttpServer? _server;
  int _port = 53317; // Default local port
  
  String _localMeshId = '';
  String _username = '';
  String _deviceName = '';

  int get port => _port;
  bool get isRunning => _server != null;

  Future<LocalNodeServer> init() async {
    await _loadLocalIdentity();
    return this;
  }

  Future<void> startServer() async {
    if (_server != null) return;
    
    await _loadLocalIdentity();

    final router = Router();

    // Endpoints
    router.get('/identity', _handleIdentity);
    router.get('/heartbeat', _handleHeartbeat);
    router.post('/message', _handleMessage);
    router.get('/status', _handleStatus);

    final handler = Pipeline()
        .addMiddleware(logRequests())
        .addHandler(router.call);

    final info = NetworkInfo();
    final wifiIP = await info.getWifiIP() ?? '0.0.0.0';

    try {
      // Try to bind to the default port, if in use, bind to any available port
      _server = await shelf_io.serve(handler, InternetAddress.anyIPv4, _port);
      print('LocalNodeServer running on IP: $wifiIP Port: ${_server?.port}');
    } catch (e) {
      print('LocalNodeServer: Failed to bind to port $_port, trying any port... $e');
      _server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 0);
      _port = _server!.port;
      print('LocalNodeServer running on IP: $wifiIP Port: ${_server?.port}');
    }
  }

  Future<void> stopServer() async {
    print("Stopping LocalNodeServer...");
    await _server?.close(force: true);
    _server = null;
  }

  Future<void> _loadLocalIdentity() async {
    final users = await _db.isar.onboardingUserModels.where().findAll();
    final user = users.isNotEmpty ? users.first : null;

    _localMeshId = user?.meshId ?? Uuid().v4();
    _username = user?.displayName ?? 'LifeMesh User';
    
    // Simple device name extraction
    _deviceName = Platform.operatingSystem; 
  }

  Response _handleIdentity(Request request) {
    print("LocalNodeServer: /identity called");
    final payload = {
      'meshId': _localMeshId,
      'username': _username,
      'deviceName': _deviceName,
      'type': 'lifemesh_node'
    };
    return Response.ok(jsonEncode(payload), headers: {'content-type': 'application/json'});
  }

  Response _handleHeartbeat(Request request) {
    print("LocalNodeServer: /heartbeat called. Heartbeat received.");
    final payload = {
      'status': 'alive',
      'meshId': _localMeshId,
      'timestamp': DateTime.now().toIso8601String(),
    };
    return Response.ok(jsonEncode(payload), headers: {'content-type': 'application/json'});
  }

  Future<Response> _handleMessage(Request request) async {
    print("LocalNodeServer: /message called");
    final body = await request.readAsString();
    try {
      final data = jsonDecode(body);
      print("LocalNodeServer received message: $data");
      // TODO: Handle incoming message (pass to ChatService or MeshNetworkService)
      return Response.ok(jsonEncode({'status': 'delivered'}), headers: {'content-type': 'application/json'});
    } catch (e) {
      return Response.badRequest(body: 'Invalid JSON');
    }
  }

  Response _handleStatus(Request request) {
    return Response.ok(jsonEncode({'status': 'running', 'port': _port}), headers: {'content-type': 'application/json'});
  }
}
