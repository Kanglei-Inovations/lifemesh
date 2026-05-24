import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../controllers/permission_controller.dart';
import '../controllers/onboarding_controller.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }
    final controller = Get.put(PermissionController());

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
                _buildHeader(controller.onboardingController),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'Allow Permissions',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: const Duration(milliseconds: 200)),
                        const SizedBox(height: 12),
                        Text(
                          'To give you the best LifeMesh experience,\nwe need access to a few things.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14, height: 1.4),
                        ).animate().fadeIn(delay: const Duration(milliseconds: 300)),
                        const SizedBox(height: 32),
                        
                        // Glowing Shield Illustration
                        _buildShieldIllustration().animate().scale(delay: const Duration(milliseconds: 400), curve: Curves.easeOutBack),
                        const SizedBox(height: 40),
                        
                        // Permissions List
                        Obx(() => _buildPermissionCard(
                          icon: Icons.location_on_outlined,
                          iconColor: AppColors.neonPurple,
                          title: 'Location',
                          description: 'Helps you connect with people\nnear you.',
                          isAllowed: controller.locationGranted.value,
                          onTap: controller.requestLocationPermission,
                        )).animate().fadeIn(delay: const Duration(milliseconds: 500)).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 16),
                        
                        Obx(() => _buildPermissionCard(
                          icon: Icons.bluetooth_connected,
                          iconColor: Colors.blueAccent,
                          title: 'Bluetooth & Nearby',
                          description: 'Required to build the offline\nmesh network securely.',
                          isAllowed: controller.bluetoothGranted.value,
                          onTap: controller.requestBluetoothPermission,
                        )).animate().fadeIn(delay: const Duration(milliseconds: 600)).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 16),
                        
                        Obx(() => _buildPermissionCard(
                          icon: Icons.notifications_none_outlined,
                          iconColor: AppColors.softGlowPink,
                          title: 'Notifications',
                          description: 'Keeps you updated about important\nactivities.',
                          isAllowed: controller.notificationGranted.value,
                          onTap: controller.requestNotificationPermission,
                        )).animate().fadeIn(delay: const Duration(milliseconds: 700)).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 16),
                        
                        Obx(() => _buildPermissionCard(
                          icon: Icons.image_outlined,
                          iconColor: AppColors.cyanBlue,
                          title: 'Photos & Media',
                          description: 'Lets you share photos and\nmedia on LifeMesh.',
                          isAllowed: controller.storageGranted.value,
                          onTap: controller.requestStoragePermission,
                        )).animate().fadeIn(delay: const Duration(milliseconds: 800)).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 24),
                        
                        // Privacy Notice
                        _buildPrivacyNotice().animate().fadeIn(delay: const Duration(milliseconds: 900)).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 32),
                        
                        // Continue Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!controller.isAllGranted.value) {
                                // Request anything that hasn't been granted
                                controller.requestAllPermissions().then((_) {
                                  controller.continueToNextStep();
                                });
                              } else {
                                controller.continueToNextStep();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                            ),
                            child: Obx(() => controller.isLoading.value 
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Continue',
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
                                )),
                          ),
                        ).animate().fadeIn(delay: const Duration(milliseconds: 1000)),
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
                _buildActiveStep(4, 'Permissions'),
              ],
            ),
          ),
          const SizedBox(width: 48), // Balance for back button
        ],
      ),
    );
  }

  Widget _buildCompletedStep(String label) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.5)),
            boxShadow: [BoxShadow(color: AppColors.neonPurple.withValues(alpha: 0.2), blurRadius: 8)],
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, color: AppColors.cyanBlue, size: 18),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildActiveStep(int step, String label) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [BoxShadow(color: AppColors.cyanBlue.withValues(alpha: 0.5), blurRadius: 10)],
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: AppColors.cyanBlue, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildStepConnector({bool isActive = false}) {
    return Container(
      width: 30,
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4).copyWith(bottom: 14),
      decoration: BoxDecoration(
        color: isActive ? AppColors.cyanBlue : Colors.white.withValues(alpha: 0.3),
        boxShadow: isActive ? [BoxShadow(color: AppColors.cyanBlue, blurRadius: 4)] : null,
      ),
    );
  }

  Widget _buildShieldIllustration() {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow Orbits
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.2), width: 1),
            ),
          ),
          Transform.scale(
            scaleX: 1.5,
            scaleY: 0.5,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.2), width: 1),
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat()).rotate(duration: const Duration(seconds: 10)),
          
          // Shield
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: AppColors.neonPurple.withValues(alpha: 0.5), blurRadius: 40, spreadRadius: 10),
                BoxShadow(color: AppColors.cyanBlue.withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 5),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.shield_outlined, size: 120, color: AppColors.neonPurple),
                Icon(Icons.shield, size: 100, color: AppColors.deepNavy.withValues(alpha: 0.8)),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.5), width: 1.5),
                  ),
                  child: const Icon(Icons.lock_outline, size: 28, color: Colors.white),
                ),
              ],
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(begin: 1.0, end: 1.05, duration: const Duration(seconds: 2)),

          // Floating Icons
          Positioned(
            top: 20,
            left: 20,
            child: _buildFloatingIcon(Icons.location_on_outlined, AppColors.neonPurple),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).slideY(begin: -0.2, end: 0.2, duration: const Duration(seconds: 2)),
          Positioned(
            bottom: 40,
            left: 10,
            child: _buildFloatingIcon(Icons.badge_outlined, Colors.blueAccent),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).slideY(begin: 0.2, end: -0.2, duration: const Duration(milliseconds: 2500)),
          Positioned(
            top: 10,
            right: 30,
            child: _buildFloatingIcon(Icons.notifications_none_outlined, AppColors.softGlowPink),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).slideY(begin: 0.1, end: -0.3, duration: const Duration(milliseconds: 2200)),
          Positioned(
            bottom: 60,
            right: 10,
            child: _buildFloatingIcon(Icons.image_outlined, AppColors.cyanBlue),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).slideY(begin: -0.3, end: 0.1, duration: const Duration(milliseconds: 2800)),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.deepNavy.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 10),
        ],
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }

  Widget _buildPermissionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required bool isAllowed,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isAllowed ? Color(0xFF00E676).withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 24, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12, height: 1.3),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (isAllowed)
              Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: Color(0xFF00E676), size: 18),
                  const SizedBox(width: 4),
                  const Text('Allowed', style: TextStyle(color: Color(0xFF00E676), fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              )
            else
              const Text('Allow', style: TextStyle(color: AppColors.cyanBlue, fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.5)),
            ),
            child: const Icon(Icons.security, size: 16, color: AppColors.neonPurple),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12, height: 1.4),
                children: const [
                  TextSpan(text: 'We value your privacy. You can change these permissions anytime from '),
                  TextSpan(text: 'Settings.', style: TextStyle(color: AppColors.neonPurple, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
