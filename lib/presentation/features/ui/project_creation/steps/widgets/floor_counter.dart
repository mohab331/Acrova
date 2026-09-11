import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/step_counter_button.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class FloorCounter extends StatelessWidget {
  const FloorCounter({
    required this.floors,
    required this.onDecrement,
    required this.onIncrement,
    super.key,
  });

  final int floors;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.landDetailsLabelFloors.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Resources.colors.luxuryBody,
              ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$16,
            vertical: Resources.verticalDims.$12,
          ),
          decoration: BoxDecoration(
            color: Resources.colors.luxuryInputBg,
            borderRadius: BorderRadius.circular(Resources.radius.$r2),
            border: Border.all(color: Resources.colors.luxuryInputBorder),
          ),
          child: Row(
            children: [
              StepCounterButton(
                icon: Icons.remove,
                onTap: floors > 1 ? onDecrement : null,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$floors ${floors == 1 ? l10n.landDetailsFloorSingular : l10n.landDetailsFloorPlural}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Resources.colors.luxuryInk,
                          fontWeight: Resources.fontWeights.semiBold,
                        ),
                  ),
                ),
              ),
              StepCounterButton(
                icon: Icons.add,
                onTap: floors < 10 ? onIncrement : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
