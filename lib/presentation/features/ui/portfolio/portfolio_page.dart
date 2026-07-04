import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_avatar_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/portfolio_filter_row.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/portfolio_gallery_grid.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/portfolio_hero_card.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  PortfolioFilter _filter = PortfolioFilter.all;

  List<PortfolioItem> get _filtered {
    if (_filter == PortfolioFilter.all) return PortfolioItem.mockItems;
    return PortfolioItem.mockItems
        .where((i) => i.category == _filter.name)
        .toList();
  }

  void _openDetail(PortfolioItem item) {
    context.pushNamed(AppRouteEnum.portfolioDetailPage.name, extra: item);
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return CommonScreen(
      bottomPadding: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AvatarHeader(userName: 'Mohab', notificationCount: 2),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.localization.portfolioExploreTitle,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Resources.colors.luxuryNavy,
                      fontWeight: Resources.fontWeights.semiBold,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    context.localization.portfolioExploreSubtitle,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Resources.colors.luxuryBodyMuted,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$20),
                  PortfolioFilterRow(
                    selected: _filter,
                    onSelect: (f) => setState(() => _filter = f),
                  ),
                  SizedBox(height: Resources.verticalDims.$20),
                  if (items.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: Resources.verticalDims.$80),
                      child: Center(
                        child: Text(
                          context.localization.noDesignsCategory,
                          style: TextStyle(
                            fontSize: Resources.fontSizes.$14,
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                        ),
                      ),
                    )
                  else ...[
                    PortfolioHeroCard(
                      item: items.first,
                      onTap: () => _openDetail(items.first),
                    ),
                    if (items.length > 1) ...[
                      SizedBox(height: Resources.verticalDims.$20),
                      PortfolioGalleryGrid(
                        items: items.skip(1).toList(),
                        onTap: _openDetail,
                      ),
                    ],
                  ],
                  SizedBox(height: Resources.verticalDims.$32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
