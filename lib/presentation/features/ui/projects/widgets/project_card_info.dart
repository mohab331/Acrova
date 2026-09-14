import 'package:acrova/data/models/response/project/project_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_status_chip.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectCardInfo extends StatelessWidget {
  const ProjectCardInfo({required this.project, super.key});

  final ProjectResponseModel project;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              project.id ?? '',
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: Resources.fontSizes.$10,
                fontWeight: Resources.fontWeights.medium,
                color: Resources.colors.luxuryBodyMuted,
                letterSpacing: Resources.letterSpacing.$1_0,
              ),
            ),
            AppStatusChip(status: project.status),
          ],
        ),
        SizedBox(height: Resources.verticalDims.$10),
        _ProjectNameWithDescription(project: project),
        SizedBox(height: Resources.verticalDims.$16),
        Divider(height: 1, color: Resources.colors.luxuryBorder),
        SizedBox(height: Resources.verticalDims.$12),
        _ProjectProgressSection(project: project),
      ],
    );
  }
}

class _ProjectProgressSection extends StatelessWidget {
  const _ProjectProgressSection({required this.project, super.key});

  final ProjectResponseModel project;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                color: Resources.colors.luxuryGoldLight,
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
    );
  }
}

class _ProjectNameWithDescription extends StatelessWidget {
  const _ProjectNameWithDescription({required this.project, super.key});

  final ProjectResponseModel project;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          project.name ?? '',
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: Resources.fontSizes.$16,
            fontWeight: Resources.fontWeights.bold,
            color: Resources.colors.luxuryInk,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: Resources.verticalDims.$6),
        Text(
          _buildDescription(context),
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: Resources.fontSizes.$12,
            color: Resources.colors.luxuryBody,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _buildDescription(BuildContext context) {
    final parts = <String>[];
    parts.add(project.type?.localizedLabel(context) ?? '');
    if (project.location != null) parts.add(project.location!);
    return parts.join(' · ');
  }
}
