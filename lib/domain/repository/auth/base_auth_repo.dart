import 'package:acrova/data/models/request/auth/save_profile_request_model.dart';
import 'package:acrova/data/models/request/auth/send_otp_request_model.dart';
import 'package:acrova/data/models/request/auth/verify_otp_request_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request_model.dart';
import 'package:acrova/data/models/response/auth/verify_otp_response_model.dart';
import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseAuthRepo {
  Future<Result<void>> login(SendOTPRequestModel request);

  Future<Result<VerifyOTPResponseModel>> verifyOtp(
    VerifyOTPRequestModel verifyOTPRequestModel,
  );

  /// Saves KYC profile after first login. Marks user as no longer new.
  Future<Result<void>> saveProfile(SaveProfileRequestModel request);

  /// Fetch the signed-in user's profile.
  Future<Result<UserProfileResponseModel?>> getUserProfile();

  /// Update editable profile fields; returns the updated profile.
  Future<Result<UserProfileResponseModel>> updateUserProfile(
    UpdateProfileRequestModel request,
  );

  Future<Result<String?>> getRefreshToken();

  Future<Result<String?>> getAccessToken();

  Future<Result<String?>> getFCMToken();

  Future<Result<void>> clearUserData();
}
