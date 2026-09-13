import 'package:acrova/data/models/response/notification/app_notification_response_model.dart';
import 'package:acrova/utils/helpers/result.dart';

/// Contract for the in-app notifications feed.
abstract class BaseNotificationsRepo {
  Future<Result<List<AppNotificationResponseModel>>> getNotifications();
  Future<Result<void>> markAllAsRead();
}
