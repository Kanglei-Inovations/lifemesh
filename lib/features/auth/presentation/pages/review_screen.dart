import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:io';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../../../../core/database_service.dart';
import '../../../../models/onboarding_user_model.dart';
import '../controllers/onboarding_controller.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }
    final OnboardingController onboardingController = Get.find<OnboardingController>();
    final DatabaseService db = Get.find<DatabaseService>();

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
            child: FutureBuilder<OnboardingUserModel?>(
              future: db.isar.onboardingUserModels.where().findFirst(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.cyanBlue));
                }
                
                final user = snapshot.data;
                final bool isPrivate = user?.isPrivate ?? true;

                return Column(
                  children: [
                    _buildHeader(onboardingController),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Review Your Information',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ).animate().fadeIn(delay: 200.ms),
                            const SizedBox(height: 12),
                            Text(
                              'Please review your details before creating\nyour LifeMesh ID.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14, height: 1.4),
                            ).animate().fadeIn(delay: 300.ms),
                            const SizedBox(height: 32),
                            
                            _buildProfileSummaryCard(user, onboardingController).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                            const SizedBox(height: 20),
                            
                            _buildDetailsCard(user).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                            const SizedBox(height: 20),
                            
                            _buildTermsCard().animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
                            const SizedBox(height: 40),
                            
                            // Create ID Button
                            Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: ElevatedButton(
                                onPressed: onboardingController.nextStep,
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
                                      'Create My LifeMesh ID',
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
                            ).animate().fadeIn(delay: 700.ms),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
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
                _buildActiveStep(3, 'Review'),
              ],
            ),
          ),
          const SizedBox(width: 48),
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

  Widget _buildProfileSummaryCard(OnboardingUserModel? user, OnboardingController controller) {
    final imagePath = user?.profileImage ?? '';
    final name = (user?.displayName?.isNotEmpty ?? false) ? user!.displayName! : 'Rahul Kumar';
    final username = (user?.username?.isNotEmpty ?? false) ? '@${user!.username}' : '@rahulkumar';
    final bio = (user?.bio?.isNotEmpty ?? false) ? user!.bio! : 'Exploring the world,\none connection at a time.';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(color: AppColors.neonPurple.withValues(alpha: 0.4), blurRadius: 15, spreadRadius: 1)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: imagePath.isNotEmpty 
                        ? DecorationImage(
                            image: imagePath.startsWith('http') ? NetworkImage(imagePath) as ImageProvider : FileImage(File(imagePath)),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: NetworkImage('https://i.pravatar.cc/300?img=11'),
                            fit: BoxFit.cover,
                          ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.goToStep(1),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(bottom: 2, right: 2),
                  decoration: BoxDecoration(
                    color: AppColors.deepNavy,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.neonPurple, width: 1.5),
                  ),
                  child: const Icon(Icons.edit_outlined, size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  username,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14),
                ),
                const SizedBox(height: 12),
                Text(
                  bio,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(OnboardingUserModel? user) {
    final dob = (user?.dob?.isNotEmpty ?? false) ? user!.dob! : 'Not Provided';
    final gender = (user?.gender?.isNotEmpty ?? false) ? user!.gender! : 'Male';
    final location = (user?.locationName?.isNotEmpty ?? false) ? user!.locationName! : 'Not Provided';
    final occupation = (user?.occupation?.isNotEmpty ?? false) ? user!.occupation! : 'Not Provided';
    final email = (user?.email?.isNotEmpty ?? false) ? user!.email! : 'Not Provided';
    final phone = (user?.phone?.isNotEmpty ?? false) ? user!.phone! : 'Not Provided';
    final isPrivate = user?.isPrivate ?? true;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          _buildDetailRow(Icons.person_outline, 'Date of Birth', dob),
          _buildDivider(),
          _buildDetailRow(Icons.male, 'Gender', gender, iconColor: Colors.blueAccent),
          _buildDivider(),
          _buildDetailRow(Icons.location_on_outlined, 'Location', location),
          _buildDivider(),
          _buildDetailRow(Icons.work_outline, 'Occupation', occupation),
          _buildDivider(),
          _buildDetailRow(Icons.mail_outline, 'Email Address', email),
          _buildDivider(),
          _buildDetailRow(Icons.phone_outlined, 'Phone Number', phone),
          _buildDivider(),
          _buildDetailRow(
            Icons.shield_outlined,
            'Privacy Preference',
            isPrivate ? 'Private' : 'Discoverable',
            trailingIcon: Icons.lock_outline,
            trailingIconColor: AppColors.neonPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? iconColor, IconData? trailingIcon, Color? trailingIconColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: iconColor ?? AppColors.neonPurple),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 8),
            Icon(trailingIcon, size: 16, color: trailingIconColor ?? Colors.white54),
          ],
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.white.withValues(alpha: 0.05),
      margin: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  Widget _buildTermsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.neonPurple.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.verified_user_outlined, size: 20, color: AppColors.neonPurple),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13, height: 1.5),
                children: const [
                  TextSpan(text: 'By creating your ID, you agree to our\n'),
                  TextSpan(text: 'Terms of Service', style: TextStyle(color: AppColors.neonPurple, fontWeight: FontWeight.w500)),
                  TextSpan(text: ' and '),
                  TextSpan(text: 'Privacy Policy', style: TextStyle(color: AppColors.cyanBlue, fontWeight: FontWeight.w500)),
                  TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
