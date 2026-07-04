import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/deliverables/deliverables_state.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalkthroughsSection extends StatelessWidget {
  const WalkthroughsSection({
    required this.walkthroughs,
    super.key,
  });

  final List<WalkthroughModel> walkthroughs;

  @override
  Widget build(BuildContext context) {
    if (walkthroughs.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Video Walkthroughs',
          style: context.textTheme.headlineSmall?.copyWith(
            color: Resources.colors.luxuryNavy,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$20),
        ...walkthroughs.map((walkthrough) => Padding(
          padding: EdgeInsets.only(bottom: Resources.verticalDims.$16),
          child: Container(
            decoration: BoxDecoration(
              color: Resources.colors.luxurySurface,
              borderRadius: BorderRadius.circular(Resources.radius.$r12),
              boxShadow: AppShadows.card,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(Resources.radius.$r12),
                        ),
                        child: Image.asset(
                          walkthrough.imageAsset,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Resources.colors.luxuryNavy.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(Resources.radius.$r12),
                          ),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              context.push(AppRouteEnum.walkthroughPage.path);
                            },
                            child: Container(
                              width: Resources.squareDims.$64,
                              height: Resources.squareDims.$64,
                              decoration: BoxDecoration(
                                color: Resources.colors.luxurySurface.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Resources.colors.luxuryNavy,
                                size: Resources.iconSizes.$32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Resources.verticalDims.$16,
                      right: Resources.horizontalDims.$16,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Resources.horizontalDims.$12,
                          vertical: Resources.verticalDims.$4,
                        ),
                        decoration: BoxDecoration(
                          color: Resources.colors.luxuryNavy.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(Resources.radius.$r4),
                        ),
                        child: Text(
                          walkthrough.duration,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: Resources.fontWeights.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(Resources.squareDims.$20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            walkthrough.title,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: Resources.colors.luxuryNavy,
                              fontWeight: Resources.fontWeights.bold,
                            ),
                          ),
                          Text(
                            '${walkthrough.size} • ${walkthrough.format}',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: Resources.colors.luxuryBodyMuted,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          DownloadHelper.downloadAndShare(
                            walkthrough.imageAsset, // We're sharing the asset image as a placeholder for the actual video download
                            '${walkthrough.title}.mp4',
                          );
                        },
                        icon: Icon(
                          Icons.download_outlined,
                          color: Resources.colors.luxuryGoldLight,
                        ),
                        style: IconButton.styleFrom(
                          hoverColor: Resources.colors.luxuryGoldLight.withValues(alpha: 0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Resources.radius.$r4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
