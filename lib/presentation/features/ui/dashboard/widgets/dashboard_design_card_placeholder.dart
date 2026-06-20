import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardDesignCardPlaceholder extends StatelessWidget {
  const DashboardDesignCardPlaceholder({required this.height, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      color: Resources.colors.luxuryNavy,
      child: Icon(
        Icons.architecture,
        size: Resources.iconSizes.$48,
        color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.3),
      ),
    );
  }
}
