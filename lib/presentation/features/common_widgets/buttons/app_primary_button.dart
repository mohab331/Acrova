import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

/// Full-width navy CTA button with 2px radius and optional loading state.
///
/// Design tokens:
/// - Background: luxuryNavy (#0B1F3A)
/// - Text: white, Manrope 600, 14px, letter-spacing +1.4, UPPERCASE
/// - Radius: 2px (architectural — do not change)
/// - Height: 55px
/// - Shadow: [AppShadows.cta]
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width = double.infinity,
    this.child,
    this.height,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final double width;
  final Widget? icon;

  final double? height;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    final isActive = enabled && !isLoading && onPressed != null;

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
        boxShadow: isActive ? AppShadows.cta : null,
      ),
      child: SizedBox(
        height:height ?? Resources.verticalDims.$55,
        child: ElevatedButton(
          onPressed: isActive ? onPressed : null,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: isActive
                ? Resources.colors.luxuryNavy
                : Resources.colors.luxuryNavy.withValues(alpha: 0.5),
            foregroundColor: Resources.colors.white,
            disabledBackgroundColor: Resources.colors.luxuryNavy.withValues(
              alpha: 0.5,
            ),
            disabledForegroundColor: Resources.colors.white.withValues(
              alpha: 0.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Resources.radius.$r12),
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
                    color: Resources.colors.white,
                  ),
                )
              : child ?? _ButtonLabel(label: label, icon: icon),
        ),
      ),
    );
  }
}

class _ButtonLabel extends StatelessWidget {
  const _ButtonLabel({required this.label, this.icon});

  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: Resources.fontSizes.$14,
      fontWeight: Resources.fontWeights.semiBold,
      letterSpacing: Resources.letterSpacing.$0_8,
      color: Resources.colors.white,
    );

    if (icon == null) {
      return Text(label.toUpperCase(), style: style);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon!,
        SizedBox(width: Resources.horizontalDims.$8),
        Text(label.toUpperCase(), style: style),
      ],
    );
  }
}
