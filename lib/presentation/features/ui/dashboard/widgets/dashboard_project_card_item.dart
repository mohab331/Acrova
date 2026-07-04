import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/cards/app_card.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_status_chip.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class DashboardProjectCardItem extends StatelessWidget {
  const DashboardProjectCardItem({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Resources.squareDims.$56,
            height: Resources.squareDims.$56,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryNavy,
              borderRadius: BorderRadius.circular(Resources.radius.$r8),
            ),
            child: AppCachedNetworkImage(imageUrl: project.thumbnailUrl ?? ''),
          ),
          SizedBox(width: Resources.horizontalDims.$12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        project.name,
                        style: context.textTheme.titleSmall?.copyWith(
                          color: Resources.colors.luxuryInk,
                          fontWeight: Resources.fontWeights.semiBold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: Resources.horizontalDims.$8),
                    AppStatusChip(status: project.status),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$4),
                Text(
                  project.id,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: Resources.fontSizes.$10,
                    fontWeight: Resources.fontWeights.medium,
                    letterSpacing: Resources.letterSpacing.$n0_4,
                    color: Resources.colors.luxuryBody,
                  ),
                ),
                if (project.location != null) ...[
                  SizedBox(height: Resources.verticalDims.$2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: Resources.iconSizes.$14,
                        color: Resources.colors.luxuryBodyMuted,
                      ),
                      SizedBox(width: Resources.horizontalDims.$2),
                      Expanded(
                        child: Text(
                          project.location!,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: Resources.fontSizes.$10,
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: Resources.verticalDims.$12),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Resources.radius.$r4),
                        child: LinearProgressIndicator(
                          value: project.progressRatio,
                          backgroundColor: Resources.colors.luxuryProgressTrack,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Resources.colors.luxuryGoldLight,
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ),
                    SizedBox(width: Resources.horizontalDims.$8),
                    Text(
                      project.progressLabel,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: Resources.fontSizes.$10,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryGoldLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
