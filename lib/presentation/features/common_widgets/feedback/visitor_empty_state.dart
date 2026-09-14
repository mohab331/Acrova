import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

class VisitorEmptyState extends StatelessWidget {
  const VisitorEmptyState({
    required this.icon,
    required this.title,
    this.returnRoute,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? returnRoute;

  @override
  Widget build(BuildContext context) {
    final subtitle = context.localization.login_visitor;
    final ctaLabel = context.localization.login;
    final effectiveCtaLabel = ctaLabel;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$24,
          vertical: Resources.verticalDims.$32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Resources.squareDims.$80,
              height: Resources.squareDims.$80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Resources.colors.luxuryGold.withValues(alpha: 0.08),
                border: Border.all(
                  color: Resources.colors.luxuryGold.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: Resources.iconSizes.$36,
                  color: Resources.colors.luxuryGold,
                ),
              ),
            ),
            SizedBox(height: Resources.verticalDims.$24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Resources.fonts.notoSerif,
                fontSize: Resources.fontSizes.$20,
                fontWeight: Resources.fontWeights.bold,
                color: Resources.colors.luxuryNavy,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Resources.fonts.manrope,
                fontSize: Resources.fontSizes.$14,
                color: Resources.colors.luxuryBodyMuted,
                height: Resources.lineHeights.$1_5,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$32),
            SizedBox(
              width: double.infinity,
              child: AppPrimaryButton(
                label: effectiveCtaLabel,
                onPressed: () {
                  context.push(AppRouteEnum.phonePage.name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
