import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../controllers/personal_info_controller.dart';
import '../controllers/onboarding_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }
    final controller = Get.put(PersonalInfoController());

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
                          'Your Personal Information',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 200.ms),
                        const SizedBox(height: 12),
                        Text(
                          'This information helps your connections\nknow you better.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14, height: 1.4),
                        ).animate().fadeIn(delay: 300.ms),
                        const SizedBox(height: 40),
                        
                        _buildInputField(
                          title: 'Full Name',
                          controller: controller.fullNameController,
                          icon: Icons.person_outline,
                          suffixIcon: Icons.check_circle_outline,
                          suffixColor: AppColors.cyanBlue,
                        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),
                        
                        GestureDetector(
                          onTap: () => controller.selectDate(context),
                          child: AbsorbPointer(
                            child: Obx(() => _buildInputField(
                              title: 'Date of Birth',
                              controller: TextEditingController(text: controller.selectedDate.value),
                              icon: Icons.calendar_today_outlined,
                              suffixIcon: Icons.calendar_month_outlined,
                              suffixColor: AppColors.neonPurple,
                            )),
                          ),
                        ).animate().fadeIn(delay: 650.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),
                        
                        Obx(() => _buildGenderSelector(controller)).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),
                        
                        _buildInputField(
                          title: 'Location',
                          controller: controller.locationController,
                          icon: Icons.location_on_outlined,
                          suffixIcon: Icons.my_location_outlined,
                          suffixColor: AppColors.neonPurple,
                        ).animate().fadeIn(delay: 750.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),

                        // GPS Location field added
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: _buildInputField(
                                title: 'GPS Location',
                                controller: controller.gpsController,
                                icon: Icons.gps_fixed,
                                suffixIcon: Icons.check_circle_outline,
                                suffixColor: AppColors.cyanBlue,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.neonPurple.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.neonPurple),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.my_location, color: Colors.white),
                                onPressed: controller.detectLocation,
                              ),
                            ),
                          ],
                        ).animate().fadeIn(delay: 780.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),
                        
                        _buildInputField(
                          title: 'Occupation',
                          controller: controller.occupationController,
                          icon: Icons.work_outline,
                          suffixIcon: Icons.check_circle_outline,
                          suffixColor: AppColors.cyanBlue,
                        ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),

                        _buildInputField(
                          title: 'Email Address',
                          controller: controller.emailController,
                          icon: Icons.mail_outline,
                          suffixIcon: Icons.check_circle_outline,
                          suffixColor: AppColors.cyanBlue,
                        ).animate().fadeIn(delay: 850.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 20),

                        _buildInputField(
                          title: 'Phone Number (Optional)',
                          controller: controller.phoneController,
                          icon: Icons.phone_outlined,
                          suffixIcon: Icons.check_circle_outline,
                          suffixColor: AppColors.cyanBlue,
                        ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 40),
                        
                        // Next Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: ElevatedButton(
                            onPressed: controller.savePersonalInfo,
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
                                      'Next',
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
                _buildCompletedStep('Create ID'),
                _buildStepConnector(isActive: true),
                _buildActiveStep(2, 'Personal Info'),
                _buildStepConnector(),
                _buildInactiveStep(3, 'Review'),
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

  Widget _buildInactiveStep(int step, String label) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10),
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

  Widget _buildInputField({
    required String title,
    required TextEditingController controller,
    required IconData icon,
    required IconData suffixIcon,
    required Color suffixColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13, fontWeight: FontWeight.w500),
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
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: Colors.white54, size: 20),
              suffixIcon: Icon(suffixIcon, color: suffixColor, size: 20),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector(PersonalInfoController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              _buildGenderOption('Male', Icons.male, Colors.blueAccent, controller),
              Container(width: 1, color: Colors.white.withValues(alpha: 0.1)),
              _buildGenderOption('Female', Icons.female, Colors.pinkAccent, controller),
              Container(width: 1, color: Colors.white.withValues(alpha: 0.1)),
              _buildGenderOption('Other', Icons.transgender, AppColors.neonPurple, controller),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption(String title, IconData icon, Color iconColor, PersonalInfoController controller) {
    final isSelected = controller.selectedGender.value == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectGender(title),
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  color: AppColors.neonPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.neonPurple, width: 1.5),
                  boxShadow: [
                    BoxShadow(color: AppColors.neonPurple.withValues(alpha: 0.15), blurRadius: 8)
                  ],
                )
              : null,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? AppColors.cyanBlue : iconColor, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
