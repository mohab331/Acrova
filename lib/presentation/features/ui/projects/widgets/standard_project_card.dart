import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_status_chip.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/project_image.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class StandardProjectCard extends StatelessWidget {
  const StandardProjectCard({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectImage(thumbnailUrl: project.thumbnailUrl, height: Resources.verticalDims.$160),
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project.id,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: Resources.fontSizes.$10,
                        fontWeight: Resources.fontWeights.medium,
                        color: Resources.colors.luxuryBodyMuted,
                      ),
                    ),
                    AppStatusChip(status: project.status),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$6),
                Text(
                  project.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: Resources.fontSizes.$16,
                    fontWeight: Resources.fontWeights.bold,
                    color: Resources.colors.luxuryInk,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$4),
                Text(
                  project.type.displayLabel,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: Resources.fontSizes.$12,
                    color: Resources.colors.luxuryBody,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Resources.verticalDims.$16),
                Divider(height: 1, color: Resources.colors.luxuryBorder),
                SizedBox(height: Resources.verticalDims.$12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.localization.projectsCompletion,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: Resources.fontSizes.$10,
                        color: Resources.colors.luxuryInk,
                      ),
                    ),
                    Text(
                      project.progressLabel,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontSize: Resources.fontSizes.$14,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryGold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Resources.radius.$r100),
                  child: LinearProgressIndicator(
                    value: project.progressRatio,
                    minHeight: 4,
                    backgroundColor: Resources.colors.luxuryProgressTrack,
                    valueColor: AlwaysStoppedAnimation(
                      Resources.colors.luxuryGold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
