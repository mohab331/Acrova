import 'package:acrova/data/data_source/base/base_notifications_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/notification/app_notification_model.dart';

class RemoteNotificationsDataSource implements BaseNotificationsDataSource {
  RemoteNotificationsDataSource({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<List<AppNotificationModel>> getNotifications() async {
    // TODO: GET /notifications
    throw UnimplementedError('Remote getNotifications not implemented yet');
  }

  @override
  Future<void> markAllAsRead() async {
    // TODO: POST /notifications/mark-all-read
    throw UnimplementedError('Remote markAllAsRead not implemented yet');
  }
}
