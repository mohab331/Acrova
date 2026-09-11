import 'package:acrova/data/data_source/base/base_notifications_data_source.dart';
import 'package:acrova/data/models/notification/app_notification_model.dart';
import 'package:acrova/domain/repository/notifications/base_notifications_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class NotificationsRepoImpl implements BaseNotificationsRepo {
  const NotificationsRepoImpl({required BaseNotificationsDataSource dataSource})
      : _dataSource = dataSource;

  final BaseNotificationsDataSource _dataSource;

  @override
  Future<Result<List<AppNotificationModel>>> getNotifications() =>
      safeAsyncCall(_dataSource.getNotifications);

  @override
  Future<Result<void>> markAllAsRead() =>
      safeAsyncCall(_dataSource.markAllAsRead);
}
