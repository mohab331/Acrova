import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/toggle_card.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/toggle_item.dart';
import 'package:flutter/material.dart';

class ToggleGrid extends StatelessWidget {
  const ToggleGrid({required this.items, super.key});

  final List<ToggleItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Resources.horizontalDims.$12,
        mainAxisSpacing: Resources.verticalDims.$12,
        childAspectRatio: AppAspectRatios.card2x4,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => ToggleCard(item: items[i]),
    );
  }
}
