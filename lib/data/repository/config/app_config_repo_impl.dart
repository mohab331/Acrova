import 'package:acrova/data/data_source/remote/network/models/network_response.dart';
import 'package:acrova/data/data_source/remote/services/config/app_config_service.dart';
import 'package:acrova/data/models/response/config/app_config_response_model.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class AppConfigRepoImpl implements BaseAppConfigRepo {
  AppConfigRepoImpl({required AppConfigService appConfigService})
    : _appConfigService = appConfigService;

  final AppConfigService _appConfigService;
  AppConfigResponseModel? _cachedConfig;

  @override
  AppConfigResponseModel? get cachedConfig => _cachedConfig;

  @override
  Future<Result<NetworkResponse<AppConfigResponseModel>>> getAppConfig() async {
    final result = await safeAsyncCall(_appConfigService.getAppConfig);
    result.when(
      success: (response) {
        if (response.data != null) {
          _cachedConfig = response.data;
        }
      },
      failure: (_) {},
    );
    return result;
  }

  @override
  Future<Result<NetworkResponse<AppConfigResponseModel>>> getMinAppVersion() =>
      getAppConfig();
}
