import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:flutter/material.dart';

class NotificationsSkeleton extends StatelessWidget {
  const NotificationsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonLoader(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: Resources.verticalDims.$20),
        itemCount: 10,
        separatorBuilder: (_, __) =>
            Divider(height: 1, color: Resources.colors.luxuryBorder),
        itemBuilder: (_, __) => const _SkeletonRow(),
      ),
    );
  }
}

class _SkeletonRow extends StatelessWidget {
  const _SkeletonRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$24,
        vertical: Resources.verticalDims.$16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonBox(
                width: Resources.horizontalDims.$150,
                height: Resources.verticalDims.$16,
              ),
              SkeletonBox(
                width: Resources.horizontalDims.$26,
                height: Resources.verticalDims.$12,
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$8),
          SkeletonBox(
            width: double.infinity,
            height: Resources.verticalDims.$12,
          ),
          SizedBox(height: Resources.verticalDims.$6),
          SkeletonBox(
            width: Resources.horizontalDims.$206,
            height: Resources.verticalDims.$12,
          ),
        ],
      ),
    );
  }
}
