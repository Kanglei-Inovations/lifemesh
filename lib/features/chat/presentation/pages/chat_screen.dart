import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'MESH MESSAGES',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.cyanBlue),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildOnlinePeers(),
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.chats.length,
                  itemBuilder: (context, index) {
                    final chat = controller.chats[index];
                    return _buildChatTile(chat, index);
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlinePeers() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.cyanBlue, width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.deepNavy,
                        child: Icon(Icons.person, color: Colors.white54),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.deepNavy, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text('Peer', style: TextStyle(fontSize: 10, color: Colors.white70)),
              ],
            ),
          );
        },
      ),
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }

  Widget _buildChatTile(ChatSummary chat, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 80,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [Colors.white.withValues(alpha: 0.05), Colors.white.withValues(alpha: 0.02)],
        ),
        borderGradient: LinearGradient(
          colors: [AppColors.cyanBlue.withValues(alpha: 0.1), AppColors.neonPurple.withValues(alpha: 0.1)],
        ),
        child: ListTile(
          onTap: () => Get.toNamed('/chat-detail', arguments: chat),
          leading: Stack(
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
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
          title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            chat.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(chat.time, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.4))),
              const SizedBox(height: 4),
              if (chat.unreadCount > 0)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: AppColors.neonPurple, shape: BoxShape.circle),
                  child: Text(
                    '${chat.unreadCount}',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1, end: 0);
  }
}
