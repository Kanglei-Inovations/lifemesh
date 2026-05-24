import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                  AppColors.deepNavy.withValues(alpha: 0.95),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Confetti Layer
          _buildConfettiLayer(),
          
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        
                        // Top Logo
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: AppColors.neonPurple.withValues(alpha: 0.3), blurRadius: 30, spreadRadius: 5),
                            ],
                          ),
                          child: const Icon(Icons.hub_outlined, size: 60, color: AppColors.cyanBlue),
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(begin: 0.95, end: 1.05, duration: const Duration(seconds: 2)),
                        
                        const SizedBox(height: 24),
                        
                        // Headline
                        ShaderMask(
                          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: const Text(
                            'Welcome to LifeMesh!',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ).animate().fadeIn(delay: const Duration(milliseconds: 200)).slideY(begin: 0.1, end: 0),
                        
                        const SizedBox(height: 12),
                        
                        Text(
                          'You\'re all set! Let\'s start building\nyour offline network. 🎉',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 16, height: 1.4),
                        ).animate().fadeIn(delay: const Duration(milliseconds: 400)),
                        
                        const SizedBox(height: 40),
                        
                        // Main Mesh Network Visualization
                        SizedBox(
                          height: 340,
                          child: _buildCompletedMesh(),
                        ).animate().scale(delay: const Duration(milliseconds: 600), curve: Curves.easeOutBack),
                        
                        const SizedBox(height: 40),
                        
                        // Feature Summary Cards
                        _buildFeatureRow().animate().fadeIn(delay: const Duration(milliseconds: 800)).slideY(begin: 0.1, end: 0),
                        
                        const SizedBox(height: 40),
                        
                        // Let's Explore Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(color: AppColors.neonPurple.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 8)),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.offAllNamed('/home'); // Journey complete, go to Home
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Let\'s Explore LifeMesh',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1),
                                  ),
                                  child: const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(delay: const Duration(milliseconds: 1000)).shimmer(delay: const Duration(milliseconds: 1500), duration: const Duration(milliseconds: 1500)),
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

  Widget _buildConfettiLayer() {
    return Stack(
      children: List.generate(20, (index) {
        final random = math.Random(index);
        final isCyan = random.nextBool();
        final size = random.nextDouble() * 8 + 4;
        return Positioned(
          left: random.nextDouble() * 400,
          top: random.nextDouble() * 600,
          child: Transform.rotate(
            angle: random.nextDouble() * math.pi,
            child: Container(
              width: size,
              height: size * (random.nextBool() ? 1.5 : 1),
              decoration: BoxDecoration(
                color: (isCyan ? AppColors.cyanBlue : AppColors.neonPurple).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(color: (isCyan ? AppColors.cyanBlue : AppColors.neonPurple).withValues(alpha: 0.8), blurRadius: 6),
                ],
              ),
            ),
          ),
        ).animate(onPlay: (controller) => controller.repeat())
         .moveY(begin: -20, end: 20, duration: Duration(milliseconds: 2000 + random.nextInt(2000)))
         .fadeIn(duration: const Duration(seconds: 1))
         .fadeOut(delay: const Duration(seconds: 2));
      }),
    );
  }

  Widget _buildCompletedMesh() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Network Lines & Rings
        CustomPaint(
          size: const Size(300, 300),
          painter: _FinalMeshPainter(),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(begin: 0.95, end: 1.05, duration: const Duration(seconds: 3)),
        
        // Outer Avatars (Static but pulsing)
        _buildMeshNode(0, 'https://i.pravatar.cc/100?img=12', AppColors.neonPurple),
        _buildMeshNode(math.pi / 3, 'https://i.pravatar.cc/100?img=13', AppColors.cyanBlue),
        _buildMeshNode((2 * math.pi) / 3, 'https://i.pravatar.cc/100?img=14', AppColors.softGlowPink),
        _buildMeshNode(math.pi, 'https://i.pravatar.cc/100?img=15', AppColors.neonPurple),
        _buildMeshNode((4 * math.pi) / 3, 'https://i.pravatar.cc/100?img=16', AppColors.cyanBlue),
        _buildMeshNode((5 * math.pi) / 3, 'https://i.pravatar.cc/100?img=17', AppColors.softGlowPink),

        // Central Main User Avatar
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(color: AppColors.neonPurple.withValues(alpha: 0.5), blurRadius: 40, spreadRadius: 5),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/300?img=11'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // Verified / Success Badge
            Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(bottom: 2, right: 2),
              decoration: BoxDecoration(
                color: AppColors.deepNavy,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.check, size: 16, color: Colors.white),
            ),
          ],
        ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(begin: 1.0, end: 1.05, duration: const Duration(seconds: 2)),
      ],
    );
  }

  Widget _buildMeshNode(double angle, String imgUrl, Color ringColor) {
    const radius = 130.0;
    return Transform.translate(
      offset: Offset(math.cos(angle) * radius, math.sin(angle) * radius),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.deepNavy,
          border: Border.all(color: ringColor.withValues(alpha: 0.8), width: 2),
          boxShadow: [
            BoxShadow(color: ringColor.withValues(alpha: 0.4), blurRadius: 15),
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
  }

  Widget _buildFeatureRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeatureItem(Icons.people_alt_outlined, 'Connect\nNearby', AppColors.neonPurple),
          _buildFeatureItem(Icons.security, 'Private &\nSecure', AppColors.cyanBlue),
          _buildFeatureItem(Icons.wifi_off, 'No Internet\nNeeded', Colors.blueAccent),
          _buildFeatureItem(Icons.chat_bubble_outline, 'Chat & Share\nOffline', AppColors.cyanBlue),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, Color color) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _FinalMeshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 130.0;
    
    final linePaint = Paint()
      ..color = AppColors.cyanBlue.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final dotPaint = Paint()
      ..color = AppColors.neonPurple
      ..style = PaintingStyle.fill;

    // Draw concentric rings
    canvas.drawCircle(center, radius, linePaint);
    canvas.drawCircle(center, radius * 0.6, Paint()..color = AppColors.neonPurple.withValues(alpha: 0.1)..style = PaintingStyle.stroke..strokeWidth = 1);

    // Draw connecting lines and dots
    for (int i = 0; i < 6; i++) {
      final angle = (i * math.pi) / 3;
      final outerPoint = Offset(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      );
      
      // Line from center to outer node
      canvas.drawLine(center, outerPoint, linePaint);
      
      // Little glowing dot midway
      final midPoint = Offset(
        center.dx + math.cos(angle) * (radius * 0.6),
        center.dy + math.sin(angle) * (radius * 0.6),
      );
      canvas.drawCircle(midPoint, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
