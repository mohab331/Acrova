import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_dot_separator.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_feature_chip.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_meta_dot.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_spec_grid.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class DetailContentPanel extends StatelessWidget {
  const DetailContentPanel({required this.item, super.key});

  final PortfolioItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Resources.radius.$r16)),
        boxShadow: AppShadows.sheet,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Resources.verticalDims.$12),
          Center(
            child: Container(
              width: Resources.horizontalDims.$50,
              height: Resources.verticalDims.$4,
              decoration: BoxDecoration(
                color: Resources.colors.luxuryInputBorder,
                borderRadius: BorderRadius.circular(Resources.radius.$r2),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(Resources.horizontalDims.$24, Resources.verticalDims.$24, Resources.horizontalDims.$24, Resources.verticalDims.$120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.style.toUpperCase(),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: Resources.fontSizes.$10,
                    fontWeight: Resources.fontWeights.extraBold,
                    color: Resources.colors.luxuryGoldLight,
                    letterSpacing: Resources.letterSpacing.$1_2,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$8),
                Text(
                  item.title,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: Resources.fontSizes.$18,
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                    height: Resources.lineHeights.$1_25,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$8),
                Row(
                  children: [
                    DetailMetaDot(text: item.location),
                    const DetailDotSeparator(),
                    DetailMetaDot(text: item.area),
                    const DetailDotSeparator(),
                    DetailMetaDot(text: item.floors),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$32),
                Text(
                  l10n.portfolioNarrative,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: Resources.fontSizes.$18,
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$12),
                Text(
                  item.narrative,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: Resources.fontSizes.$14,
                    color: Resources.colors.luxuryBody,
                    height: Resources.lineHeights.$1_6,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$32),
                Text(
                  l10n.portfolioSpecifications,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: Resources.fontSizes.$18,
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$16),
                DetailSpecGrid(item: item),
                SizedBox(height: Resources.verticalDims.$24),
                Text(
                  l10n.portfolioKeyFeatures,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: Resources.fontSizes.$18,
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$12),
                Wrap(
                  spacing: Resources.horizontalDims.$8,
                  runSpacing: Resources.verticalDims.$8,
                  children: item.features
                      .map((f) => DetailFeatureChip(label: f))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
