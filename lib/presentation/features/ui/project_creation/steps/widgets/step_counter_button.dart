import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

/// Reusable +/− counter button for wizard steps.
///
/// [activeColor] defaults to [luxuryNavy]. Step 3 passes [luxuryGold].
class StepCounterButton extends StatelessWidget {
  const StepCounterButton({
    required this.icon,
    required this.onTap,
    this.size = 36,
    this.activeColor,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    final color = activeColor ?? Resources.colors.luxuryNavy;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isEnabled ? color : Resources.colors.luxuryProgressTrack,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
        ),
        child: Icon(
          icon,
          size: Resources.iconSizes.$16,
          color: isEnabled
              ? Resources.colors.luxurySurface
              : Resources.colors.luxuryBodyMuted,
        ),
      ),
    );
  }
}
