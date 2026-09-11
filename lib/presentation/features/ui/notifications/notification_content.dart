import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_empty_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/ui/notifications/cubit/notifications_cubit.dart';
import 'package:acrova/presentation/features/ui/notifications/widgets/notification_tile.dart';
import 'package:acrova/presentation/features/ui/notifications/widgets/notifications_skeleton.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationContent extends StatelessWidget {
  const NotificationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationCubit = context.read<NotificationsCubit>();
    final notificationState = context.watch<NotificationsCubit>().state;
    if (notificationState.isLoading ||
        notificationState.cubitStatus == CubitStatus.initial) {
      return const NotificationsSkeleton();
    }
    if (notificationState.isError) {
      return AppErrorState(
        title: context.localization.notificationsErrorTitle,
        message: context.localization.notificationsErrorBody,
        onRetry: notificationCubit.fetchNotifications,
      );
    }
    if (notificationState.isEmpty) {
      return Center(
        child: AppEmptyState(
          icon: Icons.notifications_none_outlined,
          title: context.localization.notificationsEmptyTitle,
          subtitle: context.localization.notificationsEmptySubtitle,
        ),
      );
    }

    return RefreshIndicator(
      color: Resources.colors.luxuryGoldLight,
      onRefresh: notificationCubit.fetchNotifications,
      child: ListView.separated(
        separatorBuilder: (_, __) =>
            SizedBox(height: Resources.verticalDims.$6),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: notificationState.notifications?.length ?? 0,
        itemBuilder: (_, i) {
          final entry = notificationState.notifications?[i];
          final bool isLastItem =
              i == ((notificationState.notifications?.length ?? 0) - 1);
          return Column(
            children: [
              NotificationTile(
                notification: entry,
                onTap: () {
                  notificationCubit.markAsRead(entry?.id);
                },
              ),
              if (isLastItem) SizedBox(height: Resources.verticalDims.$32),
            ],
          );
        },
      ),
    );
  }
}
