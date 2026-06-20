import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/pulsing_dot.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class ActivePhaseBadge extends StatelessWidget {
  const ActivePhaseBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$12,
        vertical: Resources.verticalDims.$6,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        border: Border.all(
          color: Resources.colors.luxuryGold.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PulsingDot(),
          SizedBox(width: Resources.horizontalDims.$6),
          Text(
            context.localization.activePhase,
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$10,
              fontWeight: Resources.fontWeights.bold,
              letterSpacing: Resources.letterSpacing.$0_8,
              color: Resources.colors.luxuryGold,
            ),
          ),
        ],
      ),
    );
  }
}
