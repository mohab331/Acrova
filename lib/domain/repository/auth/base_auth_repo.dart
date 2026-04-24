import 'package:acrova/utils/helpers/result.dart';

abstract class BaseAuthRepo {
  Future<Result<String?>> getRefreshToken();

  Future<Result<String?>> getAccessToken();

  Future<Result<String?>> getFCMToken();

  Future<Result<void>> clearUserData();
}
