import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectEngineerCard extends StatelessWidget {
  const ProjectEngineerCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: const Center(
              child: AppCachedNetworkImage(
                imageUrl: 'https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png',
              ),
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eng. Abdullah Al-Rashid',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Resources.colors.luxuryNavy,
                    fontWeight: Resources.fontWeights.bold,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$4),
                Text(
                  'Lead Structural Engineer',
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
