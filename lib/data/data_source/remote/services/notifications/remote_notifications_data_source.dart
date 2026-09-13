import 'package:acrova/data/data_source/base/base_notifications_data_source.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/models/response/notification/app_notification_response_model.dart';

class RemoteNotificationsDataSource implements BaseNotificationsDataSource {
  RemoteNotificationsDataSource({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<List<AppNotificationResponseModel>> getNotifications() async {
    throw UnimplementedError('Remote getNotifications not implemented yet');
  }

  @override
  Future<void> markAllAsRead() async {
    throw UnimplementedError('Remote markAllAsRead not implemented yet');
  }
}
