import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../controllers/games_controller.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GamesController());

    return Scaffold(
      body: Stack(
        children: [
          const MeshBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: controller.availableGames.length,
                    itemBuilder: (context, index) {
                      final game = controller.availableGames[index];
                      return _buildGameCard(game, index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          const Text(
            'MESH GAMES',
            style: TextStyle(
              color: AppColors.cyanBlue,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          const Icon(Icons.sports_esports_outlined, color: AppColors.cyanBlue),
        ],
      ),
    );
  }

  Widget _buildGameCard(GameItem game, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 180,
        borderRadius: 24,
        blur: 20,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [game.color.withValues(alpha: 0.1), Colors.white.withValues(alpha: 0.05)],
        ),
        borderGradient: LinearGradient(
          colors: [game.color.withValues(alpha: 0.5), Colors.transparent],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: game.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(game.icon, size: 40, color: game.color),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      game.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      game.description,
                      style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildBadge(Icons.people, game.players),
                        const SizedBox(width: 12),
                        _buildBadge(Icons.bolt, game.latency),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColors.cyanBlue),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
