import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';

class DiscoveringNearbyScreen extends StatefulWidget {
  const DiscoveringNearbyScreen({super.key});

  @override
  State<DiscoveringNearbyScreen> createState() => _DiscoveringNearbyScreenState();
}

class _DiscoveringNearbyScreenState extends State<DiscoveringNearbyScreen> with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward().whenComplete(() {
        Get.offAllNamed('/welcome');
      });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                _buildHeader(),
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
                        ).animate().fadeIn(delay: const Duration(milliseconds: 200)),
                        const SizedBox(height: 12),
                        Text(
                          'Finding people and connections around you\nto build your LifeMesh.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14, height: 1.4),
                        ).animate().fadeIn(delay: const Duration(milliseconds: 300)),
                        const SizedBox(height: 40),
                        
                        // Mesh Globe with Avatars
                        SizedBox(
                          height: 320,
                          child: _buildMeshGlobe(),
                        ).animate().scale(delay: const Duration(milliseconds: 400), curve: Curves.easeOutBack),
                        const SizedBox(height: 40),
                        
                        // Status List
                        _buildStatusCards().animate().fadeIn(delay: const Duration(milliseconds: 500)).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 24),
                        
                        // Progress Section
                        _buildProgressSection().animate().fadeIn(delay: const Duration(milliseconds: 700)).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 32),
                        
                        // Privacy Note
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.5)),
                              ),
                              child: const Icon(Icons.security, size: 14, color: AppColors.neonPurple),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Your data is encrypted and stays 100% secure.',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
                            ),
                          ],
                        ).animate().fadeIn(delay: const Duration(milliseconds: 800)),
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

  Widget _buildHeader() {
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
              onPressed: () => Get.back(),
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
            border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.5)),
            boxShadow: [BoxShadow(color: AppColors.neonPurple.withValues(alpha: 0.2), blurRadius: 8)],
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, color: AppColors.cyanBlue, size: 14),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 8),
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
            boxShadow: [BoxShadow(color: AppColors.cyanBlue.withValues(alpha: 0.5), blurRadius: 10)],
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
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
        color: isActive ? AppColors.cyanBlue : Colors.white.withValues(alpha: 0.3),
        boxShadow: isActive ? [BoxShadow(color: AppColors.cyanBlue, blurRadius: 4)] : null,
      ),
    );
  }

  Widget _buildMeshGlobe() {
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
              BoxShadow(color: AppColors.cyanBlue.withValues(alpha: 0.2), blurRadius: 40, spreadRadius: 5),
            ],
            border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.2), width: 1),
          ),
        ),
        // Faux Grid Lines (Simplified visual representation of globe)
        CustomPaint(
          size: const Size(220, 220),
          painter: _GlobeGridPainter(),
        ).animate(onPlay: (controller) => controller.repeat()).rotate(duration: const Duration(seconds: 15)),
        
        // Center Core Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.deepNavy,
            boxShadow: [
              BoxShadow(color: AppColors.cyanBlue.withValues(alpha: 0.6), blurRadius: 20),
            ],
          ),
          child: const Icon(Icons.hub_outlined, size: 50, color: AppColors.cyanBlue),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(begin: 1.0, end: 1.1, duration: const Duration(seconds: 2)),

        // Orbiting Avatars
        _buildOrbitingAvatar(0, 'https://i.pravatar.cc/100?img=1', AppColors.neonPurple),
        _buildOrbitingAvatar(math.pi / 3, 'https://i.pravatar.cc/100?img=2', AppColors.cyanBlue),
        _buildOrbitingAvatar((2 * math.pi) / 3, 'https://i.pravatar.cc/100?img=3', AppColors.softGlowPink),
        _buildOrbitingAvatar(math.pi, 'https://i.pravatar.cc/100?img=4', AppColors.neonPurple),
        _buildOrbitingAvatar((4 * math.pi) / 3, 'https://i.pravatar.cc/100?img=5', AppColors.cyanBlue),
        _buildOrbitingAvatar((5 * math.pi) / 3, 'https://i.pravatar.cc/100?img=6', AppColors.softGlowPink),
      ],
    );
  }

  Widget _buildOrbitingAvatar(double startAngle, String imgUrl, Color ringColor) {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        // Full rotation over the entire progress duration
        final currentAngle = startAngle + (_progressController.value * 2 * math.pi);
        // Radius of orbit
        const radius = 140.0;
        
        return Transform.translate(
          offset: Offset(math.cos(currentAngle) * radius, math.sin(currentAngle) * radius),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.deepNavy,
              border: Border.all(color: ringColor, width: 2),
              boxShadow: [
                BoxShadow(color: ringColor.withValues(alpha: 0.5), blurRadius: 10),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusCards() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          _buildStatusRow(Icons.people_outline, 'Scanning for nearby users', AppColors.neonPurple),
          _buildDivider(),
          _buildStatusRow(Icons.wifi_tethering, 'Connecting securely', AppColors.cyanBlue),
          _buildDivider(),
          _buildStatusRow(Icons.security, 'Verifying connections', AppColors.softGlowPink),
        ],
      ),
    );
  }

  Widget _buildStatusRow(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.white.withValues(alpha: 0.05),
    );
  }

  Widget _buildProgressSection() {
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
          const Text(
            'Almost there! We\'re building your network.',
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _progressController.value,
                        minHeight: 8,
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyanBlue),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return Text(
                    '${(_progressController.value * 100).toInt()}%',
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  );
                },
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

    // Draw Latitudes
    for (int i = 1; i < 6; i++) {
      final yOffset = (radius / 3) * i - radius;
      final xRadius = math.sqrt(math.pow(radius, 2) - math.pow(yOffset, 2));
      canvas.drawOval(Rect.fromCenter(center: Offset(center.dx, center.dy + yOffset), width: xRadius * 2, height: xRadius * 0.4), paint);
    }
    
    // Draw Longitudes
    for(int i = 0; i < 6; i++) {
      canvas.drawArc(Rect.fromCenter(center: center, width: radius * 2, height: radius * 2), 0, math.pi * 2, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
