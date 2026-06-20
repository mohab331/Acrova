import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/room_counter.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/toggle_grid.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/toggle_item.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step3BuildingRequirements extends StatelessWidget {
  const Step3BuildingRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCreationCubit, ProjectCreationState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCreationCubit>();
        final l10n = context.localization;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.requirementsTitle,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.semiBold,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.requirementsSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Resources.colors.luxuryBody,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$32),
              RoomCounter(
                label: l10n.requirementsLabelBedrooms,
                icon: Icons.bed_outlined,
                count: state.bedrooms,
                onDecrement: () => cubit.updateBedrooms(state.bedrooms - 1),
                onIncrement: () => cubit.updateBedrooms(state.bedrooms + 1),
                min: 1,
                max: 20,
              ),
              SizedBox(height: Resources.verticalDims.$16),
              RoomCounter(
                label: l10n.requirementsLabelBathrooms,
                icon: Icons.bathroom_outlined,
                count: state.bathrooms,
                onDecrement: () => cubit.updateBathrooms(state.bathrooms - 1),
                onIncrement: () => cubit.updateBathrooms(state.bathrooms + 1),
                min: 1,
                max: 20,
              ),
              SizedBox(height: Resources.verticalDims.$28),
              Text(
                l10n.requirementsLabelAdditionalSpaces,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Resources.colors.luxuryBody,
                    ),
              ),
              SizedBox(height: Resources.verticalDims.$12),
              ToggleGrid(
                items: [
                  ToggleItem(icon: Icons.chair_outlined, label: l10n.requirementsSpaceMajlis, value: state.hasMajlis, onChanged: cubit.toggleMajlis),
                  ToggleItem(icon: Icons.person_outlined, label: l10n.requirementsSpaceMaid, value: state.hasMaidRoom, onChanged: cubit.toggleMaidRoom),
                  ToggleItem(icon: Icons.directions_car_outlined, label: l10n.requirementsSpaceDriver, value: state.hasDriverRoom, onChanged: cubit.toggleDriverRoom),
                  ToggleItem(icon: Icons.foundation_outlined, label: l10n.requirementsSpaceBasement, value: state.hasBasement, onChanged: cubit.toggleBasement),
                  ToggleItem(icon: Icons.pool_outlined, label: l10n.requirementsSpacePool, value: state.hasPool, onChanged: cubit.togglePool),
                  ToggleItem(icon: Icons.roofing_outlined, label: l10n.requirementsSpaceRooftop, value: state.hasRooftop, onChanged: cubit.toggleRooftop),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$24),
            ],
          ),
        );
      },
    );
  }
}
