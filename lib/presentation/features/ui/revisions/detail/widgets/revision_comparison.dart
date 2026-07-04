import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

/// Before/after visual comparison. Uses placeholder tiles until the backend
/// provides real comparison assets.
class RevisionComparison extends StatelessWidget {
  const RevisionComparison({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.revisionDetailComparisons.toUpperCase(),
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$10,
            fontWeight: Resources.fontWeights.bold,
            letterSpacing: Resources.letterSpacing.$1_0,
            color: Resources.colors.luxuryBodyMuted,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$16),
        Row(
          children: [
            Expanded(
              child: _Tile(
                icon: Icons.image_outlined,
                label: l10n.revisionDetailOriginal,
                highlighted: false,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$12),
            Expanded(
              child: _Tile(
                icon: Icons.auto_awesome_outlined,
                label: l10n.revisionDetailRevised,
                highlighted: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.label,
    required this.highlighted,
  });

  final IconData icon;
  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: AppAspectRatios.square,
          child: Container(
            decoration: BoxDecoration(
              color: Resources.colors.luxuryProgressTrack,
              borderRadius: BorderRadius.circular(Resources.radius.$r2),
              border: highlighted
                  ? Border.all(color: Resources.colors.luxuryGoldLight)
                  : null,
            ),
            child: Icon(
              icon,
              size: Resources.iconSizes.$40,
              color: highlighted
                  ? Resources.colors.luxuryGoldLight
                  : Resources.colors.luxuryPlaceholder,
            ),
          ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$11,
            fontWeight: highlighted
                ? Resources.fontWeights.bold
                : Resources.fontWeights.medium,
            letterSpacing: Resources.letterSpacing.$0_8,
            color: highlighted
                ? Resources.colors.luxuryGold
                : Resources.colors.luxuryBodyMuted,
          ),
        ),
      ],
    );
  }
}
