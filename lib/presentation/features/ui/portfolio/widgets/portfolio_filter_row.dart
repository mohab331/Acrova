import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_filter_chip.dart';
import 'package:acrova/utils/enums/portfolio_filter_enum.dart';
import 'package:flutter/material.dart';

class PortfolioFilterRow extends StatelessWidget {
  const PortfolioFilterRow({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final PortfolioFilter selected;
  final void Function(PortfolioFilter) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Resources.verticalDims.$32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: PortfolioFilter.values.length,
        separatorBuilder: (_, __) =>
            SizedBox(width: Resources.horizontalDims.$8),
        itemBuilder: (_, i) {
          final filter = PortfolioFilter.values[i];
          return FiltersChip(
            label: filter.localizedLabel(context),
            onTap: () => onSelect(filter),
            active: selected == filter,
          );
        },
      ),
    );
  }
}
