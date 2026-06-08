import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Step1ProjectType extends StatelessWidget {
  const Step1ProjectType({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final types = [
      (
        type: ProjectType.residentialVilla,
        icon: Icons.villa_outlined,
        label: l10n.projectTypeVillaLabel,
        description: l10n.projectTypeVillaDesc,
      ),
      (
        type: ProjectType.commercialBuilding,
        icon: Icons.business_outlined,
        label: l10n.projectTypeCommercialLabel,
        description: l10n.projectTypeCommercialDesc,
      ),
      (
        type: ProjectType.mixedUse,
        icon: Icons.layers_outlined,
        label: l10n.projectTypeMixedUseLabel,
        description: l10n.projectTypeMixedUseDesc,
      ),
    ];

    return BlocBuilder<ProjectCreationCubit, ProjectCreationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.projectTypeTitle,
                style: context.textTheme.headlineSmall?.copyWith(
                      color: Resources.colors.luxuryNavy,
                      fontWeight: Resources.fontWeights.semiBold,
                    ),
              ),
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.projectTypeSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                      color: Resources.colors.luxuryBody,
                    ),
              ),
              SizedBox(height: Resources.verticalDims.$32),
              ...types.map(
                (t) => Padding(
                  padding: EdgeInsets.only(bottom: Resources.verticalDims.$16),
                  child: _TypeCard(
                    label: t.label,
                    icon: t.icon,
                    description: t.description,
                    isSelected: state.selectedType == t.type,
                    onTap: () => context
                        .read<ProjectCreationCubit>()
                        .selectProjectType(t.type),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.label,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(Resources.horizontalDims.$20),
        decoration: BoxDecoration(
          color: isSelected
              ? Resources.colors.luxuryNavy
              : Resources.colors.luxurySurface,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          border: Border.all(
            color: isSelected
                ? Resources.colors.luxuryNavy
                : Resources.colors.luxuryBorder,
            width: isSelected ? 0 : 1,
          ),
          boxShadow: isSelected ? AppShadows.hero : AppShadows.card,
        ),
        child: Row(
          children: [
            Container(
              width: 52.r,
              height: 52.r,
              decoration: BoxDecoration(
                color: isSelected
                    ? Resources.colors.luxuryGoldLight.withOpacity(0.15)
                    : Resources.colors.luxuryBackground,
                borderRadius: BorderRadius.circular(Resources.radius.$r8),
              ),
              child: Icon(
                icon,
                size: Resources.iconSizes.$24,
                color: isSelected
                    ? Resources.colors.luxuryGoldLight
                    : Resources.colors.luxuryNavy,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: isSelected
                              ? Resources.colors.luxurySurface
                              : Resources.colors.luxuryNavy,
                          fontWeight: Resources.fontWeights.semiBold,
                        ),
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? Resources.colors.luxurySurface.withOpacity(0.65)
                              : Resources.colors.luxuryBodyMuted,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected
                  ? Resources.colors.white
                  : Resources.colors.luxuryProgressTrack,
            ),
          ],
        ),
      ),
    );
  }
}
