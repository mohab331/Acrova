import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class ProfileFooterLink extends StatelessWidget {
  const ProfileFooterLink({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        label,
        style: TextStyle(
          fontFamily: Resources.fonts.manrope,
          fontSize: Resources.fontSizes.$12,
          color: Resources.colors.luxuryGold,
          fontWeight: Resources.fontWeights.medium,
        ),
      ),
    );
  }
}
