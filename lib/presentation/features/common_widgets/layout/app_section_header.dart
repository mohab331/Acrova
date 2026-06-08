import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_text_link_button.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Section title row — NotoSerif Bold title on the left + optional gold "VIEW ALL" link on the right.
///
/// Design tokens:
/// - Title: NotoSerif 700, 20px, letterSpacing -0.5 (titleLarge from textTheme)
/// - Action: Manrope 600, 14px, luxuryGoldLight, letterSpacing +1.4, UPPERCASE
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    this.actionLabel,
    this.onActionTap,
    this.bottomSpacing,
    super.key,
  });

  final String title;

  /// Optional action label (e.g. "VIEW ALL"). Shown only when [onActionTap] is provided.
  final String? actionLabel;
  final VoidCallback? onActionTap;

  /// Spacing below the header row. Defaults to [Resources.verticalDims.$16].
  final double? bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final showAction = onActionTap != null && actionLabel != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                    color: Resources.colors.luxuryNavy,
                fontSize: AppTextTokens.sectionTitle,
                fontWeight: Resources.fontWeights.semiBold
                  ),
            ),
            if (showAction)
              AppTextLinkButton(
                label: actionLabel!.toUpperCase(),
                onPressed: onActionTap,
                letterSpacing: Resources.letterSpacing.$1_4,
                fontSize: Resources.fontSizes.$12,
              ),
          ],
        ),
        SizedBox(height: bottomSpacing ?? Resources.verticalDims.$16),
      ],
    );
  }
}
