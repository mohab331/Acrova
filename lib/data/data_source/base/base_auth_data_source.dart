import 'package:acrova/data/models/request/auth/save_profile_request_model.dart';
import 'package:acrova/data/models/request/auth/send_otp_request_model.dart';
import 'package:acrova/data/models/request/auth/verify_otp_request_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request_model.dart';
import 'package:acrova/data/models/response/auth/verify_otp_response_model.dart';
import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';

abstract class BaseAuthDataSource {
  Future<void> login(SendOTPRequestModel request);
  Future<VerifyOTPResponseModel> verifyOtp(
    VerifyOTPRequestModel verifyOTPRequestModel,
  );
  Future<bool> isNewUser();
  Future<void> saveUserProfile(SaveProfileRequestModel request);

  /// Fetch the signed-in user's profile.
  Future<UserProfileResponseModel?> getUserProfile();

  /// Update editable profile fields and return the updated profile.
  Future<UserProfileResponseModel> updateUserProfile(
    UpdateProfileRequestModel request,
  );

  Future<String?> getRefreshToken();
  Future<String?> getAccessToken();
  Future<String?> getFCMToken();
  Future<void> clearUserData();
}
