import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:flutter/material.dart';

class RevisionRequestSkeleton extends StatelessWidget {
  const RevisionRequestSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonLoader(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$20,
          vertical: Resources.verticalDims.$16,
        ),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(
              width: Resources.horizontalDims.$206,
              height: Resources.verticalDims.$16,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$90,
              radius: Resources.radius.$r2,
            ),
            SizedBox(height: Resources.verticalDims.$32),
            SkeletonBox(
              width: Resources.horizontalDims.$130,
              height: Resources.verticalDims.$14,
            ),
            SizedBox(height: Resources.verticalDims.$12),
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$40,
              radius: Resources.radius.$r100,
            ),
            SizedBox(height: Resources.verticalDims.$32),
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$120,
              radius: Resources.radius.$r2,
            ),
            SizedBox(height: Resources.verticalDims.$32),
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$120,
              radius: Resources.radius.$r2,
            ),
            SizedBox(height: Resources.verticalDims.$32),
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$120,
              radius: Resources.radius.$r2,
            ),

          ],
        ),
      ),
    );
  }
}
