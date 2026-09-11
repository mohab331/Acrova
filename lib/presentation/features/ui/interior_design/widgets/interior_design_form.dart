import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_cubit.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_state.dart';
import 'package:acrova/presentation/features/ui/interior_design/widgets/aesthetic_profiling_section.dart';
import 'package:acrova/presentation/features/ui/interior_design/widgets/inspiration_links_section.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/media_item.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/wizard_text_field.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteriorDesignForm extends StatefulWidget {
  const InteriorDesignForm({super.key});

  @override
  State<InteriorDesignForm> createState() => _InteriorDesignFormState();
}

class _InteriorDesignFormState extends State<InteriorDesignForm> {
  late final TextEditingController _customScopeCtrl;
  late final TextEditingController _extraNotesCtrl;
  
  static int _mockCounter = 0;

  @override
  void initState() {
    super.initState();
    final s = context.read<InteriorDesignCubit>().state;
    _customScopeCtrl = TextEditingController(text: s.customScopeNotes);
    _extraNotesCtrl = TextEditingController(text: s.extraNotes);
  }

  @override
  void dispose() {
    _customScopeCtrl.dispose();
    _extraNotesCtrl.dispose();
    super.dispose();
  }

  void _mockPickImage(BuildContext context) {
    _mockCounter++;
    context.read<InteriorDesignCubit>().addInspirationMedia(
          'mock://inspiration_photo_$_mockCounter.jpg',
        );
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return BlocBuilder<InteriorDesignCubit, InteriorDesignState>(
      builder: (context, state) {
        final cubit = context.read<InteriorDesignCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SCOPE SELECTION
            _InteriorDesignSectionTitle(title: loc.interiorDesignScopeTitle),
            Row(
              children: [
                Expanded(
                  child: _SelectionCard(
                    label: loc.interiorDesignScopeEntireProject,
                    isSelected: state.scope == 'all',
                    onTap: () => cubit.updateScope('all'),
                  ),
                ),
                SizedBox(width: Resources.horizontalDims.$12),
                Expanded(
                  child: _SelectionCard(
                    label: loc.interiorDesignScopeSpecificAreas,
                    isSelected: state.scope == 'specific',
                    onTap: () => cubit.updateScope('specific'),
                  ),
                ),
              ],
            ),
            if (state.scope == 'specific') ...[
              SizedBox(height: Resources.verticalDims.$16),
              WizardTextField(
                controller: _customScopeCtrl,
                label: loc.interiorDesignSpecifyAreas,
                hint: loc.interiorDesignSpecifyAreasHint,
                onChanged: cubit.updateCustomScopeNotes,
              ),
            ],

            SizedBox(height: Resources.verticalDims.$24),

            // SPACE PLANNING
            _InteriorDesignSectionTitle(title: loc.interiorDesignSpacePlanningTitle),
            Container(
              decoration: BoxDecoration(
                color: Resources.colors.luxurySurface,
                borderRadius: BorderRadius.circular(Resources.radius.$r12),
                border: Border.all(color: Resources.colors.luxuryBorder),
              ),
              child: SwitchListTile(
                title: Text(
                  loc.interiorDesignSpacePlanningSwitch,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: Resources.fontWeights.medium,
                  ),
                ),
                subtitle: Text(
                  loc.interiorDesignSpacePlanningSubtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Resources.colors.luxuryBody,
                  ),
                ),
                value: state.spacePlanningRequired,
                activeThumbColor: Resources.colors.luxuryNavy,
                onChanged: cubit.toggleSpacePlanning,
              ),
            ),

            SizedBox(height: Resources.verticalDims.$24),

            // BUDGET & TIMELINE
            _InteriorDesignSectionTitle(title: loc.interiorDesignBudgetTimelineTitle),
            Row(
              children: [
                Expanded(
                  child: _DropdownField(
                    label: loc.interiorDesignBudgetTier,
                    value: state.budgetTier.isEmpty ? null : state.budgetTier,
                    hint: loc.interiorDesignSelectPlaceholder,
                    options: [
                      _DropdownOption(value: 'standard', label: loc.interiorDesignBudgetStandard),
                      _DropdownOption(value: 'premium', label: loc.interiorDesignBudgetPremium),
                      _DropdownOption(value: 'ultra_luxury', label: loc.interiorDesignBudgetUltraLuxury),
                    ],
                    onChanged: (v) => cubit.updateBudgetTier(v ?? ''),
                  ),
                ),
                SizedBox(width: Resources.horizontalDims.$12),
                Expanded(
                  child: _DropdownField(
                    label: loc.interiorDesignTimeline,
                    value: state.timeline.isEmpty ? null : state.timeline,
                    hint: loc.interiorDesignSelectPlaceholder,
                    options: [
                      _DropdownOption(value: 'flexible', label: loc.interiorDesignTimelineFlexible),
                      _DropdownOption(value: '3_6_months', label: loc.interiorDesignTimelineThreeToSixMonths),
                      _DropdownOption(value: 'asap', label: loc.interiorDesignTimelineAsap),
                    ],
                    onChanged: (v) => cubit.updateTimeline(v ?? ''),
                  ),
                ),
              ],
            ),

            SizedBox(height: Resources.verticalDims.$24),

            // EXTRA NOTES
            _InteriorDesignSectionTitle(title: loc.interiorDesignAdditionalRequirementsTitle),
            Container(
              decoration: BoxDecoration(
                color: Resources.colors.luxuryInputBg,
                borderRadius: BorderRadius.circular(Resources.radius.$r2),
                border: Border.all(color: Resources.colors.luxuryInputBorder),
              ),
              child: TextField(
                controller: _extraNotesCtrl,
                maxLines: 5,
                minLines: 4,
                onChanged: cubit.updateExtraNotes,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Resources.colors.luxuryInk,
                  fontSize: Resources.fontSizes.$15,
                ),
                decoration: InputDecoration(
                  hintText: loc.interiorDesignNotesHint,
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Resources.colors.luxuryPlaceholder,
                  ),
                  contentPadding: EdgeInsets.all(Resources.horizontalDims.$16),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: Resources.verticalDims.$24),

            // AESTHETIC PROFILING
            const AestheticProfilingSection(),

            // INSPIRATION LINKS
            const InspirationLinksSection(),

            SizedBox(height: Resources.verticalDims.$24),

            // MEDIA UPLOAD
            _InteriorDesignSectionTitle(title: loc.interiorDesignInspirationMediaTitle),
            GestureDetector(
              onTap: () => _mockPickImage(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$22),
                decoration: BoxDecoration(
                  color: Resources.colors.luxuryInputBg,
                  borderRadius: BorderRadius.circular(Resources.radius.$r8),
                  border: Border.all(
                    color: Resources.colors.luxuryGoldBorder,
                    width: AppBorderWidths.$1_5,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: Resources.iconSizes.$40,
                      color: Resources.colors.luxuryGoldLight,
                    ),
                    SizedBox(height: Resources.verticalDims.$10),
                    Text(
                      loc.interiorDesignAddInspirationPhotos,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: Resources.fontSizes.$12,
                            fontWeight: Resources.fontWeights.bold,
                            color: Resources.colors.luxuryGoldLight,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.inspirationMediaPaths.isNotEmpty) ...[
              SizedBox(height: Resources.verticalDims.$16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.inspirationMediaPaths.length,
                separatorBuilder: (_, __) => SizedBox(height: Resources.verticalDims.$8),
                itemBuilder: (_, i) => MediaItem(
                  path: state.inspirationMediaPaths[i],
                  index: i,
                  // In a real app we'd add an onRemove callback
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$16,
          vertical: Resources.verticalDims.$18,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Resources.colors.luxuryNavy : Resources.colors.luxurySurface,
          borderRadius: BorderRadius.circular(Resources.radius.$r12),
          border: Border.all(
            color: isSelected ? Resources.colors.luxuryNavy : Resources.colors.luxuryBorder,
          ),
          boxShadow: AppShadows.card,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected ? Resources.colors.luxurySurface : Resources.colors.luxuryNavy,
                fontWeight: isSelected ? Resources.fontWeights.semiBold : Resources.fontWeights.medium,
              ),
        ),
      ),
    );
  }
}

class _DropdownOption {
  const _DropdownOption({required this.value, required this.label});
  final String value;
  final String label;
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.options,
    required this.hint,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<_DropdownOption> options;
  final String hint;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: Resources.fontWeights.medium,
                color: Resources.colors.luxuryBody,
              ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$12),
          decoration: BoxDecoration(
            color: Resources.colors.luxuryInputBg,
            borderRadius: BorderRadius.circular(Resources.radius.$r8),
            border: Border.all(color: Resources.colors.luxuryInputBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                hint,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Resources.colors.luxuryPlaceholder,
                    ),
              ),
              items: options.map((option) {
                return DropdownMenuItem(
                  value: option.value,
                  child: Text(
                    option.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Resources.colors.luxuryInk,
                        ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _InteriorDesignSectionTitle extends StatelessWidget {
  const _InteriorDesignSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Resources.verticalDims.$8,
        bottom: Resources.verticalDims.$12,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}
