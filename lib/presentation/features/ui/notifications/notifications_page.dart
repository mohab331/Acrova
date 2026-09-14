import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/visitor_empty_state.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/notifications/cubit/notifications_cubit.dart';
import 'package:acrova/presentation/features/ui/notifications/notification_content.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!context.read<AuthCubit>().state.isGuest) {
        context.read<NotificationsCubit>().fetchNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomPadding: 0,
      appBar: AppAuthBrandHeader(
        showBack: true,
        label: context.localization.notificationsTitle,
      ),
      child: context.watch<AuthCubit>().state.isGuest
          ? VisitorEmptyState(
              icon: Icons.notifications_none_outlined,
              title: context.localization.visitorNotificationsTitle,
            )
          : const NotificationContent(),
    );
  }
}
