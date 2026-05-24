import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller responsible for managing the "Personal Info" onboarding step.
class PersonalInfoController extends GetxController {
  // Text Controllers for input fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Reactive state variables
  final RxString selectedGender = 'Male'.obs;
  final RxString selectedDate = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    fullNameController.dispose();
    occupationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.onClose();
  }

  /// Triggers a date picker dialog for Date of Birth selection.
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      selectedDate.value = "${picked.day} ${_getMonth(picked.month)} ${picked.year}";
      Get.log("Date of birth selected: ${selectedDate.value}");
    }
  }

  /// Helper to convert month integer to abbreviated string.
  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  /// Updates the selected gender value.
  void selectGender(String gender) {
    if (['Male', 'Female', 'Other'].contains(gender)) {
      selectedGender.value = gender;
      Get.log("Gender selected: $gender");
    }
  }

  /// Mocks a location detection feature.
  Future<void> detectLocation() async {
    isLoading.value = true;
    
    try {
      // Simulate GPS location lookup delay
      await Future.delayed(const Duration(seconds: 1));
      locationController.text = 'Bengaluru, Karnataka, India';
      Get.log("Location successfully detected.");
    } catch (e) {
      Get.snackbar('Location Error', 'Unable to detect location.');
      Get.log("Error detecting location: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Validates all necessary personal information fields.
  bool validatePersonalInfo() {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    if (fullName.isEmpty) {
      Get.snackbar('Validation Error', 'Full name is required');
      return false;
    }
    
    // Optional field, but validate formatting if provided
    if (email.isNotEmpty && !GetUtils.isEmail(email)) {
      Get.snackbar('Validation Error', 'Please enter a valid email address');
      return false;
    }
    
    // Optional field, but validate formatting if provided
    if (phone.isNotEmpty && !GetUtils.isPhoneNumber(phone)) {
      Get.snackbar('Validation Error', 'Please enter a valid phone number');
      return false;
    }
    
    return true;
  }

  /// Finalizes the Personal Info step and simulates saving the data.
  Future<void> savePersonalInfo() async {
    if (!validatePersonalInfo()) return;

    isLoading.value = true;
    
    try {
      // Simulate saving user personal info data
      await Future.delayed(const Duration(seconds: 1));
      Get.log("Personal Info saved successfully.");
      
      // Logic complete, ready to proceed via OnboardingController
    } catch (e) {
      Get.snackbar('Error', 'Failed to save personal info. Try again.');
      Get.log("Error saving personal info: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
