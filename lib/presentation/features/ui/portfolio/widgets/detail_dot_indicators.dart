import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailDotIndicators extends StatelessWidget {
  const DetailDotIndicators({
    required this.count,
    required this.currentIndex,
    super.key,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: AppDurations.normal,
          width: Resources.squareDims.$8,
          height: Resources.squareDims.$8,
          margin: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? Resources.colors.luxuryGold
                : Resources.colors.white.withValues(alpha: 0.5),
          ),
        );
      }),
    );
  }
}
