import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class ProjectImagePlaceholder extends StatelessWidget {
  const ProjectImagePlaceholder({required this.height, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Resources.colors.luxuryNavy, Resources.colors.luxuryInk],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.apartment_outlined,
          size: Resources.squareDims.$48,
          color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
