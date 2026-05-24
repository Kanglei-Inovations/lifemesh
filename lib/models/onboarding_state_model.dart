import 'package:isar/isar.dart';

part 'onboarding_state_model.g.dart';

@collection
class OnboardingStateModel {
  Id id = Isar.autoIncrement;

  int currentStep = 1;
  bool onboardingCompleted = false;
  DateTime? lastUpdated;
}
