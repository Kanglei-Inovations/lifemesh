import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lifemesh/models/chat_message_model.dart';
import 'package:lifemesh/models/nearby_user_model.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../controllers/chat_detail_controller.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final String roomId = args['roomId'];
    final NearbyUserModel peer = args['peer'];
    
    final controller = Get.put(ChatDetailController(roomId: roomId, peer: peer));

    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      body: Stack(
        children: [
          const MeshBackground(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildAppBar(peer),
                Expanded(
                  child: Column(
                    children: [
                      _buildSecurityBanner(),
                      _buildMessageList(controller, peer),
                      _buildAISuggestions(controller),
                      _buildInputArea(controller),
                      _buildBottomStatus(peer),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(NearbyUserModel peer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          Stack(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.5), width: 1),
                ),
                child: ClipOval(
                  child: peer.avatar != null && peer.avatar!.startsWith('http')
                    ? Image.network(
                        peer.avatar!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.white),
                      )
                    : const Icon(Icons.person, color: Colors.white),
                ),
              ),
              if (peer.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.deepNavy, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  peer.name ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${peer.isOnline ? "Online" : "Offline"} • ${peer.distance ?? "Nearby"}',
                  style: TextStyle(
                    color: peer.isOnline ? Colors.greenAccent : Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          _buildAppBarAction(Icons.security_outlined, hasDot: true),
          const SizedBox(width: 12),
          _buildAppBarAction(Icons.phone_outlined),
          const SizedBox(width: 12),
          _buildAppBarAction(Icons.more_vert),
        ],
      ),
    );
  }

  Widget _buildAppBarAction(IconData icon, {bool hasDot = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          if (hasDot)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSecurityBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A1F3D).withValues(alpha: 0.5),
            const Color(0xFF0D1127).withValues(alpha: 0.5),
          ],
        ),
        border: Border.all(
          color: AppColors.neonPurple.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, color: AppColors.neonPurple, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'End-to-end encrypted',
                  style: TextStyle(
                    color: AppColors.neonPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      'Messages are secured in the mesh network',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.info_outline, color: Colors.white.withValues(alpha: 0.4), size: 12),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.hub_outlined, color: AppColors.cyanBlue, size: 30),
        ],
      ),
    );
  }

  Widget _buildMessageList(ChatDetailController controller, NearbyUserModel peer) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.messages.length + 1, // +1 for the date header
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }
            final message = controller.messages[index - 1];
            return _buildMessageRow(message, index - 1, peer);
          },
        ),
      ),
    );
  }

  Widget _buildMessageRow(ChatMessageModel message, int index, NearbyUserModel peer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMine) _buildMessageAvatar(peer.avatar, peer.meshId ?? 'unknown'),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: message.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              _buildMessageBubble(message),
              const SizedBox(height: 6),
              _buildHopIndicator(message),
            ],
          ),
          const SizedBox(width: 12),
          if (message.isMine) _buildMessageAvatar(null, 'me'),
        ],
      ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildMessageAvatar(String? avatarUrl, String id) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
      ),
      child: ClipOval(
        child: avatarUrl != null && avatarUrl.startsWith('http')
          ? Image.network(
              avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.white, size: 16),
            )
          : const Icon(Icons.person, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessageModel message) {
    Widget content;
    switch (message.messageType) {
      case MessageType.voice:
        content = _buildVoiceContent(message);
        break;
      case MessageType.location:
        content = _buildLocationContent(message);
        break;
      case MessageType.image:
        content = _buildImageContent(message);
        break;
      case MessageType.file:
        content = _buildFileContent(message);
        break;
      default:
        content = _buildTextContent(message);
    }

    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * 0.7),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: message.isMine ? const Color(0xFF00383F).withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: message.isMine ? AppColors.cyanBlue.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          content,
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 10,
                ),
              ),
              if (message.isMine) ...[
                const SizedBox(width: 4),
                _buildStatusIcon(message.deliveryStatus),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(ChatMessageModel message) {
    return Text(
      message.text,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    );
  }

  Widget _buildVoiceContent(ChatMessageModel message) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFF4D3DFF),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        _buildVoiceWaveform(),
        const SizedBox(width: 12),
        const Text(
          '0:12',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildVoiceWaveform() {
    return Row(
      children: List.generate(
        15,
        (index) => Container(
          margin: const EdgeInsets.only(right: 2),
          width: 2,
          height: 10 + (index % 5) * 4,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationContent(ChatMessageModel message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.greenAccent, size: 16),
            const SizedBox(width: 8),
            const Text(
              'Current location',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Tap to view on map',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://picsum.photos/seed/map/400/200',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.white.withValues(alpha: 0.1),
                    child: const Icon(Icons.map_outlined, color: Colors.white38),
                  ),
                ),
                const Center(
                  child: Icon(Icons.location_on, color: Colors.redAccent, size: 30),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContent(ChatMessageModel message) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            'https://picsum.photos/seed/fest/400/300',
            width: 200,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 200,
              height: 150,
              color: Colors.white.withValues(alpha: 0.1),
              child: const Icon(Icons.image_not_supported_outlined, color: Colors.white38),
            ),
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.reply, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildFileContent(ChatMessageModel message) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.insert_drive_file, color: AppColors.neonPurple, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Document.pdf',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                '2.4 MB • PDF',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHopIndicator(ChatMessageModel message) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.only(right: 4),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index < 1 ? AppColors.cyanBlue : Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Delivered via 1 hop',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIcon(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.sending:
        return Icon(Icons.access_time, size: 12, color: Colors.white.withValues(alpha: 0.3));
      case DeliveryStatus.sent:
        return Icon(Icons.check, size: 12, color: Colors.white.withValues(alpha: 0.3));
      case DeliveryStatus.delivered:
        return Icon(Icons.done_all, size: 12, color: Colors.white.withValues(alpha: 0.3));
      case DeliveryStatus.read:
        return const Icon(Icons.done_all, size: 12, color: AppColors.cyanBlue);
      case DeliveryStatus.failed:
        return const Icon(Icons.error_outline, size: 12, color: Colors.redAccent);
    }
  }

  Widget _buildAISuggestions(ChatDetailController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1127).withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.neonPurple, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'AI Smart Replies',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
              Icon(Icons.close, color: Colors.white.withValues(alpha: 0.3), size: 16),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.aiSuggestions.map((text) => GestureDetector(
                onTap: () => controller.sendMessage(text),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.3)),
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(ChatDetailController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.deepNavy,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Row(
        children: [
          _buildSquareIconButton(Icons.add),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.textController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) => controller.sendMessage(value),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.white24),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.emoji_emotions_outlined, color: Colors.white.withValues(alpha: 0.4), size: 20),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => controller.sendMessage(controller.textController.text),
                    icon: const Icon(Icons.send, color: AppColors.cyanBlue, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
            ),
            child: const Icon(Icons.mic, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF4D3DFF).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: const Color(0xFF4D3DFF), size: 20),
    );
  }

  Widget _buildBottomStatus(NearbyUserModel peer) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: AppColors.deepNavy,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusItem(Icons.sensors, 'Mesh Network', 'Strong Signal', Colors.greenAccent),
          _buildStatusItem(Icons.circle_outlined, 'Peer', peer.isOnline ? 'Online' : 'Offline', peer.isOnline ? Colors.greenAccent : Colors.white38),
          _buildStatusItem(Icons.battery_3_bar, 'Mesh Type', peer.connectionType ?? 'Nearby', Colors.white),
        ],
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 9),
            ),
            Text(
              value,
              style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
