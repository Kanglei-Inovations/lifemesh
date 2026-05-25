import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart' hide Response;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';
import 'package:isar/isar.dart';

import 'package:lifemesh/core/database_service.dart';
import 'package:lifemesh/core/services/crypto_service.dart';
import 'package:lifemesh/core/network/message_bus.dart';
import 'package:lifemesh/core/network/payloads/chat_payloads.dart';
import 'package:lifemesh/models/onboarding_user_model.dart';

import 'package:network_info_plus/network_info_plus.dart';

class LocalNodeServer extends GetxService {
  final DatabaseService _db = Get.find<DatabaseService>();
  final CryptoService _cryptoService = Get.find<CryptoService>();
  final MessageBus _messageBus = Get.find<MessageBus>();
  
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
    final user = await _db.isar.onboardingUserModels.where().findFirst();
    if (user != null && user.meshId != null) {
      _localMeshId = user.meshId!;
    } else {
      _localMeshId = const Uuid().v4();
      if (user != null) {
        await _db.isar.writeTxn(() async {
          user.meshId = _localMeshId;
          await _db.isar.onboardingUserModels.put(user);
        });
        print("LocalNodeServer: Generated and saved new MeshID: $_localMeshId");
      }
    }
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
    try {
      final bytes = await request.read().expand((chunk) => chunk).toList();
      final decryptedMap = await _cryptoService.decryptMessage(bytes);
      
      if (decryptedMap != null) {
        print("LocalNodeServer: Decrypted message type: ${decryptedMap['type']}");
        
        if (decryptedMap['type'] == 'lifemesh.chat.message.v1') {
          _messageBus.publishChatMessage(ChatMessagePayload.fromJson(decryptedMap));
        } else if (decryptedMap['type'] == 'lifemesh.chat.ack.v1') {
          _messageBus.publishAck(ChatAckPayload.fromJson(decryptedMap));
        } else if (decryptedMap['type'] == 'lifemesh.chat.typing.v1') {
          _messageBus.publishTyping(ChatTypingPayload.fromJson(decryptedMap));
        }
        
        return Response.ok(jsonEncode({'status': 'delivered'}), headers: {'content-type': 'application/json'});
      } else {
        return Response.forbidden('Decryption failed');
      }
    } catch (e) {
      print("LocalNodeServer: Error handling message: $e");
      return Response.badRequest(body: 'Invalid Request');
    }
  }

  Response _handleStatus(Request request) {
    return Response.ok(jsonEncode({'status': 'running', 'port': _port}), headers: {'content-type': 'application/json'});
  }
}
