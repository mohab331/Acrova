import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/toggle_item.dart';
import 'package:flutter/material.dart';

class ToggleCard extends StatelessWidget {
  const ToggleCard({required this.item, super.key});

  final ToggleItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => item.onChanged(!item.value),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$12),
        decoration: BoxDecoration(
          color: item.value
              ? Resources.colors.luxuryNavy
              : Resources.colors.luxurySurface,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          border: Border.all(
            color: item.value
                ? Resources.colors.luxuryNavy
                : Resources.colors.luxuryBorder,
          ),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: Resources.iconSizes.$18,
              color: item.value
                  ? Resources.colors.luxuryGoldLight
                  : Resources.colors.luxuryBodyMuted,
            ),
            SizedBox(width: Resources.horizontalDims.$8),
            Expanded(
              child: Text(
                item.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: Resources.fontSizes.$12,
                      fontWeight: Resources.fontWeights.semiBold,
                      color: item.value
                          ? Resources.colors.luxurySurface
                          : Resources.colors.luxuryInk,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
