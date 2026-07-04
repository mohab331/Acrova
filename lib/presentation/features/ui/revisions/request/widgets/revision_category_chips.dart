import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/revision_category_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class RevisionCategoryChips extends StatelessWidget {
  const RevisionCategoryChips({
    required this.selected,
    required this.onSelect,
    this.error,
    super.key,
  });

  final RevisionCategory? selected;
  final ValueChanged<RevisionCategory> onSelect;
  final String? error;

  String _label(BuildContext context, RevisionCategory c) {
    final l10n = context.localization;
    return switch (c) {
      RevisionCategory.layout => l10n.revisionCategoryLayout,
      RevisionCategory.materials => l10n.revisionCategoryMaterials,
      RevisionCategory.dimensions => l10n.revisionCategoryDimensions,
      RevisionCategory.structural => l10n.revisionCategoryStructural,
      RevisionCategory.exterior => l10n.revisionCategoryExterior,
      RevisionCategory.interior => l10n.revisionCategoryInterior,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: Resources.horizontalDims.$8,
          runSpacing: Resources.verticalDims.$8,
          children: RevisionCategory.values
              .map((c) => _Chip(
                    label: _label(context, c),
                    selected: selected == c,
                    onTap: () => onSelect(c),
                  ))
              .toList(),
        ),
        if (error != null) ...[
          SizedBox(height: Resources.verticalDims.$8),
          Text(
            error!,
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$10,
              fontWeight: Resources.fontWeights.bold,
              letterSpacing: Resources.letterSpacing.$0_8,
              color: Resources.colors.luxuryError,
            ),
          ),
        ],
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$18,
          vertical: Resources.verticalDims.$10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? Resources.colors.luxuryGoldLight.withValues(alpha: 0.1)
              : Resources.colors.luxurySurface,
          borderRadius: BorderRadius.circular(Resources.radius.$r100),
          border: Border.all(
            color: selected
                ? Resources.colors.luxuryGoldLight
                : Resources.colors.luxuryBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$14,
            fontWeight: selected
                ? Resources.fontWeights.semiBold
                : Resources.fontWeights.regular,
            color: selected
                ? Resources.colors.luxuryGold
                : Resources.colors.luxuryBody,
          ),
        ),
      ),
    );
  }
}
