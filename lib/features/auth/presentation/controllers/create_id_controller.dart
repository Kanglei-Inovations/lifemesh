import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import '../../../../core/database_service.dart';
import '../../../../models/onboarding_user_model.dart';
import 'onboarding_controller.dart';

/// Controller responsible for managing the "Create ID" step in the onboarding flow.
class CreateIdController extends GetxController {
  final DatabaseService _db = Get.find<DatabaseService>();
  final OnboardingController onboardingController = Get.find<OnboardingController>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final RxBool isPrivate = true.obs;
  final RxString selectedImage = ''.obs;
  final RxBool isUsernameAvailable = false.obs;
  final RxBool isLoading = false.obs;
  
  final RxList<String> usernameSuggestions = <String>[].obs;
  
  // Debounce timer for auto-saving
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    _restoreData();

    // Listeners for auto-saving and suggestions
    usernameController.addListener(() {
      _generateSuggestions(usernameController.text);
      checkUsernameAvailability();
      _debouncedSave();
    });
    displayNameController.addListener(_debouncedSave);
    bioController.addListener(_debouncedSave);
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    usernameController.dispose();
    displayNameController.dispose();
    bioController.dispose();
    super.onClose();
  }

  Future<void> _restoreData() async {
    final user = await _db.isar.onboardingUserModels.where().findFirst();
    if (user != null) {
      usernameController.text = user.username ?? '';
      displayNameController.text = user.displayName ?? '';
      bioController.text = user.bio ?? '';
      selectedImage.value = user.profileImage ?? '';
      isPrivate.value = user.isPrivate;
    }
  }

  void _debouncedSave() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _saveToIsar();
    });
  }

  Future<void> _saveToIsar() async {
    try {
      final user = await _db.isar.onboardingUserModels.where().findFirst() ?? OnboardingUserModel();
      user.username = usernameController.text.trim();
      user.displayName = displayNameController.text.trim();
      user.bio = bioController.text.trim();
      user.profileImage = selectedImage.value;
      user.isPrivate = isPrivate.value;
      
      await _db.isar.writeTxn(() async {
        await _db.isar.onboardingUserModels.put(user);
      });
    } catch (e) {
      Get.log("Auto-save error: $e");
    }
  }

  void _generateSuggestions(String input) {
    if (input.isEmpty) {
      usernameSuggestions.clear();
      return;
    }
    String base = input.replaceAll(' ', '').toLowerCase();
    usernameSuggestions.value = [
      '$base.mesh',
      '${base}_lm',
      '${base}123',
      'real.$base'
    ];
  }

  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      selectedImage.value = image.path;
      _saveToIsar();
      Get.log("Profile image picked: ${selectedImage.value}");
    }
  }

  Future<void> checkUsernameAvailability() async {
    final username = usernameController.text.trim();
    if (username.length < 4 || username.contains(' ')) {
      isUsernameAvailable.value = false;
      return;
    }
    
    // Simulate uniqueness check
    isUsernameAvailable.value = true;
  }

  void togglePrivacy(bool value) {
    isPrivate.value = value;
    _saveToIsar();
  }

  bool validateCreateId() {
    final username = usernameController.text.trim();
    final displayName = displayNameController.text.trim();

    if (username.isEmpty) {
      Get.snackbar('Validation Error', 'Username is required');
      return false;
    }
    if (username.contains(' ')) {
      Get.snackbar('Validation Error', 'Username cannot contain spaces');
      return false;
    }
    if (username.length < 4) {
      Get.snackbar('Validation Error', 'Username must be at least 4 characters');
      return false;
    }
    if (displayName.isEmpty) {
      Get.snackbar('Validation Error', 'Display name is required');
      return false;
    }
    if (!isUsernameAvailable.value) {
      Get.snackbar('Validation Error', 'Username is not available');
      return false;
    }
    
    return true;
  }

  Future<void> saveCreateIdData() async {
    if (!validateCreateId()) return;

    isLoading.value = true;
    
    try {
      await _saveToIsar();
      onboardingController.nextStep();
    } catch (e) {
      Get.snackbar('Error', 'Failed to save profile. Try again.');
      Get.log("Error saving Create ID data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}