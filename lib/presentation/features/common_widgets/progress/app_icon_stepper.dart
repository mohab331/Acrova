import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// A stepper that displays icons or labels for each stage.
///
/// Features a continuous progress line and perfectly aligned dots.
/// Used primarily for the Project Pipeline (8 stages).
class AppIconStepper extends StatelessWidget {
  const AppIconStepper({
    required this.totalSteps,
    required this.currentStep,
    this.icons,
    this.labels,
    super.key,
  }) : assert(icons != null || labels != null, 'Must provide either icons or labels');

  /// Total number of stages in the pipeline.
  final int totalSteps;

  /// The currently active stage (0-indexed).
  final int currentStep;

  /// Optional list of icons to display below each dot. Must match [totalSteps].
  final List<IconData>? icons;

  /// Optional list of labels to display below each dot. Must match [totalSteps].
  final List<String>? labels;

  @override
  Widget build(BuildContext context) {
    final int segments = totalSteps - 1;
    final double progressPercent = segments > 0 ? (currentStep / segments) : 0.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double columnWidth = constraints.maxWidth / totalSteps;
        final double paddingHorizontal = columnWidth / 2;
        final double lineMaxWidth = constraints.maxWidth - columnWidth;

        return Stack(
          children: [
            // Background line (Pending stages)
            Positioned(
              top: Resources.squareDims.$10, // Centers vertically behind the 20px active dot
              left: paddingHorizontal,
              right: paddingHorizontal,
              child: Container(
                height: 2,
                color: Resources.colors.luxuryProgressTrack,
              ),
            ),
            
            // Foreground line (Completed stages)
            Positioned(
              top: Resources.squareDims.$10,
              left: paddingHorizontal,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                height: 2,
                width: segments > 0 ? lineMaxWidth * progressPercent : 0,
                color: Resources.colors.luxuryNavy,
              ),
            ),
            
            // Dots and Labels/Icons
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(totalSteps, (index) {
                final isCompleted = index < currentStep;
                final isActive = index == currentStep;

                final Color itemColor;
                if (isCompleted) {
                  itemColor = Resources.colors.luxuryNavy;
                } else if (isActive) {
                  itemColor = Resources.colors.luxuryGoldLight;
                } else {
                  itemColor = Resources.colors.luxuryBodyMuted.withOpacity(0.6); // Slightly dimmed
                }

                Widget dot;
                if (isActive) {
                  dot = Container(
                    width: Resources.squareDims.$20,
                    height: Resources.squareDims.$20,
                    decoration: BoxDecoration(
                      color: Resources.colors.luxuryGoldLight,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Resources.colors.luxuryGoldLight.withOpacity(0.2),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Resources.colors.luxuryGoldLight.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  );
                } else {
                  dot = Container(
                    width: Resources.squareDims.$16,
                    height: Resources.squareDims.$16,
                    margin: EdgeInsets.only(top: Resources.squareDims.$2), // Centers the 16px dot within the 20px row
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Resources.colors.luxuryNavy
                          : Resources.colors.luxuryProgressTrack,
                      shape: BoxShape.circle,
                    ),
                  );
                }

                Widget bottomWidget;
                if (icons != null) {
                  bottomWidget = Icon(
                    icons![index],
                    color: itemColor,
                    size: Resources.iconSizes.$20,
                  );
                } else {
                  bottomWidget = Text(
                    labels![index],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: Resources.fontSizes.$10,
                      fontWeight: isActive
                          ? Resources.fontWeights.extraBold
                          : Resources.fontWeights.bold,
                      letterSpacing: 0, 
                      color: itemColor,
                    ),
                  );
                }

                return Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: Resources.squareDims.$20,
                        alignment: Alignment.topCenter,
                        child: dot,
                      ),
                      SizedBox(height: Resources.verticalDims.$12),
                      bottomWidget,
                    ],
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
