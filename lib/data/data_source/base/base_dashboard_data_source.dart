import 'package:acrova/data/models/response/dashboard/dashboard_response_model.dart';

abstract class BaseDashboardDataSource {
  Future<DashboardResponseModel> getDashboardData();
}
