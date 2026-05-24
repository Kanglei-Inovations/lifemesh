import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/database_service.dart';
import '../../../../models/onboarding_state_model.dart';
import '../../../../models/onboarding_user_model.dart';
import 'onboarding_controller.dart';

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
    // Artificial delay for loading state/branding
    await Future.delayed(const Duration(seconds: 2));
    
    final isar = dbService.isar;
    final user = await isar.onboardingUserModels.where().findFirst();
    final state = await isar.onboardingStateModels.where().findFirst();
    
    // Check local preference/session
    // Profile is considered completed if user exists and onboardingCompleted is true
    final hasCompletedProfile =
        user != null &&
        (user.onboardingCompleted || (state?.onboardingCompleted ?? false));

    if (hasCompletedProfile) {
      // User/profile already exists
      await _syncCompletedFlags(user, state);
      isOnboardingCompleted.value = true;
      
      // Initialize OnboardingController at Permissions step (Step 4)
      if (!Get.isRegistered<OnboardingController>()) {
        final onboarding = Get.put(OnboardingController());
        onboarding.currentStep.value = 4;
      } else {
        Get.find<OnboardingController>().currentStep.value = 4;
      }
      
      // Navigate to PermissionsScreen()
      Get.offAllNamed('/permissions');
    } else {
      // User/profile does NOT exist
      isOnboardingCompleted.value = false;
      
      // Initialize OnboardingController at Step 1
      if (!Get.isRegistered<OnboardingController>()) {
        final onboarding = Get.put(OnboardingController());
        onboarding.currentStep.value = 1;
      } else {
        Get.find<OnboardingController>().currentStep.value = 1;
      }
      
      // Start with IdentityScreen()
      Get.offAllNamed('/identity');
    }
    
    isLoading.value = false;
  }

  /// Syncs onboarding flags across models for consistency
  Future<void> _syncCompletedFlags(
    OnboardingUserModel user,
    OnboardingStateModel? state,
  ) async {
    final shouldUpdateUser = !user.onboardingCompleted;
    final shouldUpdateState = state == null || !state.onboardingCompleted || state.currentStep != 4;
    if (!shouldUpdateUser && !shouldUpdateState) return;

    await dbService.isar.writeTxn(() async {
      user.onboardingCompleted = true;
      user.createdAt ??= DateTime.now();
      await dbService.isar.onboardingUserModels.put(user);

      final nextState = state ?? OnboardingStateModel();
      nextState.onboardingCompleted = true;
      nextState.currentStep = 4; // Set to Permissions step
      nextState.lastUpdated = DateTime.now();
      await dbService.isar.onboardingStateModels.put(nextState);
    });
  }

  /// Helper to check essential permissions if needed elsewhere
  Future<bool> checkEssentialPermissions() async {
    final location = await Permission.location.isGranted;
    final bluetoothScan = await Permission.bluetoothScan.isGranted;
    final bluetoothConnect = await Permission.bluetoothConnect.isGranted;
    final bluetoothAdvertise = await Permission.bluetoothAdvertise.isGranted;
    
    return location && bluetoothScan && bluetoothConnect && bluetoothAdvertise;
  }
}
