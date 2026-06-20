import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/warning_row.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class SbcWarningCard extends StatelessWidget {
  const SbcWarningCard({required this.state, super.key});

  final ProjectCreationState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$16),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryWarning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(
          color: Resources.colors.luxuryWarning.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: Resources.iconSizes.$18,
                color: Resources.colors.luxuryWarning,
              ),
              SizedBox(width: Resources.horizontalDims.$8),
              Text(
                l10n.landDetailsSbcTitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: Resources.fontWeights.bold,
                      color: Resources.colors.luxuryWarning,
                    ),
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$8),
          if (state.sbcAreaWarning) WarningRow(l10n.landDetailsSbcAreaWarning),
          if (state.sbcFloorWarning) WarningRow(l10n.landDetailsSbcFloorWarning),
          if (state.sbcWidthAdvisory) WarningRow(l10n.landDetailsSbcWidthAdvisory),
          SizedBox(height: Resources.verticalDims.$4),
          Text(
            l10n.landDetailsSbcFooter,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Resources.colors.luxuryWarning.withValues(alpha: 0.8),
                  fontSize: Resources.fontSizes.$10,
                ),
          ),
        ],
      ),
    );
  }
}
