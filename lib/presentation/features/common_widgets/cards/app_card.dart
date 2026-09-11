import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

/// Standard surface card — white bg, 8px radius, luxuryBorder, shadowCard.
///
/// Design tokens:
/// - Background: luxurySurface (#FFFFFF)
/// - Border: 1px luxuryBorder (#EDEEEF)
/// - Radius: 8px
/// - Shadow: [AppShadows.card]
/// - Padding: 17px (Figma card padding)
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderColor,
    this.borderWidth = 1.0,
    this.radius,
    this.shadows,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final double? radius;
  final List<BoxShadow>? shadows;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = radius ?? Resources.radius.$r8;
    final effectiveShadows = shadows ?? AppShadows.card;
    final effectivePadding = padding ??
        EdgeInsets.all(Resources.horizontalDims.$16 + Resources.horizontalDims.$1);

    Widget content = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(effectiveRadius),
        border: Border.all(
          color: borderColor ?? Resources.colors.luxuryBorder,
          width: borderWidth,
        ),
        boxShadow: effectiveShadows,
      ),
      child: Padding(
        padding: effectivePadding,
        child: child,
      ),
    );

    if (onTap != null) {
      content = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }

    return content;
  }
}
