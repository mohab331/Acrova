import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/skeleton_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonLoader(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Resources.verticalDims.$20),
            Row(
              children: [
                SkeletonBox(width: 42.r, height: 42.r, radius: Resources.radius.$r100),
                SizedBox(width: Resources.horizontalDims.$12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(width: Resources.horizontalDims.$60, height: Resources.verticalDims.$10),
                    SizedBox(height: Resources.verticalDims.$4),
                    SkeletonBox(width: Resources.horizontalDims.$100, height: Resources.verticalDims.$16),
                  ],
                ),
              ],
            ),
            SizedBox(height: Resources.verticalDims.$24),
            SkeletonBox(width: double.infinity, height: 130.h, radius: Resources.radius.$r16),
            SizedBox(height: Resources.verticalDims.$32),
            SkeletonBox(width: Resources.horizontalDims.$120, height: Resources.verticalDims.$18),
            SizedBox(height: Resources.verticalDims.$16),
            SkeletonBox(width: double.infinity, height: 100.h, radius: Resources.radius.$r8),
            SizedBox(height: Resources.verticalDims.$12),
            SkeletonBox(width: double.infinity, height: 100.h, radius: Resources.radius.$r8),
            SizedBox(height: Resources.verticalDims.$32),
            SkeletonBox(width: Resources.horizontalDims.$120, height: Resources.verticalDims.$18),
            SizedBox(height: Resources.verticalDims.$16),
            Row(
              children: [
                Expanded(child: SkeletonBox(width: double.infinity, height: 60.h, radius: Resources.radius.$r8)),
                SizedBox(width: Resources.horizontalDims.$12),
                Expanded(child: SkeletonBox(width: double.infinity, height: 60.h, radius: Resources.radius.$r8)),
              ],
            ),
            SizedBox(height: Resources.verticalDims.$12),
            Row(
              children: [
                Expanded(child: SkeletonBox(width: double.infinity, height: 60.h, radius: Resources.radius.$r8)),
                SizedBox(width: Resources.horizontalDims.$12),
                Expanded(child: SkeletonBox(width: double.infinity, height: 60.h, radius: Resources.radius.$r8)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
