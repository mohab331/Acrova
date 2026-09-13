import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/project_creation/cubit/project_creation_cubit.dart';
import 'package:acrova/presentation/features/ui/project_creation/cubit/project_creation_state.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/room_counter.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/toggle_grid.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/toggle_item.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/enums/smart_home_level_enum.dart';
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

        final isCommercial = state.selectedType == ProjectType.commercial;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$20,
            vertical: Resources.verticalDims.$24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isCommercial) ...[
                RoomCounter(
                  label: l10n.requirementsLabelBedrooms,
                  icon: Icons.bed_outlined,
                  count: state.bedrooms,
                  min: 1,
                  max: 20,
                  onDecrement: () => cubit.updateBedrooms(state.bedrooms - 1),
                  onIncrement: () => cubit.updateBedrooms(state.bedrooms + 1),
                ),
                SizedBox(height: Resources.verticalDims.$16),
                RoomCounter(
                  label: l10n.requirementsLabelBathrooms,
                  icon: Icons.bathtub_outlined,
                  count: state.bathrooms,
                  min: 1,
                  max: 20,
                  onDecrement: () => cubit.updateBathrooms(state.bathrooms - 1),
                  onIncrement: () => cubit.updateBathrooms(state.bathrooms + 1),
                ),
                SizedBox(height: Resources.verticalDims.$24),
              ],
              Text(
                l10n.requirementsLabelAdditionalSpaces,
                style: context.textTheme.labelMedium?.copyWith(
                  color: Resources.colors.luxuryBody,
                  letterSpacing: Resources.letterSpacing.$1_2,
                  fontWeight: Resources.fontWeights.semiBold,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$12),
              ToggleGrid(
                items: [
                  ToggleItem(
                    label: l10n.requirementsSpaceMajlis,
                    icon: Icons.chair_outlined,
                    value: state.hasMajlis,
                    onChanged: cubit.toggleMajlis,
                  ),
                  ToggleItem(
                    label: l10n.requirementsSpaceMaid,
                    icon: Icons.cleaning_services_outlined,
                    value: state.hasMaidRoom,
                    onChanged: cubit.toggleMaidRoom,
                  ),
                  ToggleItem(
                    label: l10n.requirementsSpaceDriver,
                    icon: Icons.directions_car_outlined,
                    value: state.hasDriverRoom,
                    onChanged: cubit.toggleDriverRoom,
                  ),
                  ToggleItem(
                    label: l10n.requirementsSpaceBasement,
                    icon: Icons.stairs_outlined,
                    value: state.hasBasement,
                    onChanged: cubit.toggleBasement,
                  ),
                  ToggleItem(
                    label: l10n.requirementsSpacePool,
                    icon: Icons.pool_outlined,
                    value: state.hasPool,
                    onChanged: cubit.togglePool,
                  ),
                  ToggleItem(
                    label: l10n.requirementsSpaceRooftop,
                    icon: Icons.deck_outlined,
                    value: state.hasRooftop,
                    onChanged: cubit.toggleRooftop,
                  ),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$24),
              Text(
                l10n.requirementsLabelSmartHome,
                style: context.textTheme.labelMedium?.copyWith(
                  color: Resources.colors.luxuryBody,
                  letterSpacing: Resources.letterSpacing.$1_2,
                  fontWeight: Resources.fontWeights.semiBold,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$12),
              Container(
                decoration: BoxDecoration(
                  color: Resources.colors.luxurySurface,
                  borderRadius: BorderRadius.circular(Resources.radius.$r12),
                  border: Border.all(color: Resources.colors.luxuryBorder),
                ),
                child: RadioGroup<SmartHomeLevel>(
                  groupValue: state.smartHomeLevelEnum ?? SmartHomeLevel.basic,
                  onChanged: (v) {
                    if (v != null) cubit.setSmartHomeLevel(v);
                  },
                  child: Column(
                    children: [
                      for (
                        int i = 0;
                        i < SmartHomeLevel.values.length;
                        i++
                      ) ...[
                        RadioListTile<SmartHomeLevel>(
                          title: Text(
                            SmartHomeLevel.values[i].localizedLabel(context),
                          ),
                          value: SmartHomeLevel.values[i],
                          activeColor: Resources.colors.luxuryNavy,
                        ),
                        if (i < SmartHomeLevel.values.length - 1)
                          Divider(
                            height: 1,
                            color: Resources.colors.luxuryBorder,
                          ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: Resources.verticalDims.$24),
            ],
          ),
        );
      },
    );
  }
}
