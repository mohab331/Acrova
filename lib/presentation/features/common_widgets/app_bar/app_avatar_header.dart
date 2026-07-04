import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/avatar_widget.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/notification_bell.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class AvatarHeader extends StatelessWidget {
  const AvatarHeader({
    required this.userName,
    required this.notificationCount,
    this.avatarUrl,
    super.key,
  });

  final String userName;
  final int notificationCount;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AvatarWidget(avatarUrl: avatarUrl, userName: userName),
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
                  Text(
                    userName,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Resources.colors.luxuryInk,
                      fontWeight: Resources.fontWeights.semiBold,
                      letterSpacing: Resources.letterSpacing.$0_14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          NotificationBell(count: notificationCount),
        ],
      ),
    );
  }
}
