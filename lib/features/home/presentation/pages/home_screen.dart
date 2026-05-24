import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:io';
import 'dart:math' as math;
import '../../../../core/app_colors.dart';
import '../../../../core/constants/mesh_states.dart';
import '../../../../models/nearby_user_model.dart';
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
      backgroundColor: AppColors.deepNavy,
      body: Stack(
        children: [
          const MeshBackground(),
          SafeArea(
            bottom: false,
            child: Obx(
              () => IndexedStack(
                index: controller.currentIndex.value,
                children: [
                  _buildDashboard(context, controller),
                  const ChatScreen(),
                  const FeedScreen(),
                  const TimelineScreen(),
                  const ProfileScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(controller),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildDashboard(BuildContext context, HomeController controller) {
    final width = MediaQuery.sizeOf(context).width;
    final pagePadding = width < 360 ? 14.0 : (width < 420 ? 16.0 : 20.0);
    final compactGap = width < 380 ? 16.0 : 20.0;
    final sectionGap = width < 380 ? 20.0 : 24.0;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: pagePadding, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopHeader(controller),
          SizedBox(height: compactGap),
          _buildSearchBar(),
          SizedBox(height: compactGap),
          _buildMeshNetworkCard(controller),
          if (kDebugMode) ...[
            const SizedBox(height: 12),
            _buildDiscoveryDebugPanel(controller),
          ],
          SizedBox(height: sectionGap),
          _buildSectionTitle('QUICK ACTIONS', hasViewAll: true),
          const SizedBox(height: 8),
          _buildQuickActionsGrid(controller),
          const SizedBox(height: 8), // Tighter gap before next section
          _buildSectionTitle('NEARBY USERS', hasViewAll: true),
          const SizedBox(height: 12),
          _buildNearbyUsers(controller),
          SizedBox(height: sectionGap),
          _buildSectionTitle('RECENT ACTIVITY', hasViewAll: true),
          const SizedBox(height: 12),
          _buildRecentActivity(controller),
          const SizedBox(height: 100), // Padding for Bottom Nav and FAB
        ],
      ),
    );
  }

  Widget _buildShimmerBox({
    double? width,
    required double height,
    double radius = 16,
    BoxShape shape = BoxShape.rectangle,
    EdgeInsetsGeometry? margin,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.05),
      highlightColor: AppColors.cyanBlue.withValues(alpha: 0.22),
      period: const Duration(milliseconds: 1400),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          shape: shape,
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(radius),
          border: Border.all(
            color: AppColors.neonPurple.withValues(alpha: 0.12),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonPurple.withValues(alpha: 0.12),
              blurRadius: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader(HomeController controller) {
    return Obx(() {
      if (controller.isProfileLoading.value) {
        return _buildHeaderShimmer();
      }

      final displayName = controller.userName.value.isNotEmpty
          ? controller.userName.value
          : 'Profile not set';
      final statusColor = controller.isMeshActive.value
          ? Colors.greenAccent
          : Colors.white38;
      final activityCount = controller.recentActivities.length;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                // Profile Image with Active Dot
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonPurple.withValues(alpha: 0.4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: _buildProfileAvatarContent(
                          controller.profileImage.value,
                        ),
                      ),
                    ),
                    Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.deepNavy,
                              width: 2,
                            ),
                          ),
                        )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.2, 1.2),
                          duration: const Duration(seconds: 1),
                        ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13,
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              displayName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text('👋', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mesh Status Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                )
                                .animate(onPlay: (c) => c.repeat(reverse: true))
                                .fadeIn(duration: const Duration(seconds: 1)),
                            const SizedBox(width: 6),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 80),
                              child: Text(
                                controller.meshStatus.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.signalLabel(),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 9,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.signal_cellular_alt,
                              color: statusColor,
                              size: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Notification Bell
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.neonPurple.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      if (activityCount > 0)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.softGlowPink,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            activityCount > 9 ? '9+' : '$activityCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildHeaderShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildShimmerBox(width: 56, height: 56, shape: BoxShape.circle),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerBox(width: 92, height: 12, radius: 8),
                const SizedBox(height: 10),
                _buildShimmerBox(width: 150, height: 22, radius: 8),
                const SizedBox(height: 10),
                _buildShimmerBox(width: 130, height: 10, radius: 8),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                _buildShimmerBox(width: 92, height: 28, radius: 20),
                const SizedBox(width: 12),
                _buildShimmerBox(width: 42, height: 42, shape: BoxShape.circle),
              ],
            ),
            const SizedBox(height: 12),
            _buildShimmerBox(width: 112, height: 40, radius: 12),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileAvatarContent(String path) {
    ImageProvider? imageProvider;
    if (path.isNotEmpty) {
      imageProvider = path.startsWith('http')
          ? NetworkImage(path)
          : FileImage(File(path));
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.deepNavy,
        image: imageProvider == null
            ? null
            : DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
      alignment: Alignment.center,
      child: imageProvider == null
          ? const Icon(Icons.person_outline, color: Colors.white70, size: 26)
          : null,
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: AppColors.neonPurple.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search users, chats, files, posts...',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.3),
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.cyanBlue.withValues(alpha: 0.3),
            ),
          ),
          child: const Icon(
            Icons.qr_code_scanner,
            color: AppColors.cyanBlue,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildMeshNetworkCard(HomeController controller) {
    return Obx(() {
      if (controller.isDashboardLoading.value ||
          controller.isNearbyLoading.value) {
        return _buildMeshCardShimmer();
      }

      final statusColor = controller.isMeshActive.value
          ? Colors.greenAccent
          : Colors.white38;
      final subtitle = controller.isMeshActive.value
          ? 'You are connected to the local mesh'
          : 'No nearby mesh links are active yet';

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyanBlue.withValues(alpha: 0.05),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Right Side Animated Globe
            Positioned(
              right: -30,
              top: -20,
              bottom: -20,
              child: SizedBox(
                width: 220,
                child: CustomPaint(painter: _HeroGlobePainter())
                    .animate(onPlay: (c) => c.repeat())
                    .rotate(duration: const Duration(seconds: 20)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MESH NETWORK',
                        style: TextStyle(
                          color: AppColors.cyanBlue.withValues(alpha: 0.8),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: statusColor.withValues(alpha: 0.5),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scaleXY(
                            begin: 1,
                            end: 1.2,
                            duration: const Duration(seconds: 1),
                          ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          controller.meshStatus.value,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildStatBox(
                        Icons.people_alt_outlined,
                        () => '${controller.nearbyCount.value}',
                        'Nearby',
                        AppColors.cyanBlue,
                      ),
                      const SizedBox(width: 12),
                      _buildStatBox(
                        Icons.hub_outlined,
                        () => '${controller.connectionCount.value}',
                        'Connected\nNodes',
                        AppColors.cyanBlue,
                      ),
                      const SizedBox(width: 12),
                      _buildStatBox(
                        Icons.signal_cellular_alt,
                        () => controller.formatSignal(
                          controller.signalStrength.value,
                        ),
                        'Signal',
                        statusColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDiscoveryDebugPanel(HomeController controller) {
    return Obx(() {
      final endpointText = controller.endpointIds.isEmpty
          ? 'none'
          : controller.endpointIds.join(', ');
      final payload = controller.lastPayload.value;
      final payloadText = payload.isEmpty
          ? 'none'
          : (payload.length > 96 ? '${payload.substring(0, 96)}...' : payload);

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.neonPurple.withValues(alpha: 0.28),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonPurple.withValues(alpha: 0.08),
              blurRadius: 18,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.bug_report_outlined,
                  color: AppColors.cyanBlue,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'DEBUG MESH',
                  style: TextStyle(
                    color: AppColors.cyanBlue.withValues(alpha: 0.9),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildDebugChip(
                  'Advertising',
                  controller.isAdvertising.value ? 'on' : 'off',
                  controller.isAdvertising.value
                      ? Colors.greenAccent
                      : Colors.white38,
                ),
                _buildDebugChip(
                  'Discovery',
                  controller.isDiscovering.value ? 'on' : 'off',
                  controller.isDiscovering.value
                      ? AppColors.cyanBlue
                      : Colors.white38,
                ),
                _buildDebugChip(
                  'Connected',
                  '${controller.connectedEndpointCount.value}',
                  Colors.greenAccent,
                ),
                _buildDebugChip(
                  'Bluetooth',
                  controller.bluetoothEnabled.value ? 'on' : 'off',
                  controller.bluetoothEnabled.value
                      ? AppColors.cyanBlue
                      : Colors.redAccent,
                ),
                _buildDebugChip(
                  'Wi-Fi',
                  controller.wifiEnabled.value ? 'on' : 'off',
                  controller.wifiEnabled.value
                      ? AppColors.cyanBlue
                      : Colors.orangeAccent,
                ),

              ],
            ),
            if (controller.lastError.value.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.redAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        controller.lastError.value,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () => controller.startDiscovery(),
                  icon: const Icon(Icons.refresh, size: 14),
                  label: const Text(
                    'RETRY MESH START',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.cyanBlue,
                    backgroundColor: AppColors.cyanBlue.withValues(alpha: 0.1),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Text(
              'State: ${controller.connectionState.value.display}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Endpoint IDs: $endpointText',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.58),
                fontSize: 10,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Last payload: $payloadText',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.58),
                fontSize: 10,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDebugChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatBox(
    IconData icon,
    String Function() valueBuilder,
    String label,
    Color color,
  ) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            valueBuilder(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 9,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeshCardShimmer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerBox(width: 120, height: 10, radius: 8),
          const SizedBox(height: 16),
          _buildShimmerBox(width: 190, height: 28, radius: 10),
          const SizedBox(height: 10),
          _buildShimmerBox(width: 210, height: 12, radius: 8),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildShimmerBox(width: 70, height: 82, radius: 16),
              const SizedBox(width: 12),
              _buildShimmerBox(width: 70, height: 82, radius: 16),
              const SizedBox(width: 12),
              _buildShimmerBox(width: 70, height: 82, radius: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool hasViewAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.cyanBlue,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        if (hasViewAll)
          Row(
            children: [
              Text(
                'View All',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white54, size: 16),
            ],
          ),
      ],
    );
  }

  Widget _buildQuickActionsGrid(HomeController controller) {
    final actions = [
      {
        'name': 'Nearby Feed',
        'icon': Icons.people_outline,
        'color': AppColors.neonPurple,
      },
      {
        'name': 'Mesh Chat',
        'icon': Icons.chat_bubble_outline,
        'color': AppColors.cyanBlue,
      },
      {
        'name': 'File Sharing',
        'icon': Icons.folder_open,
        'color': Colors.greenAccent,
      },
      {
        'name': 'Marketplace',
        'icon': Icons.shopping_bag_outlined,
        'color': Colors.orangeAccent,
      },
      {
        'name': 'AI Timeline',
        'icon': Icons.psychology_outlined,
        'color': AppColors.neonPurple,
      },
      {
        'name': 'Games',
        'icon': Icons.sports_esports_outlined,
        'color': AppColors.softGlowPink,
      },
      {
        'name': 'Events',
        'icon': Icons.calendar_today_outlined,
        'color': Colors.redAccent,
      },
      {
        'name': 'Disaster Mode',
        'icon': Icons.sos_outlined,
        'color': Colors.red,
      },
    ];

    return Obx(() {
      if (controller.isQuickActionsLoading.value) {
        return _buildQuickActionsShimmer();
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 340;
          final gridGap = isCompact ? 5.0 : 8.0;
          final iconPadding = isCompact ? 8.0 : 10.0;
          final iconSize = isCompact ? 26.0 : 30.0;
          final labelSize = isCompact ? 9.0 : 10.0;

          return GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: gridGap,
              crossAxisSpacing: gridGap,
              childAspectRatio: isCompact ? 0.85 : 1.05,
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              final color = action['color'] as Color;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(iconPadding),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: color.withValues(alpha: 0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      action['icon'] as IconData,
                      color: color,
                      size: iconSize,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    action['name'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: labelSize,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: (index * 50).ms).scale();
            },
          );
        },
      );
    });
  }

  Widget _buildQuickActionsShimmer() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 340;
          final gridGap = isCompact ? 8.0 : 10.0;

          return GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: gridGap,
              crossAxisSpacing: gridGap,
              childAspectRatio: isCompact ? 0.85 : 1.05,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildShimmerBox(width: 48, height: 48, radius: 16),
                  const SizedBox(height: 6),
                  _buildShimmerBox(width: 52, height: 9, radius: 6),
                  const SizedBox(height: 4),
                  _buildShimmerBox(width: 36, height: 9, radius: 6),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildNearbyUsers(HomeController controller) {
    return SizedBox(
      height: 140,
      child: Obx(() {
        if (controller.isNearbyLoading.value) {
          return _buildNearbyUsersShimmer();
        }
        if (controller.nearbyUsers.isEmpty) {
          return _buildEmptyStateCard(
            icon: Icons.sensors_off_outlined,
            message:
                controller.isDiscovering.value || controller.isAdvertising.value
                ? 'Scanning for real nearby LifeMesh devices.'
                : 'No nearby mesh users found.',
          );
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.nearbyUsers.length,
          itemBuilder: (context, index) {
            final user = controller.nearbyUsers[index];
            final Color userColor = _getUserColor(index);
            final statusColor = _statusColorFor(user.connectionStatus);
            final deviceLabel =
                user.deviceName ??
                user.connectionStatus ??
                _shortEndpoint(user.endpointId);

            return Container(
              width: 100,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: userColor.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: userColor.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: userColor, width: 2),
                        ),
                        child: _buildNearbyAvatar(user, userColor),
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.deepNavy,
                            width: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.devices_other, color: userColor, size: 10),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          deviceLabel,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 9,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    user.name ?? 'Unnamed',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: userColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: userColor.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      (user.signalStrength ?? 0) > 0
                          ? '${((user.signalStrength ?? 0) * 100).round()}% signal'
                          : 'RSSI pending',
                      style: TextStyle(
                        color: userColor,
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Color _getUserColor(int index) {
    const colors = [
      AppColors.neonPurple,
      AppColors.cyanBlue,
      Colors.greenAccent,
      Colors.orangeAccent,
      AppColors.softGlowPink,
    ];
    return colors[index % colors.length];
  }

  Color _statusColorFor(String? status) {
    if (status == MeshConnectionState.connected.name) {
      return Colors.greenAccent;
    }
    if (status == MeshConnectionState.connecting.name) {
      return AppColors.cyanBlue;
    }
    if (status == MeshConnectionState.discovering.name) {
      return AppColors.neonPurple;
    }
    return Colors.white38;
  }

  String _shortEndpoint(String? endpointId) {
    if (endpointId == null || endpointId.isEmpty) return 'Nearby device';
    return endpointId.length <= 8
        ? endpointId
        : '${endpointId.substring(0, 8)}...';
  }

  Widget _buildRecentActivity(HomeController controller) {
    return Obx(() {
      if (controller.isActivityLoading.value) {
        return _buildActivitiesShimmer();
      }
      if (controller.recentActivities.isEmpty) {
        return _buildEmptyStateCard(
          icon: Icons.history_toggle_off_outlined,
          message: 'No recent activity yet.',
          height: 120,
        );
      }
      return Column(
        children: controller.recentActivities.map((activity) {
          IconData icon;
          Color color;
          if (activity.iconType == 'file') {
            icon = Icons.file_present_outlined;
            color = Colors.blueAccent;
          } else if (activity.iconType == 'user') {
            icon = Icons.person_add_outlined;
            color = Colors.greenAccent;
          } else if (activity.iconType == 'message') {
            icon = Icons.chat_bubble_outline;
            color = AppColors.neonPurple;
          } else {
            icon = Icons.hub_outlined;
            color = AppColors.cyanBlue;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity.timeAgo ?? '',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                if (activity.imagePreviews != null &&
                    activity.imagePreviews!.isNotEmpty)
                  Row(
                    children: activity.imagePreviews!
                        .map((img) => _buildActivityPreview(img))
                        .toList(),
                  )
                else if (activity.badgeCount != null)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.softGlowPink.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.softGlowPink.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      '${activity.badgeCount}',
                      style: const TextStyle(
                        color: AppColors.softGlowPink,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.greenAccent.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.person_add,
                      color: Colors.greenAccent,
                      size: 14,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildNearbyAvatar(NearbyUserModel user, Color color) {
    final avatar = user.avatar ?? '';
    ImageProvider? imageProvider;
    if (avatar.isNotEmpty) {
      imageProvider = avatar.startsWith('http')
          ? NetworkImage(avatar)
          : FileImage(File(avatar));
    }

    return CircleAvatar(
      radius: 21,
      backgroundColor: color.withValues(alpha: 0.16),
      backgroundImage: imageProvider,
      child: imageProvider == null
          ? Text(
              _initialsFor(user.name ?? ''),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }

  Widget _buildNearbyUsersShimmer() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          width: 100,
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.cyanBlue.withValues(alpha: 0.12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildShimmerBox(width: 46, height: 46, shape: BoxShape.circle),
              const SizedBox(height: 5),
              _buildShimmerBox(width: 40, height: 8, radius: 4),
              const SizedBox(height: 3),
              _buildShimmerBox(width: 60, height: 10, radius: 4),
              const SizedBox(height: 5),
              _buildShimmerBox(width: 64, height: 16, radius: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivitiesShimmer() {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              _buildShimmerBox(width: 44, height: 44, shape: BoxShape.circle),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerBox(
                      width: double.infinity,
                      height: 13,
                      radius: 8,
                    ),
                    const SizedBox(height: 8),
                    _buildShimmerBox(width: 96, height: 10, radius: 8),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _buildShimmerBox(width: 24, height: 24, radius: 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyStateCard({
    required IconData icon,
    required String message,
    double height = 140,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withValues(alpha: 0.08),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cyanBlue.withValues(alpha: 0.08),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.cyanBlue.withValues(alpha: 0.24),
              ),
            ),
            child: Icon(icon, color: AppColors.cyanBlue, size: 24),
          ),
          const SizedBox(width: 14),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityPreview(String source) {
    ImageProvider? imageProvider;
    if (source.startsWith('http')) {
      imageProvider = NetworkImage(source);
    } else if (source.isNotEmpty) {
      imageProvider = FileImage(File(source));
    }

    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: AppColors.cyanBlue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.18)),
        image: imageProvider == null
            ? null
            : DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
      child: imageProvider == null
          ? const Icon(
              Icons.insert_drive_file_outlined,
              color: AppColors.cyanBlue,
              size: 14,
            )
          : null,
    );
  }

  String _initialsFor(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }

  Widget _buildBottomBar(HomeController controller) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 80,
      borderRadius: 0,
      blur: 30,
      alignment: Alignment.center,
      border: 0,
      linearGradient: LinearGradient(
        colors: [
          AppColors.deepNavy.withValues(alpha: 0.85),
          AppColors.deepNavy.withValues(alpha: 0.95),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.1),
          Colors.white.withValues(alpha: 0.1),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_filled, 'Home', controller),
            _buildNavItem(1, Icons.chat_bubble_outline, 'Chat', controller),
            _buildNavItem(2, Icons.article_outlined, 'Feed', controller),
            _buildNavItem(3, Icons.access_time, 'Timeline', controller),
            _buildNavItem(4, Icons.person_outline, 'Profile', controller),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,
    HomeController controller,
  ) {
    bool isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child:
          Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? AppColors.cyanBlue : Colors.white54,
                    size: 26,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? AppColors.cyanBlue : Colors.white54,
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.cyanBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              )
              .animate(target: isSelected ? 1 : 0)
              .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
    );
  }

  Widget _buildFAB() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () => Get.toNamed('/file-sharing'),
        child:
            Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonPurple.withValues(alpha: 0.6),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, size: 32, color: Colors.white),
                )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(
                  begin: 1,
                  end: 1.05,
                  duration: const Duration(seconds: 2),
                ),
      ),
    );
  }
}

class _HeroGlobePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cyanBlue.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = AppColors.cyanBlue.withValues(alpha: 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw globe spheres
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius * 0.8, paint);
    canvas.drawCircle(center, radius * 0.5, paint);

    // Draw intersecting lines and dots
    final random = math.Random(42);
    for (int i = 0; i < 20; i++) {
      final angle = random.nextDouble() * math.pi * 2;
      final r = random.nextDouble() * radius;
      final pt = Offset(
        center.dx + math.cos(angle) * r,
        center.dy + math.sin(angle) * r,
      );

      canvas.drawCircle(pt, 2, dotPaint);
      canvas.drawCircle(pt, 4, glowPaint);

      // Connect to center occasionally
      if (random.nextBool()) {
        canvas.drawLine(
          center,
          pt,
          Paint()
            ..color = AppColors.cyanBlue.withValues(alpha: 0.1)
            ..strokeWidth = 0.5,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
