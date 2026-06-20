import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/profile_footer_link.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class ProfilePageFooter extends StatelessWidget {
  const ProfilePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileFooterLink(label: l10n.termsOfService),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Resources.horizontalDims.$8,
              ),
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: Resources.colors.luxuryPlaceholder,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            ProfileFooterLink(label: l10n.privacyPolicy),
          ],
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Text(
          l10n.profileSetupCopyright,
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$10,
            color: Resources.colors.luxuryBodyMuted,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
