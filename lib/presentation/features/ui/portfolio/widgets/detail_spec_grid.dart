import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_spec_cell.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class DetailSpecGrid extends StatelessWidget {
  const DetailSpecGrid({required this.item, super.key});

  final PortfolioItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final specs = [
      (l10n.specArea, item.area),
      (l10n.specFloors, item.floors),
      (l10n.specStyle, item.style),
      (l10n.specLocation, item.location),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: Resources.horizontalDims.$12,
      mainAxisSpacing: Resources.verticalDims.$12,
      childAspectRatio: AppAspectRatios.card2x4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: specs
          .map((s) => DetailSpecCell(label: s.$1, value: s.$2))
          .toList(),
    );
  }
}
