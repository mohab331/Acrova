import 'package:acrova/data/models/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_design_card.dart';
import 'package:flutter/material.dart';

class DashboardDesignGallery extends StatelessWidget {
  const DashboardDesignGallery({required this.portfolioItems, super.key});

  final List<PortfolioItem>? portfolioItems;
  @override
  Widget build(BuildContext context) {
    final portfolios = portfolioItems ?? [];
    final featured = portfolios.firstOrNull;
    final rest = portfolios.skip(1).toList();

    return Column(
      children: [
        DashboardDesignCard(portfolioItem: featured, height: 170),
        if (rest.isNotEmpty) ...[
          SizedBox(height: Resources.verticalDims.$12),
          Row(
            children: rest
                .take(2)
                .map(
                  (d) => Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: d == rest.first && rest.length > 1
                            ? Resources.horizontalDims.$6
                            : 0,
                        start: d != rest.first
                            ? Resources.horizontalDims.$6
                            : 0,
                      ),
                      child: DashboardDesignCard(portfolioItem: d, height: 140),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}
