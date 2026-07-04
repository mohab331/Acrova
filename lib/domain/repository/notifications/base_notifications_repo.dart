import 'package:acrova/data/models/notification/app_notification_model.dart';
import 'package:acrova/utils/helpers/result.dart';

/// Contract for the in-app notifications feed.
abstract class BaseNotificationsRepo {
  Future<Result<List<AppNotificationModel>>> getNotifications();
  Future<Result<void>> markAllAsRead();
}
