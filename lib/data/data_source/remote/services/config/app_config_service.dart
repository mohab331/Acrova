import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/data_source/remote/network/models/endpoint.dart';
import 'package:acrova/data/data_source/remote/network/models/network_response.dart';
import 'package:acrova/data/data_source/remote/services/config/constants/config_endpoints.dart';
import 'package:acrova/data/models/response/config/min_app_version_response_model.dart';

class AppConfigService {
  const AppConfigService({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<NetworkResponse<MinAppVersionResponseModel>> getMinAppVersion() =>
      _apiClient.post(
        isDriverIdRequired: false,
        requiresAuth: false,
        const Endpoint(path: ConfigEndpoints.getMinAppVersion),
        onMap: MinAppVersionResponseModel.fromJson,
      );
}
