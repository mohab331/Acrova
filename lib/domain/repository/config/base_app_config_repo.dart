import 'package:acrova/data/data_source/remote/network/models/network_response.dart';
import 'package:acrova/data/models/response/config/min_app_version_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseAppConfigRepo {
  Future<Result<NetworkResponse<MinAppVersionResponseModel>>> getMinAppVersion();
}
