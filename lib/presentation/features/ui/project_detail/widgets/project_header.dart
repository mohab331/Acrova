import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_status_chip.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_dot_separator.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_meta_dot.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectHeader extends StatelessWidget {
  const ProjectHeader({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              project.type.name.toUpperCase() ?? '',
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: Resources.fontSizes.$10,
                fontWeight: Resources.fontWeights.extraBold,
                color: Resources.colors.luxuryGoldLight,
                letterSpacing: Resources.letterSpacing.$1_2,
              ),
            ),
            AppStatusChip(status: project.status),
          ],
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Text(
          project.name,
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: Resources.fontSizes.$18,
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
            height: Resources.lineHeights.$1_25,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Resources.horizontalDims.$6,
          children: [
            Image.asset(
              Resources.drawables.location,
              height: Resources.verticalDims.$16,
              color: Resources.colors.luxuryBodyMuted,
            ),
            DetailMetaDot(text: '${project.location?.toUpperCase()}'),
          ],
        ),
      ],
    );
  }
}
