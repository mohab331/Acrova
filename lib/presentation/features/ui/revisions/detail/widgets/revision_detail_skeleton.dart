import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:flutter/material.dart';

class RevisionDetailSkeleton extends StatelessWidget {
  const RevisionDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonLoader(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Resources.horizontalDims.$24),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$120,
              radius: Resources.radius.$r2,
            ),
            SizedBox(height: Resources.verticalDims.$32),
            SkeletonBox(
              width: Resources.horizontalDims.$130,
              height: Resources.verticalDims.$14,
            ),
            SizedBox(height: Resources.verticalDims.$16),
            SkeletonBox(width: double.infinity, height: Resources.verticalDims.$14),
            SizedBox(height: Resources.verticalDims.$8),
            SkeletonBox(width: double.infinity, height: Resources.verticalDims.$14),
            SizedBox(height: Resources.verticalDims.$8),
            SkeletonBox(width: Resources.horizontalDims.$150, height: Resources.verticalDims.$14),
            SizedBox(height: Resources.verticalDims.$32),
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$160,
              radius: Resources.radius.$r2,
            ),
          ],
        ),
      ),
    );
  }
}
