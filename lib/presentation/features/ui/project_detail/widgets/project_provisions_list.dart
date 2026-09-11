import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectProvisionsList extends StatelessWidget {
  const ProjectProvisionsList({this.provisions, super.key});

  final List<String>? provisions;

  @override
  Widget build(BuildContext context) {
    final items = provisions ?? const [];
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.projectDetailCoreProvisions,
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: Resources.fontSizes.$18,
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$16),
        Wrap(
          spacing: Resources.horizontalDims.$8,
          runSpacing: Resources.verticalDims.$8,
          children: items.map((provision) => _ProvisionChip(label: provision)).toList(),
        ),

      ],
    );
  }
}

class _ProvisionChip extends StatelessWidget {
  const _ProvisionChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$16,
        vertical: Resources.verticalDims.$8,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface, // bg-surface
        border: Border.all(
          color: Resources.colors.luxuryGoldBorder,
        ),
        borderRadius: BorderRadius.circular(Resources.radius.$r20), // rounded-full
      ),
      child: Text(
        label,
        style: context.textTheme.bodyMedium?.copyWith(
          color: Resources.colors.luxuryNavy,
          fontWeight: Resources.fontWeights.medium,
        ),
      ),
    );
  }
}
