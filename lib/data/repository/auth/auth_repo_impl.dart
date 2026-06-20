import 'package:acrova/utils/constants/secure_constants.dart';
import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
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
  Future<Result<void>> verifyOtp(String otp) async {
    return safeAsyncCall(() async {
      await _authDataSource.verifyOtp(otp);
    });
  }

  @override
  Future<Result<bool>> isNewUser() =>
      safeAsyncCall(_authDataSource.isNewUser);

  @override
  Future<Result<void>> saveProfile({
    required String name,
    required String email,
    required String nationalId,
    required String language,
  }) =>
      safeAsyncCall(() => _authDataSource.saveUserProfile(
            name: name,
            email: email,
            nationalId: nationalId,
            language: language,
          ));

  @override
  Future<Result<void>> clearUserData() async => safeAsyncCall(() => Future.wait([
        _secureStorage.clear(),
      ]));

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
