import 'package:acrova/data/models/interior_design/interior_design_palette_model.dart';
import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class InteriorDesignColorPalettePreview extends StatelessWidget {
  const InteriorDesignColorPalettePreview({required this.item, super.key});

  final InteriorDesignResponseModel item;

  @override
  Widget build(BuildContext context) {
    if (item.colorPalette.isEmpty) return const SizedBox.shrink();

    final loc = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.interiorDesignPaletteSection,
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: Resources.fontSizes.$18,
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$12),
        Wrap(
          spacing: Resources.horizontalDims.$12,
          runSpacing: Resources.verticalDims.$12,
          children: item.colorPalette.map((name) {
            final palette = InteriorDesignPaletteModel.defaultPalettes
                .firstWhere(
                  (p) => p.id.toLowerCase() == name.toLowerCase(),
                  orElse: () => InteriorDesignPaletteModel(
                    id: name,
                    colorValues: const [0xFFE3D9CC, 0xFFC9B6A1, 0xFF54433A],
                  ),
                );
            return _PaletteCard(palette: palette);
          }).toList(),
        ),
      ],
    );
  }
}

class _PaletteCard extends StatelessWidget {
  const _PaletteCard({required this.palette});

  final InteriorDesignPaletteModel palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$12,
        vertical: Resources.verticalDims.$8,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r4),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: palette.colors
                .map((color) => _ColorDot(color: color))
                .toList(),
          ),
          SizedBox(width: Resources.horizontalDims.$8),
          Text(
            palette.localizedLabel(context),
            style: TextStyle(
              fontSize: Resources.fontSizes.$12,
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Resources.horizontalDims.$16,
      height: Resources.verticalDims.$16,
      margin: EdgeInsets.only(right: Resources.horizontalDims.$4),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Resources.colors.luxuryBorder,
          width: 0.5,
        ),
      ),
    );
  }
}
