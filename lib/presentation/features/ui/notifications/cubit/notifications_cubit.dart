import 'package:acrova/data/models/notification/app_notification_model.dart';
import 'package:acrova/domain/repository/notifications/base_notifications_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:bloc/bloc.dart';

import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsCubitState> {
  NotificationsCubit({required BaseNotificationsRepo notificationsRepo})
    : _notificationsRepo = notificationsRepo,
      super(const NotificationsCubitState.initial());

  final BaseNotificationsRepo _notificationsRepo;

  Future<void> fetchNotifications() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    await safeCubitCall<List<AppNotificationModel>>(
      call: _notificationsRepo.getNotifications,
      onSuccess: (notifications) => emit(
        state.copyWith(
          cubitStatus: CubitStatus.success,
          notifications: notifications,
        ),
      ),
      onError: (error) => emit(
        state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
      ),
    );
  }

  Future<void> markAllAsRead() async {
    final current = state.notifications;
    if (current == null || current.every((n) => n.isRead)) return;

    // Optimistic update.
    emit(
      state.copyWith(
        notifications: current.map((n) => n.copyWith(isRead: true)).toList(),
      ),
    );

    await safeAsync(
      operation: () async {
        final result = await _notificationsRepo.markAllAsRead();
        result.when(
          success: (_) {},
          failure: (error) {
            AppLogger.instance.logWarning(
              'Failed to mark all as read: ${error.message}',
            );
            emit(state.copyWith(notifications: current));
          },
        );
      },
      onError: (error) {
        emit(state.copyWith(notifications: current));
      },
    );
  }

  Future<void> markAsRead(String? notificationId) async {
    final current = state.notifications;
    if (current == null) return;

    // Optimistic update.
    emit(
      state.copyWith(
        notifications: current
            .map((n) => n.id == notificationId ? n.copyWith(isRead: true) : n)
            .toList(),
      ),
    );
  }
}
