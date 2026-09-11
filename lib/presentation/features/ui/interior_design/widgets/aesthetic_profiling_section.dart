import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_cubit.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AestheticProfilingSection extends StatelessWidget {
  const AestheticProfilingSection({super.key});

  static const List<Map<String, dynamic>> _colorPalettes = [
    {'id': 'Warm Neutrals', 'colors': [0xFFE3D9CC, 0xFFC9B6A1, 0xFF9E8570, 0xFF54433A]},
    {'id': 'Cool Elegance', 'colors': [0xFFE6ECEB, 0xFFB3C5C2, 0xFF6B8A88, 0xFF2F4543]},
    {'id': 'Earthy Tones', 'colors': [0xFFF2EBE5, 0xFFD4C3B3, 0xFF8A9A86, 0xFF4A5D4E]},
    {'id': 'Monochrome', 'colors': [0xFFF5F5F5, 0xFFCCCCCC, 0xFF666666, 0xFF1A1A1A]},
    {'id': 'Desert Sun', 'colors': [0xFFFDF7ED, 0xFFEEDBB7, 0xFFD29C6C, 0xFF9B5E3C]},
  ];

  static const List<String> _atmosphereTags = [
    'Minimalist',
    'Cozy',
    'Luxurious',
    'Industrial',
    'Bohemian',
    'Contemporary',
    'Classic',
    'Biophilic',
    'Vibrant',
    'Serene',
  ];

  String _getPaletteLabel(BuildContext context, String id) {
    final loc = context.localization;
    switch (id) {
      case 'Warm Neutrals':
        return loc.interiorDesignPaletteWarmNeutrals;
      case 'Cool Elegance':
        return loc.interiorDesignPaletteCoolElegance;
      case 'Earthy Tones':
        return loc.interiorDesignPaletteEarthyTones;
      case 'Monochrome':
        return loc.interiorDesignPaletteMonochrome;
      case 'Desert Sun':
        return loc.interiorDesignPaletteDesertSun;
      default:
        return id;
    }
  }

  String _getAtmosphereLabel(BuildContext context, String tag) {
    final loc = context.localization;
    switch (tag) {
      case 'Minimalist':
        return loc.interiorDesignTagMinimalist;
      case 'Cozy':
        return loc.interiorDesignTagCozy;
      case 'Luxurious':
        return loc.interiorDesignTagLuxurious;
      case 'Industrial':
        return loc.interiorDesignTagIndustrial;
      case 'Bohemian':
        return loc.interiorDesignTagBohemian;
      case 'Contemporary':
        return loc.interiorDesignTagContemporary;
      case 'Classic':
        return loc.interiorDesignTagClassic;
      case 'Biophilic':
        return loc.interiorDesignTagBiophilic;
      case 'Vibrant':
        return loc.interiorDesignTagVibrant;
      case 'Serene':
        return loc.interiorDesignTagSerene;
      default:
        return tag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return BlocBuilder<InteriorDesignCubit, InteriorDesignState>(
      builder: (context, state) {
        final cubit = context.read<InteriorDesignCubit>();
        final moodboards = state.availableMoodboards;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MOODBOARD SELECTOR
            _AestheticSectionTitle(
              title: loc.interiorDesignAestheticInspirationTitle,
              subtitle: loc.interiorDesignAestheticInspirationSubtitle,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Resources.horizontalDims.$12,
                mainAxisSpacing: Resources.verticalDims.$12,
                childAspectRatio: 0.85,
              ),
              itemCount: moodboards.length,
              itemBuilder: (context, index) {
                final mb = moodboards[index];
                final isSelected = state.moodboards.contains(mb.id);
                return GestureDetector(
                  onTap: () => cubit.toggleMoodboard(mb.id),
                  child: AnimatedContainer(
                    duration: AppDurations.fast,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Resources.radius.$r12),
                      border: Border.all(
                        color: isSelected ? Resources.colors.luxuryGoldLight : Colors.transparent,
                        width: AppBorderWidths.$2,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(mb.url),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Gradient Overlay for Text
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child: Container(
                            height: Resources.verticalDims.$60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(Resources.radius.$r12 - 2)),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Resources.verticalDims.$8,
                          left: Resources.horizontalDims.$8,
                          right: Resources.horizontalDims.$8,
                          child: Text(
                            mb.localizedLabel(context),
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Resources.colors.white,
                              fontWeight: Resources.fontWeights.semiBold,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            top: Resources.verticalDims.$8,
                            right: Resources.horizontalDims.$8,
                            child: Container(
                              padding: EdgeInsets.all(Resources.squareDims.$4),
                              decoration: BoxDecoration(
                                color: Resources.colors.luxuryGoldLight,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.check, size: Resources.iconSizes.$16, color: Resources.colors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: Resources.verticalDims.$24),

            // COLOR PALETTE
            _AestheticSectionTitle(
              title: loc.interiorDesignColorPaletteTitle,
              subtitle: loc.interiorDesignColorPaletteSubtitle,
            ),
            Wrap(
              spacing: Resources.horizontalDims.$12,
              runSpacing: Resources.verticalDims.$12,
              children: _colorPalettes.map((palette) {
                final isSelected = state.colorPalette.contains(palette['id']);
                final colors = palette['colors'] as List<int>;
                return GestureDetector(
                  onTap: () => cubit.toggleColor(palette['id']),
                  child: AnimatedContainer(
                    duration: AppDurations.fast,
                    padding: EdgeInsets.all(Resources.horizontalDims.$8),
                    decoration: BoxDecoration(
                      color: isSelected ? Resources.colors.luxuryNavy : Resources.colors.luxurySurface,
                      borderRadius: BorderRadius.circular(Resources.radius.$r12),
                      border: Border.all(
                        color: isSelected ? Resources.colors.luxuryNavy : Resources.colors.luxuryBorder,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: colors.map((c) => Container(
                            width: Resources.squareDims.$24,
                            height: Resources.squareDims.$24,
                            margin: EdgeInsets.only(right: Resources.horizontalDims.$4),
                            decoration: BoxDecoration(
                              color: Color(c),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
                            ),
                          )).toList(),
                        ),
                        SizedBox(height: Resources.verticalDims.$8),
                        Text(
                          _getPaletteLabel(context, palette['id'] as String),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: isSelected ? Resources.colors.luxurySurface : Resources.colors.luxuryBody,
                            fontWeight: isSelected ? Resources.fontWeights.semiBold : Resources.fontWeights.medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: Resources.verticalDims.$24),

            // ATMOSPHERE TAGS
            _AestheticSectionTitle(
              title: loc.interiorDesignAtmosphereTitle,
              subtitle: loc.interiorDesignAtmosphereSubtitle,
            ),
            Wrap(
              spacing: Resources.horizontalDims.$8,
              runSpacing: Resources.verticalDims.$8,
              children: _atmosphereTags.map((tag) {
                final isSelected = state.atmosphereTags.contains(tag);
                return FilterChip(
                  label: Text(_getAtmosphereLabel(context, tag)),
                  selected: isSelected,
                  onSelected: (_) => cubit.toggleAtmosphereTag(tag),
                  selectedColor: Resources.colors.luxuryNavy,
                  backgroundColor: Resources.colors.luxurySurface,
                  checkmarkColor: Resources.colors.luxurySurface,
                  labelStyle: context.textTheme.bodySmall?.copyWith(
                    color: isSelected ? Resources.colors.luxurySurface : Resources.colors.luxuryNavy,
                    fontWeight: isSelected ? Resources.fontWeights.semiBold : Resources.fontWeights.medium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Resources.radius.$r100),
                    side: BorderSide(
                      color: isSelected ? Resources.colors.luxuryNavy : Resources.colors.luxuryBorder,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _AestheticSectionTitle extends StatelessWidget {
  const _AestheticSectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: Resources.fontWeights.semiBold,
                  color: Resources.colors.luxuryNavy,
                  letterSpacing: 0.5,
                ),
          ),
          SizedBox(height: Resources.verticalDims.$4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Resources.colors.luxuryBody,
                ),
          ),
        ],
      ),
    );
  }
}
