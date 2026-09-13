import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/app_viewer_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// "By continuing you agree to ... Terms of Service and Privacy Policy."
///
/// Links use luxuryGoldLight color and route to configured legal URLs.
class TermsAndPrivacyText extends StatefulWidget {
  const TermsAndPrivacyText({super.key});

  @override
  State<TermsAndPrivacyText> createState() => _TermsAndPrivacyTextState();
}

class _TermsAndPrivacyTextState extends State<TermsAndPrivacyText> {
  late final TapGestureRecognizer _termsRecognizer;
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()..onTap = _onTermsTap;
    _privacyRecognizer = TapGestureRecognizer()..onTap = _onPrivacyTap;
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  void _onTermsTap() {
    final config = serviceLocatorInstance<BaseAppConfigRepo>().cachedConfig;
    AppViewerHelper.openDocumentOrUrl(
      context,
      urlOrAsset: config?.termsAndConditionsUrl,
      title: context.localization.termsOfService,
    );
  }

  void _onPrivacyTap() {
    final config = serviceLocatorInstance<BaseAppConfigRepo>().cachedConfig;
    AppViewerHelper.openDocumentOrUrl(
      context,
      urlOrAsset: config?.privacyPolicyUrl,
      title: context.localization.privacyPolicy,
    );
  }

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
            recognizer: _termsRecognizer,
          ),
          TextSpan(text: loc.termsConnector, style: bodyStyle),
          TextSpan(
            text: loc.privacyPolicy,
            style: linkStyle,
            recognizer: _privacyRecognizer,
          ),
          TextSpan(text: loc.termsSuffix, style: bodyStyle),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
