enum MeshConnectionState {
  idle,
  advertising,
  discovering,
  connecting,
  connected,
  failed,
}

extension MeshStateDisplay on MeshConnectionState {
  String get display {
    switch (this) {
      case MeshConnectionState.idle:
        return 'Idle';
      case MeshConnectionState.advertising:
        return 'Advertising...';
      case MeshConnectionState.discovering:
        return 'Discovering...';
      case MeshConnectionState.connecting:
        return 'Connecting...';
      case MeshConnectionState.connected:
        return 'Connected';
      case MeshConnectionState.failed:
        return 'Connection Failed';
    }
  }
}
