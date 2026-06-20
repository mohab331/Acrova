import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_status_chip.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/active_phase_badge.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/project_image.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedProjectCard extends StatelessWidget {
  const FeaturedProjectCard({required this.project, super.key});

  final ProjectModel project;

  bool get _showActiveBadge => !project.status.isTerminal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
        boxShadow: AppShadows.featuredCard,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ProjectImage(thumbnailUrl: project.thumbnailUrl, height: Resources.verticalDims.$192),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: Resources.verticalDims.$80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Resources.colors.luxuryInk.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),
              ),
              if (_showActiveBadge)
                Positioned(
                  top: Resources.verticalDims.$12,
                  right: Resources.horizontalDims.$12,
                  child: const ActivePhaseBadge(),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project.id,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: Resources.fontSizes.$12,
                        fontWeight: Resources.fontWeights.medium,
                        color: Resources.colors.luxuryBody,
                      ),
                    ),
                    AppStatusChip(status: project.status),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                Text(
                  project.name,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontSize: Resources.fontSizes.$20,
                    fontWeight: Resources.fontWeights.bold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$6),
                Text(
                  _buildDescription(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: Resources.fontSizes.$14,
                    color: Resources.colors.luxuryBody,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Resources.verticalDims.$20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.localization.projectsCompletion,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: Resources.fontSizes.$12,
                        color: Resources.colors.luxuryBody,
                      ),
                    ),
                    Text(
                      project.progressLabel,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontSize: Resources.fontSizes.$14,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryInk,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(Resources.radius.$r100),
                  child: LinearProgressIndicator(
                    value: project.progressRatio,
                    minHeight: 6,
                    backgroundColor: Resources.colors.luxuryProgressTrack,
                    valueColor: AlwaysStoppedAnimation(
                      Resources.colors.luxuryGoldLight,
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

  String _buildDescription() {
    final parts = <String>[];
    parts.add(project.type.displayLabel);
    if (project.location != null) parts.add(project.location!);
    return parts.join(' · ');
  }
}
