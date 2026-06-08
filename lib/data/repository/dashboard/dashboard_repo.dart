import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/data_source/base/base_dashboard_data_source.dart';
import 'package:acrova/domain/repository/dashboard/base_dashboard_repo.dart';
import 'package:acrova/utils/helpers/result.dart';

class DashboardRepo implements BaseDashboardRepo {
  final BaseDashboardDataSource dashboardDataSource;

  DashboardRepo({required this.dashboardDataSource});

  @override
  Future<Result<Map<String, dynamic>>> getDashboardData() async {
    try {
      final data = await dashboardDataSource.getDashboardData();
      return Success(data);
    } catch (e) {
      return Failure(AppErrorModel.fromException(e));
    }
  }
}
