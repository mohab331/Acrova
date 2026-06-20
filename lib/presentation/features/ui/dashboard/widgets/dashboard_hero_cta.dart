import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardHeroCta extends StatelessWidget {
  const DashboardHeroCta({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouteEnum.projectCreationPage.path),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$16,
          vertical: Resources.verticalDims.$10,
        ),
        decoration: BoxDecoration(
          color: Resources.colors.luxuryGoldLight,
          borderRadius: BorderRadius.circular(Resources.radius.$r12),
        ),
        child: Text(
          context.localization.dashboardStartProject,
          style: TextStyle(
            fontSize: Resources.fontSizes.$10,
            fontWeight: Resources.fontWeights.semiBold,
            letterSpacing: Resources.letterSpacing.$1_4,
            color: Resources.colors.white,
          ),
        ),
      ),
    );
  }
}
