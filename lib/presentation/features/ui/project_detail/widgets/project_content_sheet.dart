import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_action_card.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_engineer_card.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_header.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_progress_card.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_provisions_list.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_specs_grid.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_timeline.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectContentSheet extends StatelessWidget {
  const ProjectContentSheet({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Resources.radius.$r16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Resources.verticalDims.$12),
          Center(
            child: Container(
              width: Resources.horizontalDims.$50,
              height: Resources.verticalDims.$4,
              decoration: BoxDecoration(
                color: Resources.colors.luxuryInputBorder,
                borderRadius: BorderRadius.circular(Resources.radius.$r2),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.directional(
              start: Resources.horizontalDims.$24,
              top: Resources.verticalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: ProjectHeader(project: project),
          ),
          SizedBox(height: Resources.verticalDims.$32),
          // Overview Section
          Padding(
            padding: EdgeInsetsGeometry.directional(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: Text(
              'Overview',
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: Resources.fontSizes.$18,
                fontWeight: Resources.fontWeights.semiBold,
                color: Resources.colors.luxuryNavy,
              ),
            ),
          ),
          SizedBox(height: Resources.verticalDims.$12),
          Padding(
            padding: EdgeInsetsGeometry.directional(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: Text(
              'An exceptional contemporary residence blending minimalist lines with premium materials. Designed to maximize natural light while maintaining absolute privacy.',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: Resources.fontSizes.$14,
                color: Resources.colors.luxuryBody,
                height: Resources.lineHeights.$1_6,
              ),
            ),
          ),
          SizedBox(height: Resources.verticalDims.$32),
          Padding(
            padding: EdgeInsetsGeometry.directional(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: Text(
              context.localization.portfolioSpecifications,
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: Resources.fontSizes.$18,
                fontWeight: Resources.fontWeights.semiBold,
                color: Resources.colors.luxuryNavy,
              ),
            ),
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Padding(
            padding: EdgeInsetsGeometry.directional(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: ProjectSpecsGrid(project: project),
          ),
          SizedBox(height: Resources.verticalDims.$32),
          Padding(
            padding: EdgeInsetsGeometry.directional(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: ProjectProgressCard(project: project),
          ),
          SizedBox(height: Resources.verticalDims.$32),

          Padding(
            padding: EdgeInsetsGeometry.directional(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: ProjectActionCard(project: project),
          ),
          if (project.status == ProjectStatus.awaitingEngineering) ...[
            SizedBox(height: Resources.verticalDims.$32),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                start: Resources.horizontalDims.$24,
                end: Resources.horizontalDims.$24,
              ),
              child: const ProjectEngineerCard(),
            ),
          ],
          SizedBox(height: Resources.verticalDims.$32),

          Padding(
            padding: EdgeInsetsGeometry.directional(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: const ProjectProvisionsList(),
          ),
        ],
      ),
    );
  }
}
