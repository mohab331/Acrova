import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request.dart';

abstract class BaseAuthDataSource {
  Future<void> login(String phoneNumber);
  Future<void> verifyOtp(String otp);
  Future<bool> isNewUser();
  Future<void> saveUserProfile({
    required String name,
    required String email,
    required String nationalId,
    required String language,
  });

  /// Fetch the signed-in user's profile.
  Future<UserProfileModel> getUserProfile();

  /// Update editable profile fields and return the updated profile.
  Future<UserProfileModel> updateUserProfile(UpdateProfileRequest request);

  Future<String?> getRefreshToken();
  Future<String?> getAccessToken();
  Future<String?> getFCMToken();
  Future<void> clearUserData();
}
