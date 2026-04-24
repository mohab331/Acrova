import '../../network/api_client.dart';

class AuthService {
  const AuthService({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

}

