import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RelatedInteriorDesignCard extends StatelessWidget {
  const RelatedInteriorDesignCard({
    required this.interiorDesignId,
    super.key,
  });

  final String interiorDesignId;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.relatedInteriorDesign,
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: Resources.fontSizes.$18,
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$12),
        GestureDetector(
          onTap: () {
            context.push(
              AppRouteEnum.interiorDesignDetailPage.path,
              extra: InteriorDesignDetailArgs(id: interiorDesignId),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Resources.colors.luxurySurface,
              borderRadius: BorderRadius.circular(Resources.radius.$r8),
              border: Border.all(color: Resources.colors.luxuryBorder),
              boxShadow: AppShadows.card,
            ),
            padding: EdgeInsets.all(Resources.horizontalDims.$16),
            child: Row(
              children: [
                Container(
                  width: Resources.horizontalDims.$48,
                  height: Resources.verticalDims.$48,
                  decoration: BoxDecoration(
                    color: Resources.colors.luxuryInputBg,
                    borderRadius: BorderRadius.circular(Resources.radius.$r4),
                    border: Border.all(color: Resources.colors.luxuryGoldBorder),
                  ),
                  child: Icon(
                    Icons.chair_outlined,
                    color: Resources.colors.luxuryGoldLight,
                    size: Resources.fontSizes.$24,
                  ),
                ),
                SizedBox(width: Resources.horizontalDims.$12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.interiorDesignTitle,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: Resources.fontSizes.$14,
                          fontWeight: Resources.fontWeights.bold,
                          color: Resources.colors.luxuryInk,
                        ),
                      ),
                      SizedBox(height: Resources.verticalDims.$4),
                      Text(
                        loc.viewInteriorDesign,
                        style: TextStyle(
                          fontSize: Resources.fontSizes.$12,
                          fontWeight: Resources.fontWeights.semiBold,
                          color: Resources.colors.luxuryGoldLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: Resources.fontSizes.$14,
                  color: Resources.colors.luxuryGoldLight,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
