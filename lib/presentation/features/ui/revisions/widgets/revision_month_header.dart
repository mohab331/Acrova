import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class RevisionMonthHeader extends StatelessWidget {
  const RevisionMonthHeader({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Resources.verticalDims.$12,
        top: Resources.verticalDims.$8,
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontFamily: Resources.fonts.manrope,
          fontSize: Resources.fontSizes.$13,
          fontWeight: Resources.fontWeights.semiBold,
          letterSpacing: Resources.letterSpacing.$1_0,
          color: Resources.colors.luxuryNavy,
        ),
      ),
    );
  }
}
