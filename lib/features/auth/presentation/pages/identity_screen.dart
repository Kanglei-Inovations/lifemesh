import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:io';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../controllers/create_id_controller.dart';
import '../controllers/onboarding_controller.dart';

class IdentityScreen extends StatelessWidget {
  const IdentityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensuring OnboardingController is available
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }
    final controller = Get.put(CreateIdController());

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
                        const SizedBox(height: 20),
                        const Text(
                          'Create Your LifeMesh ID',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ).animate().fadeIn(delay: 200.ms),
                        const SizedBox(height: 12),
                        Text(
                          'This is your unique identity in the LifeMesh network.\nYou can change it later in settings.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14, height: 1.4),
                        ).animate().fadeIn(delay: 300.ms),
                        const SizedBox(height: 32),
                        
                        // Avatar Upload
                        GestureDetector(
                          onTap: controller.pickProfileImage,
                          child: Obx(() => _buildAvatarUpload(controller.selectedImage.value)),
                        ).animate().scale(delay: 400.ms, curve: Curves.easeOutBack),
                        const SizedBox(height: 8),
                        const Text(
                          'Add a profile photo',
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                        ).animate().fadeIn(delay: 500.ms),
                        const SizedBox(height: 4),
                        Text(
                          'JPG, PNG • Max 5MB',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12),
                        ).animate().fadeIn(delay: 500.ms),
                        const SizedBox(height: 32),
                        
                        Obx(() => _buildInputField(
                          title: 'Choose Your ID',
                          hint: 'rahulkumar',
                          icon: '@',
                          isIdField: true,
                          controller: controller.usernameController,
                          isValid: controller.isUsernameAvailable.value,
                          suggestions: controller.usernameSuggestions,
                        )).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),
                        
                        _buildInputField(
                          title: 'Set a Display Name',
                          hint: 'Rahul Kumar',
                          icon: Icons.person_outline,
                          description: 'This is how others will see you.',
                          controller: controller.displayNameController,
                        ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),
                        
                        _buildBioField(controller.bioController).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),
                        
                        Obx(() => _buildPrivacySection(controller)).animate().fadeIn(delay: 900.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 40),
                        
                        // Continue Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: ElevatedButton(
                            onPressed: controller.saveCreateIdData,
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
                        ).animate().fadeIn(delay: 1000.ms),
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
                _buildStep(1, 'Create ID', isActive: true),
                _buildStepConnector(isActive: true),
                _buildStep(2, 'Personal Info'),
                _buildStepConnector(),
                _buildStep(3, 'Review'),
              ],
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildStep(int step, String label, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? null : Colors.transparent,
            gradient: isActive ? AppColors.primaryGradient : null,
            border: isActive ? null : Border.all(color: Colors.white.withValues(alpha: 0.3)),
            boxShadow: isActive
                ? [BoxShadow(color: AppColors.cyanBlue.withValues(alpha: 0.5), blurRadius: 10)]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.cyanBlue : Colors.white.withValues(alpha: 0.5),
            fontSize: 10,
          ),
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
        boxShadow: isActive
            ? [BoxShadow(color: AppColors.cyanBlue, blurRadius: 4)]
            : null,
      ),
    );
  }

  Widget _buildAvatarUpload(String imagePath) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.neonPurple.withValues(alpha: 0.4),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.deepNavy,
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
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 4, right: 4),
          decoration: BoxDecoration(
            color: AppColors.deepNavy,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.neonPurple, width: 1.5),
          ),
          child: const Icon(Icons.camera_alt_outlined, size: 20, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String title,
    required String hint,
    required dynamic icon,
    bool isIdField = false,
    String? description,
    required TextEditingController controller,
    bool isValid = false,
    List<String>? suggestions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isValid ? AppColors.cyanBlue : Colors.white.withValues(alpha: 0.1)),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
              border: InputBorder.none,
              prefixIcon: icon is String
                  ? Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(icon, style: const TextStyle(color: Colors.white54, fontSize: 18)),
                    )
                  : Icon(icon as IconData, color: Colors.white54),
              suffixIcon: isIdField && isValid 
                ? const Icon(Icons.check_circle, color: AppColors.cyanBlue)
                : const Icon(Icons.check_circle_outline, color: Colors.white38),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12),
          ),
        ],
        if (isIdField && suggestions != null && suggestions.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'This will be your unique LifeMesh ID.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12),
          ),
          const SizedBox(height: 12),
          Text(
            'Suggestions',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: suggestions.map((s) => GestureDetector(
                onTap: () => controller.text = s,
                child: _buildSuggestionChip(s),
              )).toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSuggestionChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
      ),
    );
  }

  Widget _buildBioField(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add a Short Bio (Optional)',
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            maxLines: 3,
            maxLength: 100,
            decoration: InputDecoration(
              hintText: 'Exploring the world, one connection at a time.',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              counterStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacySection(CreateIdController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Privacy Preference',
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildPrivacyCard(true, 'Private', 'Only people you connect\nwith can find you.', Icons.lock_outline, controller)),
            const SizedBox(width: 12),
            Expanded(child: _buildPrivacyCard(false, 'Discoverable', 'Anyone nearby can\nfind you.', Icons.language, controller)),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'You can change this later in settings.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPrivacyCard(bool isPrivateType, String title, String desc, IconData icon, CreateIdController controller) {
    final isSelected = controller.isPrivate.value == isPrivateType;
    
    return GestureDetector(
      onTap: () => controller.togglePrivacy(isPrivateType),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neonPurple.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.neonPurple : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.neonPurple.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 16, color: isSelected ? AppColors.neonPurple : Colors.white54),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  size: 16,
                  color: isSelected ? AppColors.neonPurple : Colors.white38,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 10, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
