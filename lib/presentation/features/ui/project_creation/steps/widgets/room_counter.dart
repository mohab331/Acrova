import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/step_counter_button.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class RoomCounter extends StatelessWidget {
  const RoomCounter({
    required this.label,
    required this.icon,
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
    required this.min,
    required this.max,
    super.key,
  });

  final String label;
  final IconData icon;
  final int count;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$16,
        vertical: Resources.verticalDims.$14,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Icon(icon, size: Resources.iconSizes.$20, color: Resources.colors.luxuryNavy),
          SizedBox(width: Resources.horizontalDims.$12),
          Expanded(
            child: Text(
              label,
              style: context.textTheme.labelLarge?.copyWith(
                    color: Resources.colors.luxuryInk,
                    fontWeight: Resources.fontWeights.medium,
                  ),
            ),
          ),
          StepCounterButton(
            icon: Icons.remove,
            size: 25,
            activeColor: Resources.colors.luxuryGold,
            onTap: count > min ? onDecrement : null,
          ),
          SizedBox(width: Resources.horizontalDims.$16),
          SizedBox(
            width: Resources.horizontalDims.$28,
            child: Center(
              child: Text(
                '$count',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: Resources.fontSizes.$16,
                      fontWeight: Resources.fontWeights.semiBold,
                      color: Resources.colors.luxuryNavy,
                    ),
              ),
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$16),
          StepCounterButton(
            icon: Icons.add,
            size: 25,
            activeColor: Resources.colors.luxuryGold,
            onTap: count < max ? onIncrement : null,
          ),
        ],
      ),
    );
  }
}
