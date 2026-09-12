import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_filter_chip.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class PortfolioFilterRow extends StatelessWidget {
  const PortfolioFilterRow({
    required this.selected,
    required this.onSelect,
    required this.filters,
    super.key,
  });

  final String? selected;
  final void Function(String) onSelect;
  final List<String> filters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Resources.verticalDims.$32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) =>
            SizedBox(width: Resources.horizontalDims.$8),
        itemBuilder: (_, i) {
          final filter = filters[i];
          if (filter == 'all') {
            return FiltersChip(
              label: context.localization.filterAll,
              onTap: () => onSelect(filter),
              active: selected == filter,
            );
          }
          return FiltersChip(
            label: filter,
            onTap: () => onSelect(filter),
            active: selected == filter,
          );
        },
      ),
    );
  }
}
