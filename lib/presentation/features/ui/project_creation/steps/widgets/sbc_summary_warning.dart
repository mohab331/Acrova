import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class SbcSummaryWarning extends StatelessWidget {
  const SbcSummaryWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$16),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryWarning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(
          color: Resources.colors.luxuryWarning.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Resources.colors.luxuryWarning,
            size: Resources.iconSizes.$20,
          ),
          SizedBox(width: Resources.horizontalDims.$10),
          Expanded(
            child: Text(
              context.localization.reviewSbcWarning,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Resources.colors.luxuryWarning,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
