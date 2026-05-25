import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_storage/get_storage.dart';
import '../models/onboarding_user_model.dart';
import '../models/permission_model.dart';
import '../models/nearby_user_model.dart';
import '../models/onboarding_state_model.dart';
import '../models/activity_model.dart';
import '../models/dashboard_stat_model.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';
import '../models/file_attachment_model.dart';

class DatabaseService extends GetxService {
  late Isar isar;

  Future<DatabaseService> init() async {
    await GetStorage.init();
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      OnboardingUserModelSchema,
      PermissionModelSchema,
      NearbyUserModelSchema,
      OnboardingStateModelSchema,
      ActivityModelSchema,
      DashboardStatModelSchema,
      ChatMessageModelSchema,
      ChatRoomModelSchema,
      FileAttachmentModelSchema,
    ], directory: dir.path);

    // Initialize default state if not exists
    if (await isar.onboardingStateModels.count() == 0) {
      await isar.writeTxn(() async {
        await isar.onboardingStateModels.put(OnboardingStateModel());
      });
    }

    return this;
  }
}
