import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:flutter/material.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonLoader(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Resources.verticalDims.$20),
            // Header card
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$260,
              radius: Resources.radius.$r8,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            // Stats row
            Row(
              children: [
                Expanded(
                  child: SkeletonBox(
                    width: double.infinity,
                    height: Resources.verticalDims.$72,
                    radius: Resources.radius.$r8,
                  ),
                ),
                SizedBox(width: Resources.horizontalDims.$12),
                Expanded(
                  child: SkeletonBox(
                    width: double.infinity,
                    height: Resources.verticalDims.$72,
                    radius: Resources.radius.$r8,
                  ),
                ),
              ],
            ),
            SizedBox(height: Resources.verticalDims.$24),
            for (int i = 0; i < 2; i++) ...[
              SkeletonBox(
                width: double.infinity,
                height: Resources.verticalDims.$120,
                radius: Resources.radius.$r8,
              ),
              SizedBox(height: Resources.verticalDims.$20),
            ],
          ],
        ),
      ),
    );
  }
}
