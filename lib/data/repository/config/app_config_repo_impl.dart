import 'package:acrova/data/data_source/remote/network/models/network_response.dart';
import 'package:acrova/data/data_source/remote/services/config/app_config_service.dart';
import 'package:acrova/data/models/response/config/min_app_version_response_model.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class AppConfigRepoImpl implements BaseAppConfigRepo {
  const AppConfigRepoImpl({required AppConfigService appConfigService})
    : _appConfigService = appConfigService;

  final AppConfigService _appConfigService;

  @override
  Future<Result<NetworkResponse<MinAppVersionResponseModel>>>
  getMinAppVersion() => safeAsyncCall(_appConfigService.getMinAppVersion);
}
