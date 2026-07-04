import 'package:acrova/data/data_source/base/base_auth_data_source.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request.dart';

/// Mock implementation of [BaseAuthDataSource].
///
/// OTP pin: 123456 (6 digits — matches Figma)
/// First login is always treated as a new user.
/// Calling [saveUserProfile] flips [_isNewUser] to false.
class MockAuthDataSource implements BaseAuthDataSource {
  bool _isNewUser = true;

  // Mutable in-memory profile so update calls persist within the session.
  UserProfileModel _profile = UserProfileModel(
    name: 'Ahmed Al-Dosari',
    email: 'ahmed.dosari@example.com',
    mobileNumber: '+966 50 123 4567',
    nationalId: '1098765432',
    language: 'en',
    memberSince: DateTime(2024, 1, 15),
    projectsCount: 8,
    completedCount: 3,
    avatarUrl:
        'https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png',
  );

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
    _profile = _profile.copyWith(
      name: name,
      email: email,
      nationalId: nationalId,
      language: language,
    );
  }

  @override
  Future<UserProfileModel> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _profile;
  }

  @override
  Future<UserProfileModel> updateUserProfile(
    UpdateProfileRequest request,
  ) async {
    await Future.delayed(const Duration(milliseconds: 900));
    _profile = _profile.copyWith(
      name: request.name,
      email: request.email,
      mobileNumber: request.mobileNumber,
      avatarUrl: request.avatarPath ?? _profile.avatarUrl,
    );
    return _profile;
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
