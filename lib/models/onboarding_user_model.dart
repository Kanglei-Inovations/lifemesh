import 'package:isar/isar.dart';

part 'onboarding_user_model.g.dart';

@collection
class OnboardingUserModel {
  Id id = Isar.autoIncrement;
  
  String? profileImage;
  String? username;
  String? displayName;
  String? bio;
  String? fullName;
  String? gender;
  String? dob;
  String? occupation;
  String? email;
  String? phone;
  String? locationName;
  double? latitude;
  double? longitude;
  
  bool isPrivate = true;
  bool onboardingCompleted = false;
  DateTime? createdAt;
}
