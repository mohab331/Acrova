import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/feedback/skeleton_box.dart';

class DeliverablesLoadingSkeleton extends StatelessWidget {
  const DeliverablesLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.colors.luxurySurface,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Resources.horizontalDims.$24,
                  vertical: Resources.verticalDims.$24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Placeholder
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonBox(
                              width: Resources.horizontalDims.$100,
                              height: Resources.verticalDims.$24,
                              borderRadius: BorderRadius.circular(Resources.radius.$r4),
                            ),
                            SizedBox(height: Resources.verticalDims.$4),
                            SkeletonBox(
                              width: Resources.horizontalDims.$150,
                              height: Resources.verticalDims.$12,
                              borderRadius: BorderRadius.circular(Resources.radius.$r4),
                            ),
                          ],
                        ),
                        SkeletonBox(
                          width: Resources.squareDims.$40,
                          height: Resources.squareDims.$40,
                          shape: BoxShape.circle,
                        ),
                      ],
                    ),
                    SizedBox(height: Resources.verticalDims.$40),

                    // Title Placeholder
                    SkeletonBox(
                      width: Resources.horizontalDims.$206,
                      height: Resources.verticalDims.$32,
                      borderRadius: BorderRadius.circular(Resources.radius.$r4),
                    ),
                    SizedBox(height: Resources.verticalDims.$8),
                    SkeletonBox(
                      width: double.infinity,
                      height: Resources.verticalDims.$16,
                      borderRadius: BorderRadius.circular(Resources.radius.$r4),
                    ),
                    SizedBox(height: Resources.verticalDims.$40),

                    // Video Card Placeholder
                    SkeletonBox(
                      width: double.infinity,
                      height: Resources.verticalDims.$200,
                      borderRadius: BorderRadius.circular(Resources.radius.$r8),
                    ),
                    SizedBox(height: Resources.verticalDims.$16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkeletonBox(
                          width: Resources.horizontalDims.$130,
                          height: Resources.verticalDims.$16,
                          borderRadius: BorderRadius.circular(Resources.radius.$r4),
                        ),
                        SkeletonBox(
                          width: Resources.horizontalDims.$60,
                          height: Resources.verticalDims.$12,
                          borderRadius: BorderRadius.circular(Resources.radius.$r4),
                        ),
                      ],
                    ),
                    SizedBox(height: Resources.verticalDims.$40),

                    // File Row Cards Placeholder
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkeletonBox(
                          width: Resources.horizontalDims.$130,
                          height: Resources.verticalDims.$20,
                          borderRadius: BorderRadius.circular(Resources.radius.$r4),
                        ),
                        SkeletonBox(
                          width: Resources.horizontalDims.$50,
                          height: Resources.verticalDims.$12,
                          borderRadius: BorderRadius.circular(Resources.radius.$r4),
                        ),
                      ],
                    ),
                    SizedBox(height: Resources.verticalDims.$16),
                    ...List.generate(3, (index) => Padding(
                      padding: EdgeInsets.only(bottom: Resources.verticalDims.$16),
                      child: Container(
                        padding: EdgeInsets.all(Resources.squareDims.$16),
                        decoration: BoxDecoration(
                          color: Resources.colors.luxuryInputBg,
                          borderRadius: BorderRadius.circular(Resources.radius.$r4),
                        ),
                        child: Row(
                          children: [
                            SkeletonBox(
                              width: Resources.squareDims.$40,
                              height: Resources.squareDims.$40,
                              borderRadius: BorderRadius.circular(Resources.radius.$r4),
                            ),
                            SizedBox(width: Resources.horizontalDims.$16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SkeletonBox(
                                    width: Resources.horizontalDims.$150,
                                    height: Resources.verticalDims.$16,
                                    borderRadius: BorderRadius.circular(Resources.radius.$r4),
                                  ),
                                  SizedBox(height: Resources.verticalDims.$8),
                                  SkeletonBox(
                                    width: Resources.horizontalDims.$60,
                                    height: Resources.verticalDims.$12,
                                    borderRadius: BorderRadius.circular(Resources.radius.$r4),
                                  ),
                                ],
                              ),
                            ),
                            SkeletonBox(
                              width: Resources.squareDims.$25,
                              height: Resources.squareDims.$25,
                              shape: BoxShape.circle,
                            ),
                          ],
                        ),
                      ),
                    )),
                    SizedBox(height: Resources.verticalDims.$40),

                    // Renders Grid Placeholder
                    SkeletonBox(
                      width: Resources.horizontalDims.$150,
                      height: Resources.verticalDims.$20,
                      borderRadius: BorderRadius.circular(Resources.radius.$r4),
                    ),
                    SizedBox(height: Resources.verticalDims.$16),
                    SkeletonBox(
                      width: double.infinity,
                      height: Resources.verticalDims.$200,
                      borderRadius: BorderRadius.circular(Resources.radius.$r4),
                    ),
                    SizedBox(height: Resources.verticalDims.$16),
                    Row(
                      children: [
                        Expanded(
                          child: SkeletonBox(
                            width: double.infinity,
                            height: Resources.verticalDims.$150,
                            borderRadius: BorderRadius.circular(Resources.radius.$r4),
                          ),
                        ),
                        SizedBox(width: Resources.horizontalDims.$16),
                        Expanded(
                          child: SkeletonBox(
                            width: double.infinity,
                            height: Resources.verticalDims.$150,
                            borderRadius: BorderRadius.circular(Resources.radius.$r4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Resources.verticalDims.$40),

                    // Bottom Actions Placeholder
                    Row(
                      children: [
                        Expanded(
                          child: SkeletonBox(
                            width: double.infinity,
                            height: Resources.verticalDims.$48,
                            borderRadius: BorderRadius.circular(Resources.radius.$r4),
                          ),
                        ),
                        SizedBox(width: Resources.horizontalDims.$16),
                        Expanded(
                          child: SkeletonBox(
                            width: double.infinity,
                            height: Resources.verticalDims.$48,
                            borderRadius: BorderRadius.circular(Resources.radius.$r4),
                          ),
                        ),
                      ],
                    ),
                    
                    // Extra padding at the bottom for safety
                    SizedBox(height: Resources.verticalDims.$100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
