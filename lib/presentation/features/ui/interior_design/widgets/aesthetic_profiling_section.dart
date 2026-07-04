import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_cubit.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_state.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AestheticProfilingSection extends StatelessWidget {
  const AestheticProfilingSection({super.key});

  static const List<Map<String, String>> _mockMoodboards = [
    {
      'id': 'mb_1',
      'url': 'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&q=80&w=400',
      'label': 'Modern Minimalist',
    },
    {
      'id': 'mb_2',
      'url': 'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&q=80&w=400',
      'label': 'Warm Organic',
    },
    {
      'id': 'mb_3',
      'url': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&q=80&w=400',
      'label': 'Dark Luxury',
    },
    {
      'id': 'mb_4',
      'url': 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&q=80&w=400',
      'label': 'Contemporary',
    },
  ];

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

  Widget _buildSectionTitle(BuildContext context, String title, String subtitle) {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InteriorDesignCubit, InteriorDesignState>(
      builder: (context, state) {
        final cubit = context.read<InteriorDesignCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MOODBOARD SELECTOR
            _buildSectionTitle(
              context,
              'AESTHETIC INSPIRATION',
              'Select up to 2 moodboards that resonate with your vision.',
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
              itemCount: _mockMoodboards.length,
              itemBuilder: (context, index) {
                final mb = _mockMoodboards[index];
                final isSelected = state.moodboards.contains(mb['id']);
                return GestureDetector(
                  onTap: () => cubit.toggleMoodboard(mb['id']!),
                  child: AnimatedContainer(
                    duration: AppDurations.fast,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Resources.radius.$r12),
                      border: Border.all(
                        color: isSelected ? Resources.colors.luxuryGoldLight : Colors.transparent,
                        width: 2,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(mb['url']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Gradient Overlay for Text
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child: Container(
                            height: 60,
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
                            mb['label']!,
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
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Resources.colors.luxuryGoldLight,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.check, size: 16, color: Resources.colors.white),
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
            _buildSectionTitle(
              context,
              'COLOR PALETTE',
              'Choose color themes for your interior spaces.',
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
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: Color(c),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
                            ),
                          )).toList(),
                        ),
                        SizedBox(height: Resources.verticalDims.$8),
                        Text(
                          palette['id'],
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
            _buildSectionTitle(
              context,
              'ATMOSPHERE & VIBE',
              'Select all the descriptors that match your style.',
            ),
            Wrap(
              spacing: Resources.horizontalDims.$8,
              runSpacing: Resources.verticalDims.$8,
              children: _atmosphereTags.map((tag) {
                final isSelected = state.atmosphereTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
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
                    borderRadius: BorderRadius.circular(100),
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
