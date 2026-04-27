import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

extension AppButtonTheme on ThemeData {
  ButtonStyle get primaryButtonStyle {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Resources.colors.luxuryNavy,
      foregroundColor: Resources.colors.white,
      shadowColor: Resources.colors.luxuryInk.withValues(alpha: .18),
      minimumSize: Size(double.infinity, Resources.verticalDims.$55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
      ),
    );
  }
}
