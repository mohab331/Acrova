import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/skeleton_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonCardLarge extends StatelessWidget {
  const SkeletonCardLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(width: double.infinity, height: Resources.verticalDims.$192, radius: 0),
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonBox(width: Resources.horizontalDims.$104, height: Resources.verticalDims.$14),
                    SkeletonBox(width: Resources.horizontalDims.$80, height: Resources.verticalDims.$22),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                SkeletonBox(width: Resources.horizontalDims.$206, height: Resources.verticalDims.$24),
                SizedBox(height: Resources.verticalDims.$8),
                SkeletonBox(width: double.infinity, height: Resources.verticalDims.$14),
                SizedBox(height: Resources.verticalDims.$4),
                SkeletonBox(width: 0.75.sw, height: Resources.verticalDims.$14),
                SizedBox(height: Resources.verticalDims.$20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonBox(width: Resources.horizontalDims.$80, height: Resources.verticalDims.$14),
                    SkeletonBox(width: Resources.horizontalDims.$40, height: Resources.verticalDims.$14),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                SkeletonBox(width: double.infinity, height: Resources.verticalDims.$6, radius: Resources.radius.$r100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
