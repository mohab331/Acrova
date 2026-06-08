import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Horizontal step indicator for multi-step wizards.
///
/// Shows numbered circles connected by lines.
/// - Completed steps: luxuryNavy background + white check icon
/// - Active step: luxuryGoldLight background + white number
/// - Upcoming steps: luxuryProgressTrack background + muted number
class AppProgressStepper extends StatelessWidget {
  const AppProgressStepper({
    required this.totalSteps,
    required this.currentStep,
    super.key,
  });

  /// Total number of steps (e.g. 6).
  final int totalSteps;

  /// Zero-indexed current step.
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps * 2 - 1, (i) {
        if (i.isOdd) {
          // Connector line
          final leftStepIndex = i ~/ 2;
          final isCompleted = leftStepIndex < currentStep;
          return Flexible(
            child: Container(
              height: 2,
              color: isCompleted
                  ? Resources.colors.luxuryNavy
                  : Resources.colors.luxuryProgressTrack,
            ),
          );
        }

        // Step circle
        final stepIndex = i ~/ 2;
        final isCompleted = stepIndex < currentStep;
        final isActive = stepIndex == currentStep;

        return _StepCircle(
          stepNumber: stepIndex + 1,
          isCompleted: isCompleted,
          isActive: isActive,
        );
      }),
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({
    required this.stepNumber,
    required this.isCompleted,
    required this.isActive,
  });

  final int stepNumber;
  final bool isCompleted;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;

    if (isCompleted) {
      bg = Resources.colors.luxuryNavy;
      fg = Resources.colors.luxurySurface;
    } else if (isActive) {
      bg = Resources.colors.luxuryGold;
      fg = Resources.colors.white;
    } else {
      bg = Resources.colors.luxuryProgressTrack;
      fg = Resources.colors.luxuryBodyMuted;
    }

    return Container(
      width: 28.r,
      height: 28.r,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isCompleted
            ? Icon(
                Icons.check,
                size: 14.sp,
                color: fg,
              )
            : Text(
                '$stepNumber',
                style: context.textTheme.labelMedium?.copyWith(
                  fontSize: Resources.fontSizes.$12,
                  fontWeight: Resources.fontWeights.bold,
                  color: fg,
                ),
              ),
      ),
    );
  }
}
