import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/skeleton_card_large.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/skeleton_card_standard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectsSkeleton extends StatelessWidget {
  const ProjectsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonLoader(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: Resources.verticalDims.$20),
          SkeletonBox(width: Resources.horizontalDims.$140, height: Resources.verticalDims.$28),
          SizedBox(height: Resources.verticalDims.$8),
          SkeletonBox(width: Resources.horizontalDims.$206, height: Resources.verticalDims.$16),
          SizedBox(height: Resources.verticalDims.$16),
          Row(
            children: [
              SkeletonBox(width: 56.w, height: 34.h, radius: Resources.radius.$r100),
              SizedBox(width: Resources.horizontalDims.$8),
              SkeletonBox(width: 68.w, height: 34.h, radius: Resources.radius.$r100),
              SizedBox(width: Resources.horizontalDims.$8),
              SkeletonBox(width: 92.w, height: 34.h, radius: Resources.radius.$r100),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$20),
          const SkeletonCardLarge(),
          SizedBox(height: Resources.verticalDims.$16),
          const SkeletonCardStandard(),
          SizedBox(height: Resources.verticalDims.$16),
          SkeletonBox(
            width: double.infinity,
            height: Resources.verticalDims.$52,
            radius: Resources.radius.$r2,
          ),
        ],
      ),
    );
  }
}
