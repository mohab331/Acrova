import 'package:acrova/data/models/notification/app_notification_model.dart';

/// Contract for the in-app notifications feed (distinct from FCM push tokens).
abstract class BaseNotificationsDataSource {
  Future<List<AppNotificationModel>> getNotifications();
  Future<void> markAllAsRead();
}
