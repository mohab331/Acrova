import 'package:acrova/data/models/project/engineer_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectEngineerCard extends StatelessWidget {
  const ProjectEngineerCard({this.engineer, super.key});

  final EngineerModel? engineer;

  @override
  Widget build(BuildContext context) {
    final eng = engineer;
    if (eng == null) return const SizedBox.shrink();
    final name = eng.name;
    final role = eng.role;
    final avatarUrl = eng.avatarUrl;

    return Container(
      padding: EdgeInsets.all(Resources.squareDims.$20),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        border: Border.all(color: Resources.colors.luxuryBorder),
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            width: Resources.squareDims.$56,
            height: Resources.squareDims.$56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Center(
              child: (avatarUrl != null && avatarUrl.isNotEmpty)
                  ? AppCachedNetworkImage(imageUrl: avatarUrl)
                  : Icon(
                      Icons.person,
                      color: Resources.colors.luxuryGold,
                      size: Resources.fontSizes.$28,
                    ),
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Resources.colors.luxuryNavy,
                    fontWeight: Resources.fontWeights.bold,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$4),
                Text(
                  role,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Resources.colors.luxuryBodyMuted,
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
