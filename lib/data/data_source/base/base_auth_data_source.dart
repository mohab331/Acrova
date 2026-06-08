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
  Future<String?> getRefreshToken();
  Future<String?> getAccessToken();
  Future<String?> getFCMToken();
  Future<void> clearUserData();
}
