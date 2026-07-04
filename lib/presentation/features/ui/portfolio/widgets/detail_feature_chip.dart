import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class DetailFeatureChip extends StatelessWidget {
  const DetailFeatureChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$12, vertical: Resources.verticalDims.$6),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryProgressTrack,
        borderRadius: BorderRadius.circular(Resources.radius.$r100),
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          fontSize: Resources.fontSizes.$11,
          fontWeight: Resources.fontWeights.semiBold,
          color: Resources.colors.luxuryNavy,
        ),
      ),
    );
  }
}
