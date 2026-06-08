import 'package:acrova/data/data_source/base/base_auth_data_source.dart';

/// Mock implementation of [BaseAuthDataSource].
///
/// OTP pin: 123456 (6 digits — matches Figma)
/// First login is always treated as a new user.
/// Calling [saveUserProfile] flips [_isNewUser] to false.
class MockAuthDataSource implements BaseAuthDataSource {
  bool _isNewUser = true;

  @override
  Future<void> login(String phoneNumber) async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<void> verifyOtp(String otp) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (otp != '123456') {
      throw Exception('Invalid OTP. Use 123456 in mock mode.');
    }
  }

  @override
  Future<bool> isNewUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _isNewUser;
  }

  @override
  Future<void> saveUserProfile({
    required String name,
    required String email,
    required String nationalId,
    required String language,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _isNewUser = false;
  }

  @override
  Future<String?> getRefreshToken() async => 'mock_refresh_token';

  @override
  Future<String?> getAccessToken() async => 'mock_access_token';

  @override
  Future<String?> getFCMToken() async => 'mock_fcm_token';

  @override
  Future<void> clearUserData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _isNewUser = true;
  }
}
