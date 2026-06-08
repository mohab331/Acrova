import 'package:acrova/utils/helpers/result.dart';

abstract class BaseDashboardRepo {
  Future<Result<Map<String, dynamic>>> getDashboardData();
}
