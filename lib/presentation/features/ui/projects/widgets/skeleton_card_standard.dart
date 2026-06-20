import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/skeleton_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonCardStandard extends StatelessWidget {
  const SkeletonCardStandard({super.key});

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
          SkeletonBox(width: double.infinity, height: Resources.verticalDims.$160, radius: 0),
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonBox(width: Resources.horizontalDims.$80, height: Resources.verticalDims.$12),
                    SkeletonBox(width: Resources.horizontalDims.$75, height: Resources.verticalDims.$20),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                SkeletonBox(width: Resources.horizontalDims.$130, height: Resources.verticalDims.$20),
                SizedBox(height: Resources.verticalDims.$6),
                SkeletonBox(width: double.infinity, height: Resources.verticalDims.$12),
                SizedBox(height: Resources.verticalDims.$20),
                Divider(height: 1, color: Resources.colors.luxuryBorder),
                SizedBox(height: Resources.verticalDims.$12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonBox(width: Resources.horizontalDims.$75, height: Resources.verticalDims.$12),
                    SkeletonBox(width: Resources.horizontalDims.$32, height: Resources.verticalDims.$12),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                SkeletonBox(width: double.infinity, height: 4.h, radius: Resources.radius.$r100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
