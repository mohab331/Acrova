import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class WelcomeTitleSubtitleWidget extends StatelessWidget {
  const WelcomeTitleSubtitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.textTheme;
    final localization = context.localization;

    final titlePrimary = context.textTheme.headlineLarge?.copyWith(
      color: Resources.colors.luxuryInk,
      fontWeight: Resources.fontWeights.semiBold,
      height: 1.3,
    );

    final titleSecondary = context.textTheme.headlineLarge?.copyWith(
      color: Resources.colors.luxuryGold,
      fontWeight: Resources.fontWeights.semiBold,
      height: 1.2,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${localization.welcome_title_line1}\n',
                style: titlePrimary,
              ),
              TextSpan(
                text: localization.welcome_title_line2,
                style: titleSecondary,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Resources.verticalDims.$24),
        Text(
          localization.welcome_subtitle,
          style: theme.bodyLarge?.copyWith(
            color: Resources.colors.luxuryBody,
            fontWeight: Resources.fontWeights.light,
            letterSpacing: 1.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
