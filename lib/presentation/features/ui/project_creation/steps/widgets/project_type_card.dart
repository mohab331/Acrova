import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class ProjectTypeCard extends StatelessWidget {
  const ProjectTypeCard({
    required this.label,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.normal,
        padding: EdgeInsets.all(Resources.horizontalDims.$20),
        decoration: BoxDecoration(
          color: isSelected
              ? Resources.colors.luxuryNavy
              : Resources.colors.luxurySurface,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          border: Border.all(
            color: isSelected
                ? Resources.colors.luxuryNavy
                : Resources.colors.luxuryBorder,
            width: isSelected ? 0 : 1,
          ),
          boxShadow: isSelected ? AppShadows.hero : AppShadows.card,
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isSelected
                    ? Resources.colors.luxuryGoldLight.withValues(alpha: 0.15)
                    : Resources.colors.luxuryBackground,
                borderRadius: BorderRadius.circular(Resources.radius.$r8),
              ),
              child: Icon(
                icon,
                size: Resources.iconSizes.$24,
                color: isSelected
                    ? Resources.colors.luxuryGoldLight
                    : Resources.colors.luxuryNavy,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: isSelected
                              ? Resources.colors.luxurySurface
                              : Resources.colors.luxuryNavy,
                          fontWeight: Resources.fontWeights.semiBold,
                        ),
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? Resources.colors.luxurySurface
                                  .withValues(alpha: 0.65)
                              : Resources.colors.luxuryBodyMuted,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? Resources.colors.white
                  : Resources.colors.luxuryProgressTrack,
            ),
          ],
        ),
      ),
    );
  }
}
