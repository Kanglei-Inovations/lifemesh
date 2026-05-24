import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../core/database_service.dart';
import '../../../../models/onboarding_user_model.dart';
import 'onboarding_controller.dart';

/// Controller responsible for managing the "Personal Info" onboarding step.
class PersonalInfoController extends GetxController {
  final DatabaseService _db = Get.find<DatabaseService>();
  final OnboardingController onboardingController =
      Get.find<OnboardingController>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController gpsController =
      TextEditingController(); // New field requested

  final RxString selectedGender = 'Male'.obs;
  final RxString selectedDate = ''.obs;
  final RxBool isLoading = false.obs;

  double? _latitude;
  double? _longitude;

  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    _restoreData();

    // Auto-save listeners
    fullNameController.addListener(_debouncedSave);
    occupationController.addListener(_debouncedSave);
    emailController.addListener(_debouncedSave);
    phoneController.addListener(_debouncedSave);
    locationController.addListener(_debouncedSave);
    gpsController.addListener(_debouncedSave);
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    fullNameController.dispose();
    occupationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    gpsController.dispose();
    super.onClose();
  }

  Future<void> _restoreData() async {
    final user = await _db.isar.onboardingUserModels.where().findFirst();
    if (user != null) {
      fullNameController.text = user.fullName ?? '';
      occupationController.text = user.occupation ?? '';
      emailController.text = user.email ?? '';
      phoneController.text = user.phone ?? '';
      locationController.text = user.locationName ?? '';
      selectedGender.value = user.gender ?? 'Male';
      selectedDate.value = user.dob ?? '';
      _latitude = user.latitude;
      _longitude = user.longitude;
      if (_latitude != null && _longitude != null) {
        gpsController.text = '$_latitude, $_longitude';
      }
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
      final user =
          await _db.isar.onboardingUserModels.where().findFirst() ??
          OnboardingUserModel();
      user.fullName = fullNameController.text.trim();
      user.occupation = occupationController.text.trim();
      user.email = emailController.text.trim();
      user.phone = phoneController.text.trim();
      user.locationName = locationController.text.trim();
      user.gender = selectedGender.value;
      user.dob = selectedDate.value;
      user.latitude = _latitude;
      user.longitude = _longitude;

      await _db.isar.writeTxn(() async {
        await _db.isar.onboardingUserModels.put(user);
      });
    } catch (e) {
      Get.log("Auto-save error: $e");
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate.value =
          "${picked.day} ${_getMonth(picked.month)} ${picked.year}";
      _saveToIsar();
    }
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  void selectGender(String gender) {
    if (['Male', 'Female', 'Other'].contains(gender)) {
      selectedGender.value = gender;
      _saveToIsar();
    }
  }

  Future<void> detectLocation() async {
    isLoading.value = true;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Error', 'Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('Error', 'Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Error', 'Location permissions are permanently denied.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      _latitude = position.latitude;
      _longitude = position.longitude;
      gpsController.text = '$_latitude, $_longitude';

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        locationController.text =
            '${place.locality}, ${place.administrativeArea}, ${place.country}';
      }
      _saveToIsar();
      Get.log("Location successfully detected.");
    } catch (e) {
      Get.snackbar('Location Error', 'Unable to detect location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  bool validatePersonalInfo() {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    if (fullName.isEmpty) {
      Get.snackbar('Validation Error', 'Full name is required');
      return false;
    }

    if (email.isNotEmpty && !GetUtils.isEmail(email)) {
      Get.snackbar('Validation Error', 'Please enter a valid email address');
      return false;
    }

    if (phone.isNotEmpty && !GetUtils.isPhoneNumber(phone)) {
      Get.snackbar('Validation Error', 'Please enter a valid phone number');
      return false;
    }

    return true;
  }

  Future<void> savePersonalInfo() async {
    if (!validatePersonalInfo()) return;

    isLoading.value = true;

    try {
      await _saveToIsar();
      onboardingController.nextStep();
    } catch (e) {
      Get.snackbar('Error', 'Failed to save personal info. Try again.');
      Get.log("Error saving personal info: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
