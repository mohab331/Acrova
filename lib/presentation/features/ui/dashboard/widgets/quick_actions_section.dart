import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_quick_actions_grid.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.dashboardQuickActions,
          style: context.textTheme.titleLarge?.copyWith(
            color: Resources.colors.luxuryNavy,
            fontSize: Resources.fontSizes.$20,
            fontWeight: Resources.fontWeights.semiBold,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$16),
        const DashboardQuickActionsGrid(),
      ],
    );
  }
}
