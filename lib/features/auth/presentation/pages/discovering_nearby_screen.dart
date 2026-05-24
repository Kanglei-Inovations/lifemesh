import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:io';
import 'dart:math' as math;
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../controllers/network_discovery_controller.dart';
import '../controllers/onboarding_controller.dart';

class DiscoveringNearbyScreen extends StatelessWidget {
  const DiscoveringNearbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }
    final OnboardingController onboardingController =
        Get.find<OnboardingController>();
    final controller = Get.put(NetworkDiscoveryController());

    // Auto-start discovery upon landing on screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startDiscovery();
    });

    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      body: Stack(
        children: [
          const MeshBackground(),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.deepNavy.withValues(alpha: 0.8),
                  Colors.transparent,
                  AppColors.deepNavy.withValues(alpha: 0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(onboardingController),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'Discovering Your Network',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(
                          delay: const Duration(milliseconds: 200),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Finding people and connections around you\nto build your LifeMesh.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ).animate().fadeIn(
                          delay: const Duration(milliseconds: 300),
                        ),
                        const SizedBox(height: 40),

                        // Mesh Globe with Avatars
                        SizedBox(
                          height: 320,
                          child: _buildMeshGlobe(controller),
                        ).animate().scale(
                          delay: const Duration(milliseconds: 400),
                          curve: Curves.easeOutBack,
                        ),
                        const SizedBox(height: 40),

                        // Status List
                        _buildStatusCards(controller)
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 500))
                            .slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 24),

                        // Progress Section
                        _buildProgressSection(controller)
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 700))
                            .slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 32),

                        // Privacy Note
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.neonPurple.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                              child: const Icon(
                                Icons.security,
                                size: 14,
                                color: AppColors.neonPurple,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Your data is encrypted and stays 100% secure.',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ).animate().fadeIn(
                          delay: const Duration(milliseconds: 800),
                        ),
                        const SizedBox(height: 40),
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

  Widget _buildHeader(OnboardingController onboardingController) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onboardingController.previousStep,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCompletedStep('Create ID'),
                _buildStepConnector(isActive: true),
                _buildCompletedStep('Personal Info'),
                _buildStepConnector(isActive: true),
                _buildCompletedStep('Permissions'),
                _buildStepConnector(isActive: true),
                _buildActiveStep(5, 'Discovering'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedStep(String label) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: AppColors.neonPurple.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonPurple.withValues(alpha: 0.2),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, color: AppColors.cyanBlue, size: 14),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 8,
          ),
          maxLines: 1,
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }

  Widget _buildActiveStep(int step, String label) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.cyanBlue.withValues(alpha: 0.5),
                blurRadius: 10,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: AppColors.cyanBlue, fontSize: 8),
          maxLines: 1,
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }

  Widget _buildStepConnector({bool isActive = false}) {
    return Container(
      width: 15,
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 2).copyWith(bottom: 12),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.cyanBlue
            : Colors.white.withValues(alpha: 0.3),
        boxShadow: isActive
            ? [BoxShadow(color: AppColors.cyanBlue, blurRadius: 4)]
            : null,
      ),
    );
  }

  Widget _buildMeshGlobe(NetworkDiscoveryController controller) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Globe Background
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.neonPurple.withValues(alpha: 0.05),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyanBlue.withValues(alpha: 0.2),
                blurRadius: 40,
                spreadRadius: 5,
              ),
            ],
            border: Border.all(
              color: AppColors.neonPurple.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
        ),
        // Faux Grid Lines (Simplified visual representation of globe)
        CustomPaint(size: const Size(220, 220), painter: _GlobeGridPainter())
            .animate(onPlay: (controller) => controller.repeat())
            .rotate(duration: const Duration(seconds: 15)),

        // Center Core Logo
        Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.deepNavy,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyanBlue.withValues(alpha: 0.6),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.hub_outlined,
                size: 50,
                color: AppColors.cyanBlue,
              ),
            )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scaleXY(
              begin: 1.0,
              end: 1.1,
              duration: const Duration(seconds: 2),
            ),

        Obx(() {
          final users = controller.discoveredUsers;
          if (users.isEmpty) return const SizedBox.shrink();

          return Stack(
            alignment: Alignment.center,
            children: List.generate(users.length, (index) {
              final angle = (index * math.pi * 2) / users.length;
              return _buildOrbitingAvatar(
                angle,
                users[index],
                _discoveryColor(index),
                controller,
              );
            }),
          );
        }),
      ],
    );
  }

  Widget _buildOrbitingAvatar(
    double startAngle,
    DiscoveredUser user,
    Color ringColor,
    NetworkDiscoveryController controller,
  ) {
    return Obx(() {
      final currentAngle =
          startAngle + (controller.discoveryProgress.value * 2 * math.pi);
      const radius = 140.0;
      final avatar = user.avatarUrl;
      final ImageProvider? imageProvider = avatar.isEmpty
          ? null
          : (avatar.startsWith('http')
                ? NetworkImage(avatar)
                : FileImage(File(avatar)));

      return Transform.translate(
        offset: Offset(
          math.cos(currentAngle) * radius,
          math.sin(currentAngle) * radius,
        ),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.deepNavy,
            border: Border.all(color: ringColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: ringColor.withValues(alpha: 0.5),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ringColor.withValues(alpha: 0.16),
                image: imageProvider != null
                    ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
                    : null,
              ),
              alignment: Alignment.center,
              child: imageProvider == null
                  ? Text(
                      _initialsFor(user.name),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      );
    });
  }

  Color _discoveryColor(int index) {
    const colors = [
      AppColors.neonPurple,
      AppColors.cyanBlue,
      AppColors.softGlowPink,
      Colors.greenAccent,
    ];
    return colors[index % colors.length];
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

  Widget _buildStatusCards(NetworkDiscoveryController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Obx(
            () => _buildStatusRow(
              Icons.sensors,
              'Scanning nearby devices',
              AppColors.neonPurple,
              controller.discoveryProgress.value < 0.25,
              controller.discoveryProgress.value >= 0.25,
            ),
          ),
          _buildDivider(),
          Obx(
            () => _buildStatusRow(
              Icons.signal_cellular_alt,
              'Verifying signal signatures',
              AppColors.cyanBlue,
              controller.discoveryProgress.value >= 0.25 &&
                  controller.discoveryProgress.value < 0.50,
              controller.discoveryProgress.value >= 0.50,
            ),
          ),
          _buildDivider(),
          Obx(
            () => _buildStatusRow(
              Icons.enhanced_encryption_outlined,
              'Setting up encrypted mesh',
              AppColors.softGlowPink,
              controller.discoveryProgress.value >= 0.50 &&
                  controller.discoveryProgress.value < 0.75,
              controller.discoveryProgress.value >= 0.75,
            ),
          ),
          _buildDivider(),
          Obx(
            () => _buildStatusRow(
              Icons.people_outline,
              'Detecting nearby users',
              Colors.greenAccent,
              controller.discoveryProgress.value >= 0.75,
              controller.discoveryProgress.value >= 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(
    IconData icon,
    String text,
    Color color,
    bool isActive,
    bool isComplete,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: isActive ? color : Colors.white24, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white54,
                fontSize: 15,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          if (isActive)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            )
          else if (isComplete)
            Icon(Icons.check_circle, color: color, size: 20),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: Colors.white.withValues(alpha: 0.05));
  }

  Widget _buildProgressSection(NetworkDiscoveryController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              controller.scanningStatus.value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: controller.discoveryProgress.value,
                      minHeight: 8,
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.cyanBlue,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Obx(
                () => Text(
                  '${(controller.discoveryProgress.value * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlobeGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cyanBlue.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 1; i < 6; i++) {
      final yOffset = (radius / 3) * i - radius;
      final xRadius = math.sqrt(math.pow(radius, 2) - math.pow(yOffset, 2));
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(center.dx, center.dy + yOffset),
          width: xRadius * 2,
          height: xRadius * 0.4,
        ),
        paint,
      );
    }

    for (int i = 0; i < 6; i++) {
      canvas.drawArc(
        Rect.fromCenter(center: center, width: radius * 2, height: radius * 2),
        0,
        math.pi * 2,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
