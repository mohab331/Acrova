import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_hero_cta.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardHeroBanner extends StatelessWidget {
  const DashboardHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouteEnum.projectCreationPage.path),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Resources.horizontalDims.$24),
        decoration: BoxDecoration(
          color: Resources.colors.luxuryNavy,
          borderRadius: BorderRadius.circular(Resources.radius.$r16),
          boxShadow: AppShadows.hero,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localization.dashboardHeroLine1,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Resources.colors.luxurySurface,
                    fontWeight: Resources.fontWeights.semiBold,
                    height: Resources.lineHeights.$1_4,
                  ),
                ),
                Text(
                  context.localization.dashboardHeroLine2,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Resources.colors.luxuryGold,
                    fontWeight: Resources.fontWeights.semiBold,
                    height: Resources.lineHeights.$1_4,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$20),
                const DashboardHeroCta(),
              ],
            ),
            Positioned(
              right: -8,
              bottom: -8,
              child: Icon(
                Icons.architecture,
                size: Resources.iconSizes.$80,
                color: Resources.colors.luxurySurface.withValues(alpha: 0.06),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
