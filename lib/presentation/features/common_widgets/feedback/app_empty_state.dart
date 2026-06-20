import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:flutter/material.dart';

/// Generic empty state — centered icon + title + subtitle + optional CTA.
///
/// Design tokens:
/// - Icon: luxuryNavy, 64px
/// - Title: NotoSerif 700, 20px (titleLarge)
/// - Subtitle: Manrope 400, 14px (bodySmall), luxuryBodyMuted
/// - CTA: [AppPrimaryButton] (optional)
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    this.subtitle,
    this.ctaLabel,
    this.onCtaTap,
    this.iconColor,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? ctaLabel;
  final VoidCallback? onCtaTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: Resources.iconSizes.$64,
            color: iconColor ?? Resources.colors.luxuryNavy.withValues(alpha: 0.3),
          ),
          SizedBox(height: Resources.verticalDims.$24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Resources.colors.luxuryNavy,
                ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: Resources.verticalDims.$8),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Resources.colors.luxuryBodyMuted,
                  ),
            ),
          ],
          if (ctaLabel != null && onCtaTap != null) ...[
            SizedBox(height: Resources.verticalDims.$32),
            AppPrimaryButton(label: ctaLabel!, onPressed: onCtaTap),
          ],
        ],
      ),
    );
  }
}
