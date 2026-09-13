import 'package:acrova/data/data_source/base/base_dashboard_data_source.dart';
import 'package:acrova/data/models/response/dashboard/dashboard_response_model.dart';
import 'package:acrova/domain/repository/dashboard/base_dashboard_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class DashboardRepo implements BaseDashboardRepo {
  final BaseDashboardDataSource dashboardDataSource;

  DashboardRepo({required this.dashboardDataSource});

  @override
  Future<Result<DashboardResponseModel>> getDashboardData() =>
      safeAsyncCall(dashboardDataSource.getDashboardData);
}
