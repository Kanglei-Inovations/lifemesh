import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../controllers/feed_controller.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'NEARBY FEED',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune, color: AppColors.cyanBlue),
          ),
        ],
      ),
      body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return _buildPostCard(post, index);
            },
          )),
    );
  }

  Widget _buildPostCard(Post post, int index) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: post.hasImage ? 350 : 200,
      borderRadius: 24,
      blur: 15,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.05), Colors.white.withValues(alpha: 0.02)],
      ),
      borderGradient: LinearGradient(
        colors: [AppColors.cyanBlue.withValues(alpha: 0.2), AppColors.neonPurple.withValues(alpha: 0.2)],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.neonPurple.withValues(alpha: 0.2),
                  child: Text(post.username[0], style: const TextStyle(color: AppColors.cyanBlue)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        '${post.time} • ${post.distance} away',
                        style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz, color: Colors.white54),
              ],
            ),
            const SizedBox(height: 16),
            Text(post.content, style: const TextStyle(fontSize: 15, height: 1.4)),
            if (post.hasImage) ...[
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [AppColors.neonPurple.withValues(alpha: 0.1), AppColors.cyanBlue.withValues(alpha: 0.1)],
                    ),
                  ),
                  child: const Icon(Icons.image_outlined, size: 50, color: Colors.white24),
                ),
              ),
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAction(Icons.favorite_border, '${post.likes}'),
                _buildAction(Icons.chat_bubble_outline, '${post.comments}'),
                _buildAction(Icons.share_outlined, 'Relay'),
                const Icon(Icons.bookmark_border, size: 20, color: Colors.white54),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.white70),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.white70)),
      ],
    );
  }
}
