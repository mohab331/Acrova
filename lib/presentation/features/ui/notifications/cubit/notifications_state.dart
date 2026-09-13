import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/response/notification/app_notification_response_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class NotificationsCubitState extends Equatable {
  const NotificationsCubitState({
    required this.cubitStatus,
    this.notifications,
    this.appErrorModel,
  });

  const NotificationsCubitState.initial()
    : this(cubitStatus: CubitStatus.initial);

  final CubitStatus cubitStatus;
  final List<AppNotificationResponseModel>? notifications;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  bool get isEmpty => (notifications ?? const []).isEmpty;

  int get unreadCount =>
      (notifications ?? const []).where((n) => n.isRead != true).length;

  NotificationsCubitState copyWith({
    CubitStatus? cubitStatus,
    List<AppNotificationResponseModel>? notifications,
    AppErrorModel? appErrorModel,
  }) => NotificationsCubitState(
    cubitStatus: cubitStatus ?? this.cubitStatus,
    notifications: notifications ?? this.notifications,
    appErrorModel: appErrorModel,
  );

  @override
  List<Object?> get props => [cubitStatus, notifications, appErrorModel];
}
