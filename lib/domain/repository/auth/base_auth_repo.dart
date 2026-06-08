import 'package:acrova/utils/helpers/result.dart';

abstract class BaseAuthRepo {
  Future<Result<void>> login(String phoneNumber);

  Future<Result<void>> verifyOtp(String otp);

  /// Returns `true` if this is the first time the user logs in (KYC required).
  Future<Result<bool>> isNewUser();

  /// Saves KYC profile after first login. Marks user as no longer new.
  /// Collects: full name, email, mobile number, national ID, preferred language.
  Future<Result<void>> saveProfile({
    required String name,
    required String email,
    required String nationalId,
    required String language,
  });

  Future<Result<String?>> getRefreshToken();

  Future<Result<String?>> getAccessToken();

  Future<Result<String?>> getFCMToken();

  Future<Result<void>> clearUserData();
}
