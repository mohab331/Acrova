import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Color-coded status chip for [ProjectStatus].
///
/// Design tokens:
/// - Font: Manrope 800, 8px, letter-spacing +0.8, UPPERCASE (labelMedium)
/// - Radius: 4px (pill-ish but contained)
/// - Padding: 4px vertical, 8px horizontal
class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    required this.status,
    this.locale,
    super.key,
  });

  final ProjectStatus status;

  /// Pass current locale to show Arabic label when needed.
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    final isAr = (locale ?? Localizations.localeOf(context)).languageCode == 'ar';
    final label = isAr ? status.displayLabelAr : status.displayLabel;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$8,
        vertical: Resources.verticalDims.$4,
      ),
      decoration: BoxDecoration(
        color: status.chipBackground,
        borderRadius: BorderRadius.circular(Resources.radius.$r4),
      ),
      child: Text(
        label.toUpperCase(),
        style: context.textTheme.labelSmall?.copyWith(
          fontSize: Resources.fontSizes.$8,
          fontWeight: Resources.fontWeights.extraBold,
          color: status.chipForeground,
        ),
      ),
    );
  }
}
