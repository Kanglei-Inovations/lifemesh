import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifemesh/core/database_service.dart';
import 'package:lifemesh/models/chat_message_model.dart';
import 'package:lifemesh/models/file_attachment_model.dart';
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
            child: Column(
              children: [
                _buildAppBar(peer),
                _buildSecurityBanner(),
                _buildMessageList(controller, peer),
                _buildInputArea(context, controller),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, color: Colors.white.withValues(alpha: 0.3), size: 14),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Messages are end-to-end encrypted. No one outside of this chat, not even LifeMesh, can read them.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(ChatDetailController controller, NearbyUserModel peer) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.messages.length,
          itemBuilder: (context, index) {
            final message = controller.messages[index];
            return _buildMessageRow(context, message, index, peer);
          },
        ),
      ),
    );
  }

  Widget _buildMessageRow(BuildContext context, ChatMessageModel message, int index, NearbyUserModel peer) {
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
              _buildMessageBubble(context, message),
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

  Widget _buildMessageBubble(BuildContext context, ChatMessageModel message) {
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
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
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
    if (message.attachmentId == null) return const SizedBox.shrink();

    return _buildAttachmentStream(message.attachmentId!, (FileAttachmentModel? attachment) {
      if (attachment == null) return const SizedBox.shrink();

      final displayPath = attachment.localPath ?? attachment.tempPath;
      final fileExists = displayPath != null && File(displayPath!).existsSync();

      return Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: fileExists
                ? Image.file(
                    File(displayPath!),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 200,
                    height: 200,
                    color: Colors.white.withValues(alpha: 0.1),
                    child: const Icon(Icons.image_not_supported_outlined, color: Colors.white38),
                  ),
          ),
          if (attachment.transferProgress < 1.0)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: attachment.transferProgress,
                      strokeWidth: 3,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyanBlue),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(attachment.transferProgress * 100).toInt()}%',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }

  Widget _buildFileContent(ChatMessageModel message) {
    if (message.attachmentId == null) return const SizedBox.shrink();

    return _buildAttachmentStream(message.attachmentId!, (FileAttachmentModel? attachment) {
      if (attachment == null) return const SizedBox.shrink();

      final isComplete = attachment.transferProgress >= 1.0;

      return Container(
        width: 200, // Constrain width for file card
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isComplete ? AppColors.neonPurple.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isComplete ? Icons.insert_drive_file : Icons.downloading, 
                    color: isComplete ? AppColors.neonPurple : Colors.white54, 
                    size: 24
                  ),
                ),
                if (!isComplete)
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      value: attachment.transferProgress,
                      strokeWidth: 2,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.neonPurple),
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
                    attachment.fileName,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isComplete 
                      ? '${(attachment.fileSize / (1024 * 1024)).toStringAsFixed(1)} MB'
                      : '${(attachment.transferProgress * 100).toInt()}% • ${(attachment.fileSize / (1024 * 1024)).toStringAsFixed(1)} MB',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAttachmentStream(int attachmentId, Widget Function(FileAttachmentModel?) builder) {
    final db = Get.find<DatabaseService>();
    return StreamBuilder<FileAttachmentModel?>(
      stream: db.isar.fileAttachmentModels.watchObject(attachmentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FutureBuilder<FileAttachmentModel?>(
            future: db.isar.fileAttachmentModels.get(attachmentId),
            builder: (context, futureSnapshot) => builder(futureSnapshot.data),
          );
        }
        return builder(snapshot.data);
      },
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

  Widget _buildInputArea(BuildContext context, ChatDetailController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.deepNavy,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _showAttachmentSheet(context, controller),
                    icon: Icon(Icons.attach_file, color: Colors.white.withValues(alpha: 0.4), size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {}, // Add emoji picker if needed
                    icon: Icon(Icons.emoji_emotions_outlined, color: Colors.white.withValues(alpha: 0.4), size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => controller.sendMessage(controller.textController.text),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _showAttachmentSheet(BuildContext context, ChatDetailController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.deepNavy,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption(Icons.image, 'Gallery', Colors.purple, () {
                  Get.back();
                  controller.pickImage(ImageSource.gallery);
                }),
                _buildAttachmentOption(Icons.camera_alt, 'Camera', Colors.pink, () {
                  Get.back();
                  controller.pickImage(ImageSource.camera);
                }),
                _buildAttachmentOption(Icons.description, 'Document', Colors.blue, () {
                  Get.back();
                  controller.pickDocument();
                }),
                _buildAttachmentOption(Icons.videocam, 'Video', Colors.orange, () {}),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
