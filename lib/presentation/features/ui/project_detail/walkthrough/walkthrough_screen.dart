import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/deliverables/deliverables_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:flutter/material.dart';

import 'widgets/previous_version_card.dart';
import 'widgets/walkthrough_video_player.dart';

class WalkthroughScreen extends StatelessWidget {
  const WalkthroughScreen({
    this.walkthrough,
    this.projectName = '',
    this.videoUrl = '',
    this.thumbnailUrl = '',
    super.key,
  });

  final WalkthroughModel? walkthrough;
  final String projectName;
  final String videoUrl;
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final title = walkthrough?.title ?? (projectName.isNotEmpty ? projectName : loc.walkthroughTitle);
    final duration = walkthrough?.duration ?? '';
    final size = walkthrough?.size ?? '';
    final activeVideoUrl = walkthrough?.videoUrl ?? videoUrl;
    final activeThumbnailUrl = walkthrough?.imageAsset ?? thumbnailUrl;
    final previousVersions = walkthrough?.previousVersions ?? const [];

    return CommonScreen(
      bottomPadding: 0,
      appBar: AppAuthBrandHeader(
        label: loc.walkthroughTitle,
        showBack: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$20,
            vertical: Resources.verticalDims.$24,
          ),
          decoration: BoxDecoration(
            color: Resources.colors.luxurySurface.withValues(alpha: 0.9),
            border: Border(
              top: BorderSide(
                color: Resources.colors.luxuryBorder.withValues(alpha: 0.5),
              ),
            ),
          ),
          child: AppPrimaryButton(
            label: loc.walkthroughDownload,
            icon: Icon(
              Icons.download_rounded,
              color: Resources.colors.white,
              size: Resources.fontSizes.$20,
            ),
            onPressed: () {
              if (activeVideoUrl.isNotEmpty) {
                DownloadHelper.downloadAndShare(
                  activeVideoUrl,
                  '$title.mp4',
                );
              }
            },
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Player
            WalkthroughVideoPlayer(
              videoUrl: activeVideoUrl,
              thumbnailUrl: activeThumbnailUrl,
            ),

            SizedBox(height: Resources.verticalDims.$24),

            // Metadata Card
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (projectName.isNotEmpty) ...[
                  Text(
                    projectName,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Resources.colors.luxuryNavy,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$8),
                ],
                Text(
                  title,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: Resources.colors.luxuryBodyMuted,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: Resources.verticalDims.$24),

                // Technical Specs
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Resources.verticalDims.$16,
                    horizontal: Resources.verticalDims.$16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Resources.colors.luxuryBorder.withValues(alpha: 0.5),
                      ),
                      vertical: BorderSide(
                        color: Resources.colors.luxuryBorder.withValues(alpha: 0.5),
                      ),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Resources.radius.$r12),
                    boxShadow: AppShadows.card,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _WalkthroughSpecColumn(
                          title: loc.walkthroughTechnicalSpecsQuality,
                          value: loc.walkthrough4kResolution,
                        ),
                      ),
                      Container(
                        height: Resources.verticalDims.$10,
                        width: Resources.horizontalDims.$2,
                        color: Resources.colors.luxuryGoldBorder,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Expanded(
                        child: _WalkthroughSpecColumn(
                          title: loc.walkthroughTechnicalSpecsLength,
                          value: duration,
                        ),
                      ),
                      Container(
                        height: Resources.verticalDims.$10,
                        width: Resources.horizontalDims.$2,
                        color: Resources.colors.luxuryGoldBorder,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Expanded(
                        child: _WalkthroughSpecColumn(
                          title: loc.walkthroughTechnicalSpecsSize,
                          value: size,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Resources.verticalDims.$32),

                Text(
                  loc.walkthroughDescription,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: Resources.fontSizes.$18,
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$4),
                // Description
                Text(
                  walkthrough?.description ?? loc.walkthroughDefaultDescription,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: Resources.fontSizes.$14,
                    color: Resources.colors.luxuryBody,
                    height: Resources.lineHeights.$1_6,
                  ),
                ),
              ],
            ),

            if (previousVersions.isNotEmpty) ...[
              SizedBox(height: Resources.verticalDims.$40),
              Container(
                color: Resources.colors.luxuryBackground.withAlpha(240),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.walkthroughPreviousVersions,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontSize: Resources.fontSizes.$18,
                        fontWeight: Resources.fontWeights.semiBold,
                        color: Resources.colors.luxuryNavy,
                      ),
                    ),
                    ...previousVersions.map(
                      (v) => Padding(
                        padding: EdgeInsets.only(top: Resources.verticalDims.$16),
                        child: PreviousVersionCard(
                          version: v.version,
                          dateAndSize: v.dateAndSize,
                          onTap: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$32),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _WalkthroughSpecColumn extends StatelessWidget {
  const _WalkthroughSpecColumn({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: context.textTheme.labelSmall?.copyWith(
            color: Resources.colors.luxuryBodyMuted,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: Resources.fontSizes.$10,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Resources.verticalDims.$6),
        Text(
          value,
          style: context.textTheme.labelLarge?.copyWith(
            color: Resources.colors.luxuryNavy,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
