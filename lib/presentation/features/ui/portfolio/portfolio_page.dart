import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/ui/dashboard/dashboard_page.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../projects/projects_page.dart';

enum _Filter { all, exterior, modern, traditional, interior }

extension _FilterLabel on _Filter {
  String label(BuildContext context) => switch (this) {
    _Filter.all => context.localization.filterAll,
    _Filter.exterior => context.localization.filterExterior,
    _Filter.modern => context.localization.filterModern,
    _Filter.traditional => context.localization.filterTraditional,
    _Filter.interior => context.localization.filterInterior,
  };
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  _Filter _filter = _Filter.all;

  List<PortfolioItem> get _filtered {
    if (_filter == _Filter.all) return PortfolioItem.mockItems;
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
                    'Explore Our Portfolio',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Resources.colors.luxuryNavy,
                      fontWeight: Resources.fontWeights.semiBold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Discover a curated collection of premium architectural designs, luxury interiors, and signature development experiences.',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Resources.colors.luxuryBodyMuted,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _FilterRow(
                    selected: _filter,
                    onSelect: (f) => setState(() => _filter = f),
                  ),
                  SizedBox(height: 20.h),
                  if (items.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 80.h),
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
                    _HeroCard(
                      item: items.first,
                      onTap: () => _openDetail(items.first),
                    ),
                    if (items.length > 1) ...[
                      SizedBox(height: 20.h),
                      _GalleryGrid(
                        items: items.skip(1).toList(),
                        onTap: _openDetail,
                      ),
                    ],
                  ],
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.selected, required this.onSelect});

  final _Filter selected;
  final void Function(_Filter) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _Filter.values.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (_, i) {
          final filter = _Filter.values[i];
          final isActive = selected == filter;
          return FiltersChip(
            label: filter.label(context),
            onTap: () => onSelect(filter),
            active: isActive,
          );
        },
      ),
    );
  }
}

// ── Hero card ──────────────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.item, required this.onTap});

  final PortfolioItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        child: SizedBox(
          height: 200.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppCachedNetworkImage(
                imageUrl: item.imageUrls.first,
                fit: BoxFit.cover,
                radius: Resources.radius.$r2,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xE6000615), // 90%
                      Color(0x66000615), // 40%
                      Color(0x00000615), // 0%
                    ],
                    stops: [0.0, 0.45, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(20.r),
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
                      SizedBox(height: 4.h),
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

// ── Grid ───────────────────────────────────────────────────────────────────────

class _GalleryGrid extends StatelessWidget {
  const _GalleryGrid({required this.items, required this.onTap});

  final List<PortfolioItem> items;
  final void Function(PortfolioItem) onTap;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += 2) {
      final left = items[i];
      final right = i + 1 < items.length ? items[i + 1] : null;
      if (rows.isNotEmpty) rows.add(SizedBox(height: 12.h));
      rows.add(
        Row(
          children: [
            Expanded(
              child: _GridCard(item: left, onTap: () => onTap(left)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: right != null
                  ? _GridCard(item: right, onTap: () => onTap(right))
                  : const SizedBox(),
            ),
          ],
        ),
      );
    }
    return Column(children: rows);
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard({required this.item, required this.onTap});

  final PortfolioItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppCachedNetworkImage(
                imageUrl: item.imageUrls.first,
                fit: BoxFit.cover,
                radius: Resources.radius.$r8,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xCC000615), // 80%
                      Color(0x33000615), // 20%
                      Color(0x00000615),
                    ],
                    stops: [0.0, 0.4, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.style.toUpperCase(),
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: Resources.fontSizes.$8,
                          fontWeight: Resources.fontWeights.extraBold,
                          color: Resources.colors.luxuryGoldOnDark,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: Resources.fontSizes.$14,
                          fontWeight: Resources.fontWeights.semiBold,
                          color: Resources.colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
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
