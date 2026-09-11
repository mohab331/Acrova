import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class ProfileFieldLabel extends StatelessWidget {
  const ProfileFieldLabel({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontFamily: Resources.fonts.manrope,
        fontSize: Resources.fontSizes.$10,
        fontWeight: Resources.fontWeights.bold,
        letterSpacing: Resources.letterSpacing.$1_0,
        color: Resources.colors.luxuryGold,
      ),
    );
  }
}
