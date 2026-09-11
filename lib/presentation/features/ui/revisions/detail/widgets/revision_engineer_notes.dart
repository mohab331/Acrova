import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class RevisionEngineerNotes extends StatelessWidget {
  const RevisionEngineerNotes({required this.revision, super.key});

  final RevisionModel revision;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$24),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryInputBg,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.revisionDetailEngineerNotes.toUpperCase(),
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$10,
              fontWeight: Resources.fontWeights.bold,
              letterSpacing: Resources.letterSpacing.$1_0,
              color: Resources.colors.luxuryBodyMuted,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$20),
          Row(
            children: [
              Container(
                width: Resources.squareDims.$48,
                height: Resources.squareDims.$48,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Resources.colors.luxuryProgressTrack,
                  border: Border.all(
                    color: Resources.colors.luxurySurface,
                    width: AppBorderWidths.$2,
                  ),
                ),
                child: revision.engineerAvatarUrl != null
                    ? AppCachedNetworkImage(
                        imageUrl: revision.engineerAvatarUrl!)
                    : Icon(
                        Icons.engineering_outlined,
                        size: Resources.iconSizes.$24,
                        color: Resources.colors.luxuryBodyMuted,
                      ),
              ),
              SizedBox(width: Resources.horizontalDims.$16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      revision.engineerName ?? '',
                      style: TextStyle(
                        fontFamily: Resources.fonts.manrope,
                        fontSize: Resources.fontSizes.$16,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryNavy,
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$2),
                    Text(
                      revision.engineerRole ?? '',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: Resources.fontSizes.$14,
                        color: Resources.colors.luxuryBodyMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$20),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppBorderWidths.$2,
                  color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.4),
                ),
                SizedBox(width: Resources.horizontalDims.$16),
                Expanded(
                  child: Text(
                    revision.engineerNote ?? '',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: Resources.fontSizes.$15,
                      color: Resources.colors.luxuryBody,
                      height: Resources.lineHeights.$1_5,
                      fontStyle: FontStyle.italic,
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
