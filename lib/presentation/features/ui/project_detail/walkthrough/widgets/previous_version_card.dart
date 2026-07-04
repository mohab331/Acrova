import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class PreviousVersionCard extends StatelessWidget {
  final String version;
  final String dateAndSize;
  final VoidCallback onTap;

  const PreviousVersionCard({
    super.key,
    required this.version,
    required this.dateAndSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Resources.colors.luxurySurface,
      borderRadius: BorderRadius.circular(Resources.radius.$r2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        hoverColor: Resources.colors.luxuryNavy.withOpacity(0.05),
        child: Padding(
          padding: EdgeInsets.all(Resources.horizontalDims.$24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: Resources.squareDims.$48,
                    height: Resources.squareDims.$48,
                    decoration: BoxDecoration(
                      color: Resources.colors.luxuryBackground, // equivalent to surface-container-high
                      borderRadius: BorderRadius.circular(Resources.radius.$r2),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.history,
                      color: Resources.colors.luxuryNavy.withOpacity(0.4),
                    ),
                  ),
                  SizedBox(width: Resources.horizontalDims.$20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        version,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: Resources.colors.luxuryNavy,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: Resources.verticalDims.$4),
                      Text(
                        dateAndSize,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Resources.colors.luxuryBodyMuted,
                          fontSize: Resources.fontSizes.$12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right,
                color: Resources.colors.luxuryPlaceholder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
