import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_quick_action.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_quick_action_card.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardQuickActionsGrid extends StatelessWidget {
  const DashboardQuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    final actions = [
      DashboardQuickAction(
        icon: Icons.add_circle_outline,
        label: loc.dashboardActionNewProject,
        onTap: () => context.push(AppRouteEnum.projectCreationPage.path),
      ),
      DashboardQuickAction(
        icon: Icons.headset_mic_outlined,
        label: loc.dashboardActionSupport,
        onTap: () => context.go(AppRouteEnum.messagesPage.path),
      ),
      DashboardQuickAction(
        icon: Icons.receipt_long_outlined,
        label: loc.dashboardActionUploadReceipt,
        onTap: () {},
      ),
      DashboardQuickAction(
        icon: Icons.edit_document,
        label: loc.dashboardActionRevision,
        onTap: () => context.push(AppRouteEnum.revisionHistoryPage.path),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Resources.horizontalDims.$12,
        mainAxisSpacing: Resources.verticalDims.$12,
        childAspectRatio: AppAspectRatios.quickAction,
      ),
      itemCount: actions.length,
      itemBuilder: (_, i) => DashboardQuickActionCard(action: actions[i]),
    );
  }
}
