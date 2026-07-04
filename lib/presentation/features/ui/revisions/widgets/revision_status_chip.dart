import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/revision_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class RevisionStatusChip extends StatelessWidget {
  const RevisionStatusChip({required this.status, super.key});

  final RevisionStatus status;

  @override
  Widget build(BuildContext context) {
    final inProgress = status.isInProgress;
    final bg = inProgress
        ? Resources.colors.luxuryGoldLight.withValues(alpha: 0.15)
        : Resources.colors.luxuryProgressTrack;
    final fg = inProgress
        ? Resources.colors.luxuryGold
        : Resources.colors.luxuryInk;
    final label =
        context.isRtl ? status.displayLabelAr : status.displayLabel;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$8,
        vertical: Resources.verticalDims.$2,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontFamily: Resources.fonts.manrope,
          fontSize: Resources.fontSizes.$10,
          fontWeight: Resources.fontWeights.bold,
          letterSpacing: Resources.letterSpacing.$0_4,
          color: fg,
        ),
      ),
    );
  }
}
