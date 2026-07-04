import 'package:acrova/data/data_source/base/base_auth_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request.dart';

class RemoteAuthDataSource implements BaseAuthDataSource {
  final ApiClient apiClient;

  RemoteAuthDataSource({required this.apiClient});

  @override
  Future<void> login(String phoneNumber) async {
    // TODO: implement real API call
    // await apiClient.post('auth/login', data: {'phone_number': phoneNumber});
  }

  @override
  Future<void> verifyOtp(String otp) async {
    // TODO: implement real API call
    // await apiClient.post('auth/verify-otp', data: {'otp': otp});
  }

  @override
  Future<bool> isNewUser() async {
    // TODO: GET /users/me and check onboarding_complete flag
    return false;
  }

  @override
  Future<void> saveUserProfile({
    required String name,
    required String email,
    required String nationalId,
    required String language,
  }) async {
    // TODO: PATCH /users/profile with {name, email, mobile, national_id, language}
  }

  @override
  Future<UserProfileModel> getUserProfile() async {
    // TODO: GET /users/me
    throw UnimplementedError('Remote getUserProfile not implemented yet');
  }

  @override
  Future<UserProfileModel> updateUserProfile(
    UpdateProfileRequest request,
  ) async {
    // TODO: PATCH /users/profile with request.toJson()
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
    // TODO: clear user data remote (e.g. invalidate session)
  }
}
