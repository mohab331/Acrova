import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProfileTermsText extends StatelessWidget {
  const ProfileTermsText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Text.rich(
      TextSpan(
        text: l10n.profileSetupTermsPrefix,
        style: TextStyle(
          fontFamily: Resources.fonts.manrope,
          fontSize: Resources.fontSizes.$12,
          color: Resources.colors.luxuryBodyMuted,
          height: Resources.lineHeights.$1_5,
        ),
        children: [
          TextSpan(
            text: l10n.termsOfService,
            style: TextStyle(color: Resources.colors.luxuryGoldLight),
          ),
          const TextSpan(text: ' · '),
          TextSpan(
            text: l10n.privacyPolicy,
            style: TextStyle(color: Resources.colors.luxuryGoldLight),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
