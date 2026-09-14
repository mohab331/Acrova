import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class InteriorDesignMoodboardPreview extends StatelessWidget {
  const InteriorDesignMoodboardPreview({required this.item, super.key});

  final InteriorDesignResponseModel item;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final hasMoodboards = item.moodboards.isNotEmpty;
    final hasAtmosphere = item.atmosphereTags.isNotEmpty;

    if (!hasMoodboards && !hasAtmosphere) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasMoodboards) ...[
          Text(
            loc.interiorDesignMoodboardsSection,
            style: context.textTheme.labelLarge?.copyWith(
              fontSize: Resources.fontSizes.$18,
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$12),
          Wrap(
            spacing: Resources.horizontalDims.$8,
            runSpacing: Resources.verticalDims.$8,
            children: item.moodboards
                .map((m) => _MoodboardTile(label: m))
                .toList(),
          ),
          SizedBox(height: Resources.verticalDims.$24),
        ],
        if (hasAtmosphere) ...[
          Text(
            loc.interiorDesignAtmosphereSection,
            style: context.textTheme.labelLarge?.copyWith(
              fontSize: Resources.fontSizes.$18,
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$12),
          Wrap(
            spacing: Resources.horizontalDims.$8,
            runSpacing: Resources.verticalDims.$8,
            children: item.atmosphereTags
                .map((tag) => _AtmosphereTag(label: tag))
                .toList(),
          ),
        ],
      ],
    );
  }
}

class _MoodboardTile extends StatelessWidget {
  const _MoodboardTile({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$14,
        vertical: Resources.verticalDims.$8,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r4),
        border: Border.all(color: Resources.colors.luxuryGoldBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.style_outlined,
            size: Resources.fontSizes.$14,
            color: Resources.colors.luxuryGoldLight,
          ),
          SizedBox(width: Resources.horizontalDims.$6),
          Text(
            label,
            style: TextStyle(
              fontSize: Resources.fontSizes.$12,
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
          ),
        ],
      ),
    );
  }
}

class _AtmosphereTag extends StatelessWidget {
  const _AtmosphereTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$12,
        vertical: Resources.verticalDims.$6,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryInputBg,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: Resources.fontSizes.$12,
          fontWeight: Resources.fontWeights.medium,
          color: Resources.colors.luxuryBody,
        ),
      ),
    );
  }
}
