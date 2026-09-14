import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/avatar_widget.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/notification_bell.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/skeleton_box.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/notifications/cubit/notifications_cubit.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarHeader extends StatefulWidget {
  const AvatarHeader({super.key});

  @override
  State<AvatarHeader> createState() => _AvatarHeaderState();
}

class _AvatarHeaderState extends State<AvatarHeader> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthCubit>().getUser();
      context.read<NotificationsCubit>().fetchNotifications();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final authState = context.watch<AuthCubit>().state;
    final authCubit = context.read<AuthCubit>();
    final notificationState = context.watch<NotificationsCubit>().state;
    final user = authState.userModel;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (authState.getUserCubitStatus == CubitStatus.loading)
                const AppAvatarHeaderLoading()
              else ...[
                AvatarWidget(
                  avatarUrl: user?.avatarUrl,
                  userName: user?.name,
                  isError: authState.getUserCubitStatus == CubitStatus.error,
                  onRetry: authCubit.getUser,
                ),
                SizedBox(width: Resources.horizontalDims.$12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.dashboardWelcome.toUpperCase(),
                      style: context.textTheme.titleLarge?.copyWith(
                        fontSize: Resources.fontSizes.$12,
                        letterSpacing: Resources.letterSpacing.$0_14,
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$2),
                    if (user?.name?.isNotEmpty ?? false)
                      Text(
                        user?.name ?? '',
                        style: context.textTheme.labelLarge?.copyWith(
                          color: Resources.colors.luxuryInk,
                          fontWeight: Resources.fontWeights.semiBold,
                          letterSpacing: Resources.letterSpacing.$0_14,
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
          NotificationBell(count: notificationState.unreadCount),
        ],
      ),
    );
  }
}

class AppAvatarHeaderLoading extends StatelessWidget {
  const AppAvatarHeaderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SkeletonBox(
          width: Resources.iconSizes.$40,
          height: Resources.iconSizes.$40,
          radius: Resources.radius.$r100,
        ),
        SizedBox(width: Resources.horizontalDims.$12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(
              width: Resources.horizontalDims.$60,
              height: Resources.verticalDims.$10,
            ),
            SizedBox(height: Resources.verticalDims.$4),
            SkeletonBox(
              width: Resources.horizontalDims.$100,
              height: Resources.verticalDims.$16,
            ),
          ],
        ),
      ],
    );
  }
}
