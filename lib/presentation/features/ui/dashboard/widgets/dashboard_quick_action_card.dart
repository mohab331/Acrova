import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/cards/app_card.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_quick_action.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class DashboardQuickActionCard extends StatelessWidget {
  const DashboardQuickActionCard({required this.action, super.key});

  final DashboardQuickAction action;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$12,
        vertical: Resources.verticalDims.$10,
      ),
      onTap: action.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            action.icon,
            color: Resources.colors.luxuryGoldLight,
            size: Resources.iconSizes.$20,
          ),
          SizedBox(width: Resources.horizontalDims.$8),
          Flexible(
            child: Text(
              action.label,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: Resources.fontWeights.bold,
                color: Resources.colors.luxuryInk,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
