import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:flutter/material.dart';

class InteriorDesignListSkeleton extends StatelessWidget {
  const InteriorDesignListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonLoader(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: Resources.verticalDims.$20),
          SkeletonBox(
            width: Resources.horizontalDims.$140,
            height: Resources.verticalDims.$28,
          ),
          SizedBox(height: Resources.verticalDims.$8),
          SkeletonBox(
            width: Resources.horizontalDims.$206,
            height: Resources.verticalDims.$16,
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Row(
            children: [
              SkeletonBox(
                width: Resources.horizontalDims.$56,
                height: Resources.verticalDims.$32,
                radius: Resources.radius.$r100,
              ),
              SizedBox(width: Resources.horizontalDims.$8),
              SkeletonBox(
                width: Resources.horizontalDims.$68,
                height: Resources.verticalDims.$32,
                radius: Resources.radius.$r100,
              ),
              SizedBox(width: Resources.horizontalDims.$8),
              SkeletonBox(
                width: Resources.horizontalDims.$92,
                height: Resources.verticalDims.$32,
                radius: Resources.radius.$r100,
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$20),
          const _SkeletonItemCard(),
          SizedBox(height: Resources.verticalDims.$16),
          const _SkeletonItemCard(),
        ],
      ),
    );
  }
}

class _SkeletonItemCard extends StatelessWidget {
  const _SkeletonItemCard();

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
          SkeletonBox(
            width: double.infinity,
            height: Resources.verticalDims.$160,
            radius: 0,
          ),
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonBox(
                      width: Resources.horizontalDims.$80,
                      height: Resources.verticalDims.$14,
                    ),
                    SkeletonBox(
                      width: Resources.horizontalDims.$64,
                      height: Resources.verticalDims.$20,
                    ),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$12),
                SkeletonBox(
                  width: Resources.horizontalDims.$160,
                  height: Resources.verticalDims.$20,
                ),
                SizedBox(height: Resources.verticalDims.$8),
                SkeletonBox(
                  width: Resources.horizontalDims.$110,
                  height: Resources.verticalDims.$14,
                ),
                SizedBox(height: Resources.verticalDims.$16),
                SkeletonBox(
                  width: double.infinity,
                  height: Resources.verticalDims.$4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
