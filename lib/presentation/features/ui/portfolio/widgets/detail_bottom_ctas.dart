import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class DetailBottomCtas extends StatelessWidget {
  const DetailBottomCtas({
    required this.onStartProject,
    required this.onWatchWalkthrough,
    super.key,
  });

  final VoidCallback onStartProject;
  final VoidCallback onWatchWalkthrough;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface.withValues(alpha: 0.92),
        border: Border(top: BorderSide(color: Resources.colors.luxuryInputBg)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(Resources.horizontalDims.$24, Resources.verticalDims.$20, Resources.horizontalDims.$24, Resources.verticalDims.$20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onStartProject,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$16),
                  decoration: BoxDecoration(
                    color: Resources.colors.luxuryNavy,
                    borderRadius: BorderRadius.circular(Resources.radius.$r12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.localization.portfolioCtaStartProject,
                        style: TextStyle(
                          fontSize: Resources.fontSizes.$12,
                          fontWeight: Resources.fontWeights.bold,
                          color: Resources.colors.white,
                          letterSpacing: Resources.letterSpacing.$0_8,
                        ),
                      ),
                      SizedBox(width: Resources.horizontalDims.$8),
                      Icon(
                        Icons.arrow_forward,
                        size: Resources.iconSizes.$18,
                        color: Resources.colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Resources.verticalDims.$12),
              GestureDetector(
                onTap: onWatchWalkthrough,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle,
                        size: Resources.iconSizes.$16,
                        color: Resources.colors.luxuryGoldLight,
                      ),
                      SizedBox(width: Resources.horizontalDims.$8),
                      Text(
                        context.localization.portfolioCtaWatchWalkthrough,
                        style: TextStyle(
                          fontSize: Resources.fontSizes.$12,
                          fontWeight: Resources.fontWeights.bold,
                          color: Resources.colors.luxuryGoldLight,
                          letterSpacing: Resources.letterSpacing.$0_8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
