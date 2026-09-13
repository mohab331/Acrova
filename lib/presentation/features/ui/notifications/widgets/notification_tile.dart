import 'package:acrova/data/models/response/notification/app_notification_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/formatters/app_formatter.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    required this.notification,
    required this.onTap,
    super.key,
  });

  final AppNotificationResponseModel? notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isRead = (notification?.isRead ?? false);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Resources.colors.luxuryBorder),
          borderRadius: BorderRadius.circular(Resources.radius.$r12),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Resources.verticalDims.$16,
          horizontal: Resources.horizontalDims.$15,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isRead) ...[
              Padding(
                padding: EdgeInsets.only(top: Resources.verticalDims.$8),
                child: Center(
                  child: Container(
                    width: Resources.squareDims.$12,
                    height: Resources.squareDims.$12,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Resources.colors.luxuryGoldLight,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Resources.colors.luxuryGoldLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Resources.horizontalDims.$12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification?.title ?? '',
                          style: context.textTheme.labelLarge?.copyWith(
                            fontSize: Resources.fontSizes.$16,
                            fontWeight: Resources.fontWeights.bold,
                            color: Resources.colors.luxuryNavy,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: Resources.horizontalDims.$8),
                      Text(
                        AppFormatter.relativeTime(
                              context,
                              notification?.createdAt,
                            ) ??
                            '',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: Resources.fontSizes.$12,
                          color: Resources.colors.luxuryBodyMuted,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    notification?.body ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: Resources.fontSizes.$14,
                      color: Resources.colors.luxuryBodyMuted,
                      height: Resources.lineHeights.$1_4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
