import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_item.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PortfolioHeroCard extends StatelessWidget {
  const PortfolioHeroCard({
    required this.item,
    required this.onTap,
    super.key,
  });

  final PortfolioItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        child: SizedBox(
          height: Resources.verticalDims.$200,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppCachedNetworkImage(
                imageUrl: item.imageUrls.first,
                fit: BoxFit.cover,
                radius: Resources.radius.$r2,
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppGradients.heroCardOverlay,
                    stops: [0.0, 0.45, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(Resources.horizontalDims.$20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.style.toUpperCase(),
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: Resources.fontSizes.$10,
                          fontWeight: Resources.fontWeights.extraBold,
                          color: Resources.colors.luxuryGoldOnDark,
                          letterSpacing: Resources.letterSpacing.$1_2,
                        ),
                      ),
                      SizedBox(height: Resources.verticalDims.$4),
                      Text(
                        item.title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: Resources.fontSizes.$18,
                          fontWeight: Resources.fontWeights.semiBold,
                          color: Resources.colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
