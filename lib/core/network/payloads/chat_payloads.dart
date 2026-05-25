class ChatMessagePayload {
  final String messageId;
  final String roomId;
  final String senderMeshId;
  final String receiverMeshId;
  final String message;
  final DateTime timestamp;
  final String messageType;
  final String deviceTimestamp;

  ChatMessagePayload({
    required this.messageId,
    required this.roomId,
    required this.senderMeshId,
    required this.receiverMeshId,
    required this.message,
    required this.timestamp,
    required this.messageType,
    required this.deviceTimestamp,
  });

  Map<String, dynamic> toJson() => {
    'type': 'lifemesh.chat.message.v1',
    'messageId': messageId,
    'roomId': roomId,
    'senderMeshId': senderMeshId,
    'receiverMeshId': receiverMeshId,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
    'messageType': messageType,
    'deviceTimestamp': deviceTimestamp,
  };

  factory ChatMessagePayload.fromJson(Map<String, dynamic> json) {
    return ChatMessagePayload(
      messageId: json['messageId'],
      roomId: json['roomId'],
      senderMeshId: json['senderMeshId'],
      receiverMeshId: json['receiverMeshId'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      messageType: json['messageType'],
      deviceTimestamp: json['deviceTimestamp'],
    );
  }
}

class ChatAckPayload {
  final String messageId;
  final String roomId;
  final String senderMeshId;

  ChatAckPayload({
    required this.messageId,
    required this.roomId,
    required this.senderMeshId,
  });

  Map<String, dynamic> toJson() => {
    'type': 'lifemesh.chat.ack.v1',
    'messageId': messageId,
    'roomId': roomId,
    'senderMeshId': senderMeshId,
  };

  factory ChatAckPayload.fromJson(Map<String, dynamic> json) {
    return ChatAckPayload(
      messageId: json['messageId'],
      roomId: json['roomId'],
      senderMeshId: json['senderMeshId'],
    );
  }
}

class ChatTypingPayload {
  final String roomId;
  final String senderMeshId;
  final bool isTyping;

  ChatTypingPayload({
    required this.roomId,
    required this.senderMeshId,
    required this.isTyping,
  });

  Map<String, dynamic> toJson() => {
    'type': 'lifemesh.chat.typing.v1',
    'roomId': roomId,
    'senderMeshId': senderMeshId,
    'isTyping': isTyping,
  };

  factory ChatTypingPayload.fromJson(Map<String, dynamic> json) {
    return ChatTypingPayload(
      roomId: json['roomId'],
      senderMeshId: json['senderMeshId'],
      isTyping: json['isTyping'],
    );
  }
}
