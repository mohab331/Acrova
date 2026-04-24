import 'package:acrova/data/data_source/local/constants/secure_constants.dart';
import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

import '../../../utils/helpers/result.dart';
import '../../data_source/remote/services/auth/auth_service.dart';



class AuthRepoImpl implements BaseAuthRepo {
  final AuthService _authService;
  final BaseSecureStorage _secureStorage;
  final BaseLocalStorage _localStorage;

  AuthRepoImpl({
    required AuthService authService,
    required BaseSecureStorage secureStorage,
    required BaseLocalStorage localStorage,
  }) : _authService = authService,
       _secureStorage = secureStorage,
       _localStorage = localStorage;


  @override
  Future<Result<void>> clearUserData() async => safeAsyncCall(() =>  Future.wait([
    _secureStorage.clear(),
  ]),);



  @override
  Future<Result<String?>> getAccessToken() =>
      safeAsyncCall(() => _secureStorage.read(SecureConstants.accessToken));

  @override
  Future<Result<String?>> getRefreshToken() =>
      safeAsyncCall(() => _secureStorage.read(SecureConstants.refreshToken));



  @override
  Future<Result<String?>> getFCMToken() =>
      safeAsyncCall(() => _secureStorage.read((SecureConstants.fcmToken)));

}
