import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RelatedProjectCard extends StatelessWidget {
  const RelatedProjectCard({
    required this.projectId,
    this.projectName,
    this.projectThumbnailUrl,
    super.key,
  });

  final String projectId;
  final String? projectName;
  final String? projectThumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.relatedProject,
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: Resources.fontSizes.$18,
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$12),
        GestureDetector(
          onTap: () {
            context.push(
              AppRouteEnum.projectDetailPage.path,
              extra: ProjectDetailArgs(
                id: projectId,
                title: projectName,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Resources.colors.luxurySurface,
              borderRadius: BorderRadius.circular(Resources.radius.$r8),
              border: Border.all(color: Resources.colors.luxuryBorder),
              boxShadow: AppShadows.card,
            ),
            padding: EdgeInsets.all(Resources.horizontalDims.$12),
            child: Row(
              children: [
                _ProjectThumbnail(thumbnailUrl: projectThumbnailUrl),
                SizedBox(width: Resources.horizontalDims.$12),
                Expanded(
                  child: _ProjectInfo(
                    projectName: projectName ?? projectId,
                    viewLabel: loc.viewProject,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: Resources.fontSizes.$14,
                  color: Resources.colors.luxuryGoldLight,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProjectThumbnail extends StatelessWidget {
  const _ProjectThumbnail({this.thumbnailUrl});

  final String? thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Resources.radius.$r4),
      child: SizedBox(
        width: Resources.horizontalDims.$64,
        height: Resources.verticalDims.$64,
        child: AppCachedNetworkImage(
          imageUrl: thumbnailUrl ?? '',
          width: Resources.horizontalDims.$64,
          height: Resources.verticalDims.$64,
          radius: Resources.radius.$r4,
        ),
      ),
    );
  }
}

class _ProjectInfo extends StatelessWidget {
  const _ProjectInfo({
    required this.projectName,
    required this.viewLabel,
  });

  final String projectName;
  final String viewLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          projectName,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: Resources.fontSizes.$14,
            fontWeight: Resources.fontWeights.bold,
            color: Resources.colors.luxuryInk,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: Resources.verticalDims.$4),
        Row(
          children: [
            Text(
              viewLabel,
              style: TextStyle(
                fontSize: Resources.fontSizes.$12,
                fontWeight: Resources.fontWeights.semiBold,
                color: Resources.colors.luxuryGoldLight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
