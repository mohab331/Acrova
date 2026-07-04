import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:flutter/material.dart';

class RevisionHistorySkeleton extends StatelessWidget {
  const RevisionHistorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonLoader(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SkeletonBox(
            width: Resources.horizontalDims.$130,
            height: Resources.verticalDims.$14,
          ),
          SizedBox(height: Resources.verticalDims.$16),
          for (int i = 0; i < 3; i++) ...[
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$160,
              radius: Resources.radius.$r8,
            ),
            SizedBox(height: Resources.verticalDims.$16),
          ],
        ],
      ),
    );
  }
}
