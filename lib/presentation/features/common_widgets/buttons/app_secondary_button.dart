import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

/// Full-width ghost / outline button.
///
/// Design tokens:
/// - Border: 1px luxuryNavy or luxuryGoldLight (via [variant])
/// - Background: transparent
/// - Text: Manrope 600, 16px, letter-spacing +0.4
/// - Radius: 2px
/// - Height: 55px
enum AppSecondaryButtonVariant { navy, gold }

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.variant = AppSecondaryButtonVariant.navy,
    this.icon,
    this.width = double.infinity,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final AppSecondaryButtonVariant variant;
  final Widget? icon;
  final double width;

  Color get _borderColor {
    if (!enabled) return Resources.colors.luxuryBorder;
    return variant == AppSecondaryButtonVariant.gold
        ? Resources.colors.luxuryGoldLight
        : Resources.colors.luxuryNavy;
  }

  Color get _textColor {
    if (!enabled) return Resources.colors.luxuryPlaceholder;
    return variant == AppSecondaryButtonVariant.gold
        ? Resources.colors.luxuryGoldLight
        : Resources.colors.luxuryNavy;
  }

  @override
  Widget build(BuildContext context) {
    final isActive = enabled && !isLoading && onPressed != null;

    return SizedBox(
      width: width,
      height: Resources.verticalDims.$55,
      child: OutlinedButton(
        onPressed: isActive ? onPressed : null,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          side: BorderSide(color: _borderColor),
          foregroundColor: _textColor,
          disabledForegroundColor: Resources.colors.luxuryPlaceholder,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Resources.radius.$r2),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$24,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: Resources.horizontalDims.$20,
                height: Resources.verticalDims.$20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _textColor,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: Resources.horizontalDims.$8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: Resources.fonts.manrope,
                      fontSize: Resources.fontSizes.$16,
                      fontWeight: Resources.fontWeights.semiBold,
                      letterSpacing: Resources.letterSpacing.$0_4,
                      color: _textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
