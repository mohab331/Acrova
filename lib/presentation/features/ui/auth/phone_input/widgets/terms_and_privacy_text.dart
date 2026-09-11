import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// "By continuing you agree to ... Terms of Service and Privacy Policy."
///
/// Links use luxuryGoldLight color.
class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyStyle = context.textTheme.bodySmall?.copyWith(
      color: Resources.colors.luxuryBodyMuted,
    );
    final linkStyle = context.textTheme.bodySmall?.copyWith(
      color: Resources.colors.luxuryGoldLight,
      fontWeight: Resources.fontWeights.semiBold,
    );

    final loc = context.localization;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: loc.termsPrefix, style: bodyStyle),
          TextSpan(
            text: loc.termsOfService,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(text: loc.termsConnector, style: bodyStyle),
          TextSpan(
            text: loc.privacyPolicy,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(text: loc.termsSuffix, style: bodyStyle),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
