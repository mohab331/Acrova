import 'package:acrova/data/data_source/remote/network/models/network_response.dart';
import 'package:acrova/data/models/response/config/app_config_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseAppConfigRepo {
  Future<Result<NetworkResponse<AppConfigResponseModel>>> getAppConfig();
  Future<Result<NetworkResponse<AppConfigResponseModel>>> getMinAppVersion();
  AppConfigResponseModel? get cachedConfig;
}
