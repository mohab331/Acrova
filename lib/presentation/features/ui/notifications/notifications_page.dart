import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';

import 'package:acrova/presentation/features/ui/notifications/cubit/notifications_cubit.dart';
import 'package:acrova/presentation/features/ui/notifications/notification_content.dart';

import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
      create: (context) =>
      serviceLocatorInstance<NotificationsCubit>()
        ..fetchNotifications(),
      child: CommonScreen(
            bottomPadding: 0,
            appBar: AppAuthBrandHeader(
              showBack: true,
              label: context.localization.notificationsTitle,
            ),
            child: const NotificationContent(),
          ),
    );
  }
}



