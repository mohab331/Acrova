import 'package:acrova/data/models/response/notification/app_notification_response_model.dart';

/// Contract for the in-app notifications feed (distinct from FCM push tokens).
abstract class BaseNotificationsDataSource {
  Future<List<AppNotificationResponseModel>> getNotifications();
  Future<void> markAllAsRead();
}
