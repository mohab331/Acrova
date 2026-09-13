import 'package:acrova/data/models/response/dashboard/dashboard_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

abstract class BaseDashboardRepo {
  Future<Result<DashboardResponseModel>> getDashboardData();
}
