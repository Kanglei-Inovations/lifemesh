import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../../../chat/presentation/pages/chat_screen.dart';
import '../../../feed/presentation/pages/feed_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../../../timeline/presentation/pages/timeline_screen.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const MeshBackground(),
          SafeArea(
            bottom: false,
            child: Obx(() => IndexedStack(
                  index: controller.currentIndex.value,
                  children: [
                    _buildDashboard(context),
                    const ChatScreen(),
                    const TimelineScreen(),
                    const FeedScreen(),
                    const ProfileScreen(),
                  ],
                )),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(controller),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildDashboard(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(),
          const SizedBox(height: 30),
          _buildNetworkStatusCard(),
          const SizedBox(height: 30),
          Text(
            'MESH SERVICES',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          _buildServiceGrid(),
          const SizedBox(height: 30),
          _buildRecentActivity(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back,',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            ),
            const Text(
              'Nexus-User',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.3)),
          ),
          child: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildNetworkStatusCard() {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 140,
      borderRadius: 24,
      blur: 20,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.1), Colors.white.withValues(alpha: 0.05)],
      ),
      borderGradient: LinearGradient(
        colors: [AppColors.cyanBlue.withValues(alpha: 0.5), AppColors.neonPurple.withValues(alpha: 0.5)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _buildMiniRadar(),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'MESH ACTIVE',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '12 Peers Nearby',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total throughput: 2.4 MB/s',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }

  Widget _buildMiniRadar() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cyanBlue.withValues(alpha: 0.1),
      ),
      child: const Icon(Icons.radar, color: AppColors.cyanBlue, size: 40),
    ).animate(onPlay: (c) => c.repeat()).shimmer(duration: GetNumUtils(2).seconds);
  }

  Widget _buildServiceGrid() {
    final services = [
      {'name': 'Nearby Feed', 'icon': Icons.rss_feed, 'color': AppColors.neonPurple, 'route': '/home', 'index': 3},
      {'name': 'Mesh Chat', 'icon': Icons.chat_bubble_outline, 'color': AppColors.cyanBlue, 'route': '/home', 'index': 1},
      {'name': 'File Share', 'icon': Icons.share_outlined, 'color': Colors.orangeAccent, 'route': '/file-sharing'},
      {'name': 'Marketplace', 'icon': Icons.shopping_bag_outlined, 'color': AppColors.softGlowPink, 'route': '/marketplace'},
      {'name': 'AI Timeline', 'icon': Icons.auto_awesome, 'color': Colors.amberAccent, 'route': '/home', 'index': 2},
      {'name': 'Games', 'icon': Icons.sports_esports_outlined, 'color': Colors.greenAccent, 'route': '/games'},
      {'name': 'Disaster', 'icon': Icons.warning_amber_rounded, 'color': Colors.redAccent, 'route': '/disaster'},
      {'name': 'Settings', 'icon': Icons.settings_outlined, 'color': Colors.blueGrey, 'route': '/settings'},
    ];

    final controller = Get.find<HomeController>();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: () {
            if (service.containsKey('index')) {
              controller.changeIndex(service['index'] as int);
            } else {
              Get.toNamed(service['route'] as String);
            }
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (service['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: (service['color'] as Color).withValues(alpha: 0.3)),
                ),
                child: Icon(service['icon'] as IconData, color: service['color'] as Color),
              ),
              const SizedBox(height: 8),
              Text(
                service['name'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ).animate().fadeIn(delay: (index * 50).ms).scale();
      },
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RECENT ACTIVITY',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        _buildActivityTile('New device found: Cyber-Phone', '2 mins ago', Icons.devices),
        _buildActivityTile('Received "Project_Mesh.pdf"', '15 mins ago', Icons.file_download_outlined),
        _buildActivityTile('Nearby alert: Power outage in Sector 7', '1 hour ago', Icons.warning_amber_rounded),
      ],
    );
  }

  Widget _buildActivityTile(String title, String time, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.cyanBlue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14)),
                Text(time, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.4))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(HomeController controller) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 80,
      borderRadius: 0,
      blur: 20,
      alignment: Alignment.center,
      border: 0,
      linearGradient: LinearGradient(
        colors: [AppColors.deepNavy.withValues(alpha: 0.8), AppColors.deepNavy.withValues(alpha: 0.9)],
      ),
      borderGradient: LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.1), Colors.white.withValues(alpha: 0.1)],
      ),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.grid_view_rounded, controller),
              _buildNavItem(1, Icons.chat_bubble_rounded, controller),
              const SizedBox(width: 40), // Space for FAB
              _buildNavItem(2, Icons.auto_awesome_motion_rounded, controller),
              _buildNavItem(3, Icons.rss_feed_rounded, controller),
              _buildNavItem(4, Icons.person_rounded, controller),
            ],
          )),
    );
  }

  Widget _buildNavItem(int index, IconData icon, HomeController controller) {
    bool isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Icon(
        icon,
        color: isSelected ? AppColors.cyanBlue : Colors.white38,
        size: 28,
      ).animate(target: isSelected ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
    );
  }

  Widget _buildFAB() {
    return GestureDetector(
      onTap: () => Get.toNamed('/file-sharing'),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.cyanBlue.withValues(alpha: 0.4),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
    );
  }
}
