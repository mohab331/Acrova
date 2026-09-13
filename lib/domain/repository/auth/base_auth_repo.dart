import 'package:acrova/data/models/auth/verify_otp_request_model.dart';
import 'package:acrova/data/models/auth/verify_otp_response_model.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseAuthRepo {
  Future<Result<void>> login(String phoneNumber);

  Future<Result<VerifyOTPResponseModel>> verifyOtp(
    VerifyOTPRequestModel verifyOTPRequestModel,
  );

  /// Saves KYC profile after first login. Marks user as no longer new.
  /// Collects: full name, email, mobile number, national ID, preferred language.
  Future<Result<void>> saveProfile({
    required String name,
    required String email,
    required String nationalId,
    required String language,
  });

  /// Fetch the signed-in user's profile.
  Future<Result<UserProfileModel>> getUserProfile();

  /// Update editable profile fields; returns the updated profile.
  Future<Result<UserProfileModel>> updateUserProfile(
    UpdateProfileRequest request,
  );

  Future<Result<String?>> getRefreshToken();

  Future<Result<String?>> getAccessToken();

  Future<Result<String?>> getFCMToken();

  Future<Result<void>> clearUserData();
}
