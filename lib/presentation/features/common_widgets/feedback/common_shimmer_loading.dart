import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:flutter/material.dart';

/// Globally reusable shimmer loading widget for full-screen and section loaders.
class CommonShimmerLoading extends StatelessWidget {
  const CommonShimmerLoading({
    this.itemCount = 4,
    this.padding,
    this.isDetail = false,
    this.child,
    super.key,
  });

  final int itemCount;
  final EdgeInsetsGeometry? padding;
  final bool isDetail;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return AppSkeletonLoader(child: child!);
    }

    if (isDetail) {
      return _buildDetailSkeleton(context);
    }

    return _buildListSkeleton(context);
  }

  Widget _buildListSkeleton(BuildContext context) {
    return AppSkeletonLoader(
      child: ListView.separated(
        padding:
            padding ??
            EdgeInsets.symmetric(
              horizontal: Resources.horizontalDims.$20,
              vertical: Resources.verticalDims.$16,
            ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        separatorBuilder: (_, __) =>
            SizedBox(height: Resources.verticalDims.$16),
        itemBuilder: (_, __) => Container(
          padding: EdgeInsets.all(Resources.horizontalDims.$16),
          decoration: BoxDecoration(
            color: Resources.colors.luxurySurface,
            borderRadius: BorderRadius.circular(Resources.radius.$r8),
            border: Border.all(color: Resources.colors.luxuryBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(
                width: double.infinity,
                height: Resources.verticalDims.$20,
                radius: Resources.radius.$r4,
              ),
              SizedBox(height: Resources.verticalDims.$12),
              SkeletonBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: Resources.verticalDims.$14,
                radius: Resources.radius.$r4,
              ),
              SizedBox(height: Resources.verticalDims.$16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SkeletonBox(
                    width: Resources.horizontalDims.$80,
                    height: Resources.verticalDims.$16,
                    radius: Resources.radius.$r4,
                  ),
                  SkeletonBox(
                    width: Resources.horizontalDims.$60,
                    height: Resources.verticalDims.$16,
                    radius: Resources.radius.$r4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSkeleton(BuildContext context) {
    return AppSkeletonLoader(
      child: SingleChildScrollView(
        padding:
            padding ??
            EdgeInsets.symmetric(
              horizontal: Resources.horizontalDims.$20,
              vertical: Resources.verticalDims.$16,
            ),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$200,
              radius: Resources.radius.$r12,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            SkeletonBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: Resources.verticalDims.$28,
              radius: Resources.radius.$r4,
            ),
            SizedBox(height: Resources.verticalDims.$12),
            SkeletonBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: Resources.verticalDims.$16,
              radius: Resources.radius.$r4,
            ),
            SizedBox(height: Resources.verticalDims.$24),
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$80,
              radius: Resources.radius.$r8,
            ),
            SizedBox(height: Resources.verticalDims.$16),
            SkeletonBox(
              width: double.infinity,
              height: Resources.verticalDims.$120,
              radius: Resources.radius.$r8,
            ),
          ],
        ),
      ),
    );
  }
}
