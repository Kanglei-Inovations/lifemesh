import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../controllers/chat_controller.dart';
import '../controllers/chat_detail_controller.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatSummary chat = Get.arguments;
    final controller = Get.put(ChatDetailController());

    return Scaffold(
      body: Stack(
        children: [
          const MeshBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(chat),
                _buildMessageList(controller),
                _buildAISuggestions(controller),
                _buildInputArea(controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(ChatSummary chat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.deepNavy.withValues(alpha: 0.5),
        border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.cyanBlue.withValues(alpha: 0.1),
                child: Text(chat.name[0], style: const TextStyle(color: AppColors.cyanBlue)),
              ),
              if (chat.isOnline)
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
                Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                  chat.isOnline ? 'Mesh Connected' : 'Offline',
                  style: TextStyle(
                    fontSize: 12,
                    color: chat.isOnline ? AppColors.cyanBlue : Colors.white38,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(ChatDetailController controller) {
    return Expanded(
      child: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(20),
            reverse: false,
            itemCount: controller.messages.length,
            itemBuilder: (context, index) {
              final message = controller.messages[index];
              return _buildMessageBubble(message, index);
            },
          )),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, int index) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(maxWidth: Get.width * 0.75),
        child: Column(
          crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            GlassmorphicContainer(
              width: double.infinity,
              height: 0, // Dynamic height fix below
              borderRadius: 20,
              blur: 10,
              alignment: Alignment.center,
              border: 1,
              linearGradient: LinearGradient(
                colors: message.isMe
                    ? [AppColors.neonPurple.withValues(alpha: 0.2), AppColors.neonPurple.withValues(alpha: 0.1)]
                    : [Colors.white.withValues(alpha: 0.1), Colors.white.withValues(alpha: 0.05)],
              ),
              borderGradient: LinearGradient(
                colors: message.isMe
                    ? [AppColors.neonPurple.withValues(alpha: 0.5), Colors.transparent]
                    : [AppColors.cyanBlue.withValues(alpha: 0.5), Colors.transparent],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  message.text,
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time,
                  style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.3)),
                ),
                if (message.isMe) ...[
                  const SizedBox(width: 4),
                  _buildStatusIcon(message.status),
                ],
              ],
            ),
          ],
        ),
      ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: message.isMe ? 0.1 : -0.1, end: 0),
    );
  }

  Widget _buildStatusIcon(MessageStatus status) {
    IconData icon;
    Color color = Colors.white38;
    switch (status) {
      case MessageStatus.sending:
        icon = Icons.access_time;
        break;
      case MessageStatus.sent:
        icon = Icons.check;
        break;
      case MessageStatus.received:
        icon = Icons.done_all;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = AppColors.cyanBlue;
        break;
    }
    return Icon(icon, size: 12, color: color);
  }

  Widget _buildAISuggestions(ChatDetailController controller) {
    return Obx(() => Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.aiSuggestions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => controller.sendMessage(controller.aiSuggestions[index]),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.3)),
                    color: AppColors.cyanBlue.withValues(alpha: 0.05),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome, size: 14, color: Colors.amberAccent),
                        const SizedBox(width: 8),
                        Text(
                          controller.aiSuggestions[index],
                          style: const TextStyle(fontSize: 12, color: AppColors.cyanBlue),
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: (index * 100).ms).scale();
            },
          ),
        ));
  }

  Widget _buildInputArea(ChatDetailController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.deepNavy.withValues(alpha: 0.8),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline, color: Colors.white70),
          ),
          Expanded(
            child: TextField(
              controller: controller.textController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Neural link active...',
                hintStyle: TextStyle(color: Colors.white24),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              onSubmitted: (val) => controller.sendMessage(val),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
            ),
            child: IconButton(
              onPressed: () => controller.sendMessage(controller.textController.text),
              icon: const Icon(Icons.send_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
