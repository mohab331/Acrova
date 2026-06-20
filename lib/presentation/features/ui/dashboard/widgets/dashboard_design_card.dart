import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_design_card_placeholder.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardDesignCard extends StatelessWidget {
  const DashboardDesignCard({
    required this.design,
    required this.height,
    super.key,
  });

  final DesignModel design;
  final double height;

  @override
  Widget build(BuildContext context) {
    final hasAsset = design.imageAsset != null;
    final hasUrl = design.imageUrl != null;

    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
        child: Stack(
          children: [
            SizedBox(
              height: height.h,
              width: double.infinity,
              child: hasAsset
                  ? Image.asset(
                      design.imageAsset!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          DashboardDesignCardPlaceholder(height: height),
                    )
                  : hasUrl
                      ? AppCachedNetworkImage(
                          imageUrl: design.imageUrl!,
                          fit: BoxFit.cover,
                          radius: Resources.radius.$r12,
                        )
                      : DashboardDesignCardPlaceholder(height: height),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppGradients.designCardOverlay,
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: Resources.verticalDims.$12,
              left: Resources.horizontalDims.$12,
              right: Resources.horizontalDims.$12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    design.styleTag.toUpperCase(),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: Resources.fontSizes.$8,
                      fontWeight: Resources.fontWeights.extraBold,
                      letterSpacing: Resources.letterSpacing.$1_2,
                      color: Resources.colors.luxuryGoldLight,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$3),
                  Text(
                    design.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: Resources.fontSizes.$14,
                      fontWeight: Resources.fontWeights.semiBold,
                      color: Resources.colors.luxurySurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
