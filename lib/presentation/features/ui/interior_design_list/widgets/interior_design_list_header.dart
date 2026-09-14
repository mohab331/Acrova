import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_filter_chip.dart';
import 'package:acrova/utils/enums/interior_design_filter_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class InteriorDesignListHeader extends StatelessWidget {
  const InteriorDesignListHeader({
    required this.filter,
    required this.onFilterChanged,
    super.key,
  });

  final InteriorDesignFilter filter;
  final ValueChanged<InteriorDesignFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.interiorDesignListTitle,
          style: context.textTheme.titleMedium?.copyWith(
            color: Resources.colors.luxuryNavy,
            fontWeight: Resources.fontWeights.semiBold,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$4),
        Text(
          loc.portfolioExploreSubtitle,
          style: context.textTheme.labelMedium?.copyWith(
            color: Resources.colors.luxuryBodyMuted,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$20),
        Row(
          children: [
            FiltersChip(
              label: loc.filterAll,
              active: filter == InteriorDesignFilter.all,
              onTap: () => onFilterChanged(InteriorDesignFilter.all),
            ),
            SizedBox(width: Resources.horizontalDims.$8),
            FiltersChip(
              label: loc.projectsFilterActive,
              active: filter == InteriorDesignFilter.active,
              onTap: () => onFilterChanged(InteriorDesignFilter.active),
            ),
            SizedBox(width: Resources.horizontalDims.$8),
            FiltersChip(
              label: loc.completed,
              active: filter == InteriorDesignFilter.completed,
              onTap: () => onFilterChanged(InteriorDesignFilter.completed),
            ),
          ],
        ),
      ],
    );
  }
}
