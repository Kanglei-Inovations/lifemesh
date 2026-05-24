import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../../../../core/database_service.dart';
import '../../../../models/onboarding_state_model.dart';
import '../../../../models/onboarding_user_model.dart';

class SplashController extends GetxController {
  final dbService = Get.find<DatabaseService>();
  RxBool isLoading = true.obs;
  RxBool isOnboardingCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    final isar = dbService.isar;
    final user = await isar.onboardingUserModels.where().findFirst();
    final state = await isar.onboardingStateModels.where().findFirst();
    final hasCompletedProfile =
        user != null &&
        (user.onboardingCompleted || (state?.onboardingCompleted ?? false));

    if (hasCompletedProfile) {
      await _syncCompletedFlags(user, state);
      isOnboardingCompleted.value = true;
      Get.offAllNamed('/discovering');
    } else {
      isOnboardingCompleted.value = false;
      Get.offAllNamed('/identity');
    }
  }

  Future<void> _syncCompletedFlags(
    OnboardingUserModel user,
    OnboardingStateModel? state,
  ) async {
    final shouldUpdateUser = !user.onboardingCompleted;
    final shouldUpdateState = state == null || !state.onboardingCompleted;
    if (!shouldUpdateUser && !shouldUpdateState) return;

    await dbService.isar.writeTxn(() async {
      user.onboardingCompleted = true;
      user.createdAt ??= DateTime.now();
      await dbService.isar.onboardingUserModels.put(user);

      final nextState = state ?? OnboardingStateModel();
      nextState.onboardingCompleted = true;
      nextState.currentStep = 5;
      nextState.lastUpdated = DateTime.now();
      await dbService.isar.onboardingStateModels.put(nextState);
    });
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Logo & Title
                  Column(
                    children: [
                      const Icon(
                            Icons.hub_outlined,
                            size: 80,
                            color: AppColors.cyanBlue,
                          )
                          .animate()
                          .scale(duration: 800.ms, curve: Curves.easeInBack)
                          .shimmer(delay: GetNumUtils(1).seconds),
                      const SizedBox(height: 16),
                      Text(
                        'LifeMesh',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                      ).animate().fadeIn(delay: 200.ms),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                          children: const [
                            TextSpan(
                              text: 'Offline. ',
                              style: TextStyle(color: AppColors.neonPurple),
                            ),
                            TextSpan(
                              text: 'Together.',
                              style: TextStyle(color: AppColors.cyanBlue),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 400.ms),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'The world\'s first offline mesh\nnetwork that connects people,\nshares, and remembers everything\n— without internet.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ).animate().fadeIn(delay: 600.ms),
                  const Spacer(),
                  // Feature Cards
                  Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.03),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFeatureItem(
                              Icons.wifi_off,
                              'No Internet\nNeeded',
                              AppColors.cyanBlue,
                            ),
                            _buildFeatureItem(
                              Icons.lock_outline,
                              'Private &\nEncrypted',
                              AppColors.cyanBlue,
                            ),
                            _buildFeatureItem(
                              Icons.people_outline,
                              'Connect\nNearby',
                              AppColors.neonPurple,
                            ),
                            _buildFeatureItem(
                              Icons.security,
                              'Your Data\nStays Yours',
                              AppColors.softGlowPink,
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .slideY(begin: 0.2, end: 0, delay: 800.ms)
                      .fadeIn(),
                  const SizedBox(height: 24),
                  Obx(
                    () => Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonPurple.withValues(alpha: 0.35),
                            blurRadius: 22,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: AppColors.cyanBlue.withValues(alpha: 0.18),
                            blurRadius: 18,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.isLoading.value) ...[
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          const Text(
                            'Mesh Discovery',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 200.ms).scale(delay: 200.ms),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.neonPurple.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.security,
                          size: 12,
                          color: AppColors.neonPurple,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'End-to-end encrypted. Your data is 100% secure.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ).animate().fadeIn(delay: 1200.ms),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, Color iconColor) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 28),
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
