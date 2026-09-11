import 'package:acrova/data/data_source/base/base_dashboard_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';

class RemoteDashboardDataSource implements BaseDashboardDataSource {
  final ApiClient apiClient;

  RemoteDashboardDataSource({required this.apiClient});

  @override
  Future<Map<String, dynamic>> getDashboardData() async {
    // TODO: implement real API call
    // final response = await apiClient.get('dashboard');
    // return response.data as Map<String, dynamic>;
    return {};
  }
}
