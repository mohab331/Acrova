import 'package:acrova/data/data_source/base/base_dashboard_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/response/dashboard/dashboard_response_model.dart';

class RemoteDashboardDataSource implements BaseDashboardDataSource {
  final ApiClient apiClient;

  RemoteDashboardDataSource({required this.apiClient});

  @override
  Future<DashboardResponseModel> getDashboardData() async {
    // final response = await apiClient.get('dashboard', onMap: DashboardResponseModel.fromJson);
    // return response.data ?? const DashboardResponseModel();
    return const DashboardResponseModel();
  }
}
