import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class RevisionModifications extends StatelessWidget {
  const RevisionModifications({required this.description, super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: Resources.horizontalDims.$4,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(Resources.radius.$r100),
              ),
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localization.revisionDetailModifications.toUpperCase(),
                  style: TextStyle(
                    fontFamily: Resources.fonts.manrope,
                    fontSize: Resources.fontSizes.$10,
                    fontWeight: Resources.fontWeights.bold,
                    letterSpacing: Resources.letterSpacing.$1_0,
                    color: Resources.colors.luxuryGold,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$16),
                Text(
                  description,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontSize: Resources.fontSizes.$16,
                    color: Resources.colors.luxuryInk,
                    height: Resources.lineHeights.$1_6,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$16),
                Container(
                  width: Resources.horizontalDims.$50,
                  height: 1,
                  color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
