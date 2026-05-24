import 'package:get/get.dart';
import 'package:isar/isar.dart';
import '../../../../core/database_service.dart';
import '../../../../models/onboarding_state_model.dart';

/// Controller responsible for managing the overall onboarding flow and step navigation.
class OnboardingController extends GetxController {
  final DatabaseService _db = Get.find<DatabaseService>();
  
  // Reactive variable to track the current step in the onboarding flow.
  final RxInt currentStep = 1.obs;
  
  // Total steps in the onboarding process
  // 1: Create ID, 2: Personal Info, 3: Review, 4: Permissions, 5: Discovering, 6: Welcome
  final int totalSteps = 6;

  @override
  void onInit() {
    super.onInit();
    _restoreOnboardingState();
  }

  /// Restores the onboarding state from Isar database.
  Future<void> _restoreOnboardingState() async {
    try {
      final state = await _db.isar.onboardingStateModels.where().findFirst();
      if (state != null) {
        if (state.onboardingCompleted) {
          Get.offAllNamed('/home');
          return;
        }
        
        // Restore step if app was closed
        if (state.currentStep > 1) {
          currentStep.value = state.currentStep;
          _navigateBasedOnStep();
        }
      }
    } catch (e) {
      Get.log("Error checking onboarding status: $e");
    }
  }

  /// Saves the current step to the database.
  Future<void> _saveCurrentStep() async {
    try {
      final state = await _db.isar.onboardingStateModels.where().findFirst();
      if (state != null) {
        state.currentStep = currentStep.value;
        state.lastUpdated = DateTime.now();
        await _db.isar.writeTxn(() async {
          await _db.isar.onboardingStateModels.put(state);
        });
      }
    } catch (e) {
      Get.log("Error saving onboarding state: $e");
    }
  }

  /// Navigates to the next onboarding step.
  void nextStep() {
    if (currentStep.value < totalSteps) {
      currentStep.value++;
      _saveCurrentStep();
      _navigateBasedOnStep();
    } else {
      completeOnboarding();
    }
  }

  /// Navigates to the previous onboarding step.
  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
      _saveCurrentStep();
      Get.back();
    }
  }

  /// Jumps directly to a specific step.
  void goToStep(int index) {
    if (index >= 1 && index <= totalSteps) {
      currentStep.value = index;
      _saveCurrentStep();
      _navigateBasedOnStep();
    }
  }

  /// Handles routing based on the current step value.
  void _navigateBasedOnStep() {
    switch (currentStep.value) {
      case 1:
        Get.toNamed('/identity');
        break;
      case 2:
        Get.toNamed('/personal-info');
        break;
      case 3:
        Get.toNamed('/review');
        break;
      case 4:
        Get.toNamed('/permissions');
        break;
      case 5:
        Get.toNamed('/discovering');
        break;
      case 6:
        Get.toNamed('/welcome');
        break;
    }
  }

  /// Marks the onboarding process as fully completed and redirects to Home.
  Future<void> completeOnboarding() async {
    try {
      final state = await _db.isar.onboardingStateModels.where().findFirst();
      if (state != null) {
        state.onboardingCompleted = true;
        state.lastUpdated = DateTime.now();
        await _db.isar.writeTxn(() async {
          await _db.isar.onboardingStateModels.put(state);
        });
      }
      Get.offAllNamed('/home');
    } catch (e) {
      Get.log("Error saving onboarding completion state: $e");
      Get.offAllNamed('/home');
    }
  }
}
