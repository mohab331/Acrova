import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Inline text-only button — used for "VIEW ALL", "RESEND OTP", links, etc.
///
/// Design tokens:
/// - Color: luxuryGoldLight (#C8A96A) by default
/// - Font: Manrope 600, configurable size
/// - No background, no border
class AppTextLinkButton extends StatelessWidget {
  const AppTextLinkButton({
    required this.label,
    required this.onPressed,
    this.color,
    this.fontSize,
    this.letterSpacing,
    this.underline = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;

  /// Whether to add an underline decoration.
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Resources.colors.luxuryGoldLight;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: effectiveColor,
        overlayColor: effectiveColor.withValues(alpha: 0.08),
      ),
      child: Text(
        label,
        style: context.textTheme.bodyLarge?.copyWith(
          fontSize: Resources.fontSizes.$10,
          fontWeight: Resources.fontWeights.semiBold,
          color: effectiveColor,
          letterSpacing: letterSpacing ?? Resources.letterSpacing.$0,
          decoration: underline ? TextDecoration.underline : TextDecoration.none,
          decorationColor: effectiveColor,
        ),
      ),
    );
  }
}
