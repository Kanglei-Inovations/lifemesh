import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_storage/get_storage.dart';
import '../models/onboarding_user_model.dart';
import '../models/permission_model.dart';
import '../models/nearby_user_model.dart';
import '../models/onboarding_state_model.dart';

class DatabaseService extends GetxService {
  late Isar isar;

  Future<DatabaseService> init() async {
    await GetStorage.init();
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        OnboardingUserModelSchema,
        PermissionModelSchema,
        NearbyUserModelSchema,
        OnboardingStateModelSchema,
      ],
      directory: dir.path,
    );
    
    // Initialize default state if not exists
    if (await isar.onboardingStateModels.count() == 0) {
      await isar.writeTxn(() async {
        await isar.onboardingStateModels.put(OnboardingStateModel());
      });
    }
    
    if (await isar.onboardingUserModels.count() == 0) {
      await isar.writeTxn(() async {
        await isar.onboardingUserModels.put(OnboardingUserModel());
      });
    }
    
    return this;
  }
}
