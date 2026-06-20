import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/project_type_card.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  child: ProjectTypeCard(
                    label: t.label,
                    icon: t.icon,
                    description: t.description,
                    isSelected: state.selectedType == t.type,
                    onTap: () =>
                        context.read<ProjectCreationCubit>().selectProjectType(t.type),
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
