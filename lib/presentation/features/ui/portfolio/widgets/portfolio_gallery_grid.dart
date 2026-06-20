import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/portfolio_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PortfolioGalleryGrid extends StatelessWidget {
  const PortfolioGalleryGrid({
    required this.items,
    required this.onTap,
    super.key,
  });

  final List<PortfolioItem> items;
  final void Function(PortfolioItem) onTap;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += 2) {
      final left = items[i];
      final right = i + 1 < items.length ? items[i + 1] : null;
      if (rows.isNotEmpty) rows.add(SizedBox(height: Resources.verticalDims.$12));
      rows.add(
        Row(
          children: [
            Expanded(child: PortfolioGridCard(item: left, onTap: () => onTap(left))),
            SizedBox(width: Resources.horizontalDims.$12),
            Expanded(
              child: right != null
                  ? PortfolioGridCard(item: right, onTap: () => onTap(right))
                  : const SizedBox(),
            ),
          ],
        ),
      );
    }
    return Column(children: rows);
  }
}
