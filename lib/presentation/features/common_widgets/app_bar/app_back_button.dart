import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

/// Branded back button with luxuryBackground fill, border, and navy arrow icon.
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({this.onBack, super.key});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Resources.colors.luxuryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        side: BorderSide(color: Resources.colors.luxuryBorder),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        onTap: onBack ?? () => context.pop(),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: Resources.iconSizes.$16,
          color: Resources.colors.luxuryNavy,
        ),
      ),
    );
  }
}
