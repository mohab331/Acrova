import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/data/models/auth/verify_otp_request_model.dart';
import 'package:acrova/data/models/auth/verify_otp_response_model.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/data/models/request/profile/update_profile_request.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/utils/constants/secure_constants.dart';
import 'package:acrova/utils/extensions/non_null_extension.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

import '../../../utils/helpers/result.dart';
import '../../data_source/base/base_auth_data_source.dart';

class AuthRepoImpl implements BaseAuthRepo {
  final BaseAuthDataSource _authDataSource;
  final BaseSecureStorage _secureStorage;
  final BaseLocalStorage _localStorage;

  AuthRepoImpl({
    required BaseAuthDataSource authDataSource,
    required BaseSecureStorage secureStorage,
    required BaseLocalStorage localStorage,
  }) : _authDataSource = authDataSource,
       _secureStorage = secureStorage,
       _localStorage = localStorage;

  @override
  Future<Result<void>> login(String phoneNumber) async {
    return safeAsyncCall(() async {
      await _authDataSource.login(phoneNumber);
    });
  }

  @override
  Future<Result<VerifyOTPResponseModel>> verifyOtp(
    VerifyOTPRequestModel verifyOTPRequestModel,
  ) async {
    return safeAsyncCall(() async {
      final response = await _authDataSource.verifyOtp(verifyOTPRequestModel);
      if (response.accessToken.isNullOrEmpty &&
          response.refreshToken.isNullOrEmpty) {
        throw Exception(
          'Invalid Response: AccessToken: ${response.accessToken}, RefreshToken: ${response.refreshToken}',
        );
      }
      await Future.wait([
        _secureStorage.write(SecureConstants.accessToken, response.accessToken),
        _secureStorage.write(
          SecureConstants.refreshToken,
          response.refreshToken,
        ),
      ]);
      return response;
    });
  }

  @override
  Future<Result<void>> saveProfile({
    required String name,
    required String email,
    required String nationalId,
    required String language,
  }) => safeAsyncCall(
    () => _authDataSource.saveUserProfile(
      name: name,
      email: email,
      nationalId: nationalId,
      language: language,
    ),
  );

  @override
  Future<Result<UserProfileModel>> getUserProfile() =>
      safeAsyncCall(_authDataSource.getUserProfile);

  @override
  Future<Result<UserProfileModel>> updateUserProfile(
    UpdateProfileRequest request,
  ) => safeAsyncCall(() => _authDataSource.updateUserProfile(request));

  @override
  Future<Result<void>> clearUserData() async => safeAsyncCall(
    () => Future.wait([_secureStorage.clear(), _localStorage.clear()]),
  );

  @override
  Future<Result<String?>> getAccessToken() =>
      safeAsyncCall(() => _secureStorage.read(SecureConstants.accessToken));

  @override
  Future<Result<String?>> getRefreshToken() =>
      safeAsyncCall(() => _secureStorage.read(SecureConstants.refreshToken));

  @override
  Future<Result<String?>> getFCMToken() =>
      safeAsyncCall(() => _secureStorage.read(SecureConstants.fcmToken));
}
