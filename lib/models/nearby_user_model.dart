import 'package:isar/isar.dart';

part 'nearby_user_model.g.dart';

@collection
class NearbyUserModel {
  Id id = Isar.autoIncrement;

  String? name;
  String? avatar;
  String? distance;
  double? signalStrength;
  DateTime? connectedAt;

  // Real device discovery fields
  String? endpointId; // Unique device endpoint ID from nearby_connections
  String? meshId; // Device's mesh network ID (UUID)
  String? deviceName; // Android device name
  DateTime? lastSeen; // Last successful ping
  String? connectionStatus; // idle/discovering/connecting/connected/failed
  
  // Heartbeat tracking
  bool isOnline = false;
  DateTime? lastHeartbeat;

  // Hybrid discovery fields
  String? discoverySource; // ble, lan, wifiDirect, internet
  String? connectionType; // p2p, lan, ble, proxy
  String? ipAddress; // LAN IP Address
  int? port; // LAN Port

  static NearbyUserModel fromPayload({
    required String endpointId,
    required String meshId,
    required String username,
    required String profileImage,
    required double signalStrength,
    required String? deviceName,
  }) {
    return NearbyUserModel()
      ..endpointId = endpointId
      ..meshId = meshId
      ..name = username
      ..avatar = profileImage
      ..signalStrength = signalStrength
      ..deviceName = deviceName
      ..connectedAt = DateTime.now()
      ..lastSeen = DateTime.now()
      ..isOnline = true
      ..lastHeartbeat = DateTime.now()
      ..connectionStatus = 'connected';
  }
}
