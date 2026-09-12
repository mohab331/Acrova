import 'package:acrova/data/models/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardDesignCard extends StatelessWidget {
  const DashboardDesignCard({
    required this.height,
    required this.portfolioItem,
    super.key,
  });

  final double height;
  final PortfolioItem? portfolioItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          AppRouteEnum.portfolioDetailPage.name,
          extra: portfolioItem,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
        child: Stack(
          children: [
            SizedBox(
              height: height.h,
              width: double.infinity,
              child: AppCachedNetworkImage(
                imageUrl: portfolioItem?.imageUrls?.firstOrNull ?? '',
                radius: Resources.radius.$r12,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppGradients.designCardOverlay,
                    stops: [0.4, 1.0],
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
                    portfolioItem?.style?.toUpperCase() ?? '',
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: Resources.fontSizes.$8,
                      fontWeight: Resources.fontWeights.extraBold,
                      letterSpacing: Resources.letterSpacing.$1_2,
                      color: Resources.colors.luxuryGoldLight,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$3),
                  Text(
                    portfolioItem?.title ?? '',
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
