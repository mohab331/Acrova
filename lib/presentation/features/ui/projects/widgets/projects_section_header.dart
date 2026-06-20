import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_filter_chip.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ProjectFilter { all, active, completed }

class ProjectsSectionHeader extends StatelessWidget {
  const ProjectsSectionHeader({
    required this.filter,
    required this.onFilterChanged,
    super.key,
  });

  final ProjectFilter filter;
  final ValueChanged<ProjectFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.projectsPageTitle,
          style: context.textTheme.titleMedium?.copyWith(
            color: Resources.colors.luxuryNavy,
            fontWeight: Resources.fontWeights.semiBold,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$4),
        Text(
          loc.projectsPageSubtitle,
          style: context.textTheme.labelMedium?.copyWith(
            color: Resources.colors.luxuryBodyMuted,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$20),
        Row(
          children: [
            FiltersChip(
              label: loc.filterAll,
              active: filter == ProjectFilter.all,
              onTap: () => onFilterChanged(ProjectFilter.all),
            ),
            SizedBox(width: Resources.horizontalDims.$8),
            FiltersChip(
              label: loc.projectsFilterActive,
              active: filter == ProjectFilter.active,
              onTap: () => onFilterChanged(ProjectFilter.active),
            ),
            SizedBox(width: Resources.horizontalDims.$8),
            FiltersChip(
              label: loc.completed,
              active: filter == ProjectFilter.completed,
              onTap: () => onFilterChanged(ProjectFilter.completed),
            ),
          ],
        ),
      ],
    );
  }
}
