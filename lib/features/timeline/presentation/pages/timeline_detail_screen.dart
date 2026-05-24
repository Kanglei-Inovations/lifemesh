import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../controllers/timeline_controller.dart';

class TimelineDetailScreen extends StatelessWidget {
  const TimelineDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TimelineEvent event = Get.arguments;

    return Scaffold(
      body: Stack(
        children: [
          const MeshBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(event),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroSection(event),
                        const SizedBox(height: 30),
                        _buildDetailCard('RECONSTRUCTED DATA', [
                          _buildDetailRow(Icons.location_on_outlined, 'Location', 'Sector 4 Node Grid'),
                          _buildDetailRow(Icons.device_hub, 'Hops', '3 nodes traversed'),
                          _buildDetailRow(Icons.security, 'Encryption', 'AES-256 Mesh-Layer'),
                        ]),
                        const SizedBox(height: 24),
                        _buildDetailCard('INTERACTIONS', [
                          _buildInteractionAvatar('Nexus-Alpha'),
                          _buildInteractionAvatar('Cyber-Phone'),
                          _buildInteractionAvatar('Ghost-Node'),
                        ]),
                        const SizedBox(height: 24),
                        _buildAIStory(event),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(TimelineEvent event) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          const Spacer(),
          Text(
            event.time,
            style: const TextStyle(color: AppColors.cyanBlue, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildHeroSection(TimelineEvent event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: event.color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: event.color.withValues(alpha: 0.3)),
          ),
          child: Icon(event.icon, size: 40, color: event.color),
        ).animate().scale(curve: Curves.bounceInOut),
        const SizedBox(height: 24),
        Text(
          event.title,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.1),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),
      ],
    );
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 0, // Dynamic
      borderRadius: 24,
      blur: 15,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.05), Colors.white.withValues(alpha: 0.02)],
      ),
      borderGradient: LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.1), Colors.transparent],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.cyanBlue),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildInteractionAvatar(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.neonPurple.withValues(alpha: 0.2),
            child: Text(name[0], style: const TextStyle(fontSize: 10, color: AppColors.cyanBlue)),
          ),
          const SizedBox(width: 12),
          Text(name, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          const Icon(Icons.link, size: 16, color: Colors.white24),
        ],
      ),
    );
  }

  Widget _buildAIStory(TimelineEvent event) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cyanBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.amberAccent, size: 18),
              SizedBox(width: 8),
              Text('AI MEMORY RECONSTRUCTION', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Based on the local node activity at ${event.time}, your device established a high-bandwidth tunnel with nearby peers. This interaction pattern suggests a collaborative data exchange within the Sector 4 ecosystem. Encryption was verified end-to-end.",
            style: TextStyle(color: Colors.white.withValues(alpha: 0.7), height: 1.6, fontSize: 14),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).shimmer(duration: GetNumUtils(3).seconds);
  }
}
