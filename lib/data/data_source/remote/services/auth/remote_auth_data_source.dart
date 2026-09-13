import 'package:acrova/data/data_source/base/base_auth_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/request/auth/save_profile_request_model.dart';
import 'package:acrova/data/models/request/auth/send_otp_request_model.dart';
import 'package:acrova/data/models/request/auth/verify_otp_request_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request_model.dart';
import 'package:acrova/data/models/response/auth/verify_otp_response_model.dart';
import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';

class RemoteAuthDataSource implements BaseAuthDataSource {
  final ApiClient apiClient;

  RemoteAuthDataSource({required this.apiClient});

  @override
  Future<void> login(SendOTPRequestModel request) async {
    // await apiClient.post('auth/login', data: request.toJson());
  }

  @override
  Future<VerifyOTPResponseModel> verifyOtp(VerifyOTPRequestModel verifyOTPRequestModel) async {
    // await apiClient.post('auth/verify-otp', data: verifyOTPRequestModel.toJson());
    throw UnimplementedError();
  }

  @override
  Future<bool> isNewUser() async {
    // GET /users/me and check onboarding_complete flag
    return false;
  }

  @override
  Future<void> saveUserProfile(SaveProfileRequestModel request) async {
    // PATCH /users/profile with request.toJson()
  }

  @override
  Future<UserProfileResponseModel> getUserProfile() async {
    // GET /users/me
    throw UnimplementedError('Remote getUserProfile not implemented yet');
  }

  @override
  Future<UserProfileResponseModel> updateUserProfile(
    UpdateProfileRequestModel request,
  ) async {
    // PATCH /users/profile with request.toJson()
    throw UnimplementedError('Remote updateUserProfile not implemented yet');
  }

  @override
  Future<String?> getRefreshToken() async {
    return null;
  }

  @override
  Future<String?> getAccessToken() async {
    return null;
  }

  @override
  Future<String?> getFCMToken() async {
    return null;
  }

  @override
  Future<void> clearUserData() async {
    // clear user data remote (e.g. invalidate session)
  }
}
