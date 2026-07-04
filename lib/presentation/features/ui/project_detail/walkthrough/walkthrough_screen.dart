import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:flutter/material.dart';

import 'widgets/previous_version_card.dart';
import 'widgets/walkthrough_video_player.dart';

class WalkthroughScreen extends StatelessWidget {
  const WalkthroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomPadding: 0,
      appBar: const AppAuthBrandHeader(
        label: 'Walkthrough',
        showBack: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$20,
            vertical: Resources.verticalDims.$24,
          ),
          decoration: BoxDecoration(
            color: Resources.colors.luxurySurface.withOpacity(0.9),
            border: Border(
              top: BorderSide(
                color: Resources.colors.luxuryBorder.withOpacity(0.5),
              ),
            ),
          ),
          child: AppPrimaryButton(
            label: 'DOWNLOAD WALKTHROUGH',
            icon: Icon(
              Icons.download_rounded,
              color: Resources.colors.white,
              size: Resources.fontSizes.$20,
            ),
            onPressed: () {
              DownloadHelper.downloadAndShare(
                'https://samplelib.com/mp4/sample-5s.mp4',
                'Walkthrough_v1.2.mp4',
              );
            },
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video Section
            const WalkthroughVideoPlayer(
              videoUrl: 'https://samplelib.com/mp4/sample-5s.mp4', thumbnailUrl: 'https://img.magnific.com/free-photo/high-angle-shot-beautiful-cityscape-sunset-new-york-city-usa_181624-42898.jpg?semt=ais_hybrid&w=740&q=80',
            ),
            
            SizedBox(height: Resources.verticalDims.$32),
            
            // Project Metadata
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Al-Rashidi Residence',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Resources.colors.luxuryNavy,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$8),
                Text(
                  'Walkthrough v1.2',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: Resources.colors.luxuryBodyMuted,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: Resources.verticalDims.$24),

                // Technical Specs
                Container(
                  padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$16,horizontal: Resources.verticalDims.$16),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Resources.colors.luxuryBorder.withOpacity(0.5),
                      ),
                      vertical:BorderSide(
                        color: Resources.colors.luxuryBorder.withOpacity(0.5),
                      )
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Resources.radius.$r12),
                    boxShadow: AppShadows.card
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildSpecColumn('QUALITY', '4K Resolution', context)),
                      Container(height: Resources.verticalDims.$10,width: Resources.horizontalDims.$2,color: Resources.colors.luxuryGoldBorder,margin: const EdgeInsets.symmetric(horizontal: 10),),
                      Expanded(child: _buildSpecColumn('LENGTH', '02:45 m', context)),
                      Container(height: Resources.verticalDims.$10,width: Resources.horizontalDims.$2,color: Resources.colors.luxuryGoldBorder,margin: const EdgeInsets.symmetric(horizontal: 10),),
                      Expanded(child: _buildSpecColumn('SIZE', '124 MB', context)),
                    ],
                  ),
                ),

                SizedBox(height: Resources.verticalDims.$32),

                Text('Description',style: context.textTheme.labelLarge?.copyWith(
                  fontSize: Resources.fontSizes.$18,
                  fontWeight: Resources.fontWeights.semiBold,
                  color: Resources.colors.luxuryNavy,
                ),),
                SizedBox(height: Resources.verticalDims.$4),
                // Description
                Text(
                  'Experience the seamless architectural flow of the Al-Rashidi estate. This updated render captures the intricate interplay of shadow and light across the travertine halls during the golden hour, highlighting the newly integrated water feature and custom millwork.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: Resources.fontSizes.$14,
                    color: Resources.colors.luxuryBody,
                    height: Resources.lineHeights.$1_6,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: Resources.verticalDims.$40),
            
            // Previous Versions
            Container(
              color: Resources.colors.luxuryBackground.withAlpha(240),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Previous Versions',
                    style: context.textTheme.labelLarge?.copyWith(
                      fontSize: Resources.fontSizes.$18,
                      fontWeight: Resources.fontWeights.semiBold,
                      color: Resources.colors.luxuryNavy,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$16),
                  PreviousVersionCard(
                    version: 'Walkthrough v1.1',
                    dateAndSize: 'Oct 24, 2023 • 118 MB',
                    onTap: () {},
                  ),
                  SizedBox(height: Resources.verticalDims.$16),
                  PreviousVersionCard(
                    version: 'Walkthrough v1.0',
                    dateAndSize: 'Oct 12, 2023 • 112 MB',
                    onTap: () {},
                  ),
                  SizedBox(height: Resources.verticalDims.$32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecColumn(String title, String value, BuildContext context) {
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
