import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailDotSeparator extends StatelessWidget {
  const DetailDotSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$6),
      child: Container(
        width: Resources.squareDims.$4,
        height: Resources.squareDims.$4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Resources.colors.luxuryPlaceholder.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
