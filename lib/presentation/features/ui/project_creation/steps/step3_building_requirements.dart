import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

              // Bedrooms
              _RoomCounter(
                label: l10n.requirementsLabelBedrooms,
                icon: Icons.bed_outlined,
                count: state.bedrooms,
                onDecrement: () => cubit.updateBedrooms(state.bedrooms - 1),
                onIncrement: () => cubit.updateBedrooms(state.bedrooms + 1),
                min: 1,
                max: 20,
              ),
              SizedBox(height: Resources.verticalDims.$16),

              // Bathrooms
              _RoomCounter(
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

              _ToggleGrid(
                items: [
                  _ToggleItem(
                    icon: Icons.chair_outlined,
                    label: l10n.requirementsSpaceMajlis,
                    value: state.hasMajlis,
                    onChanged: cubit.toggleMajlis,
                  ),
                  _ToggleItem(
                    icon: Icons.person_outlined,
                    label: l10n.requirementsSpaceMaid,
                    value: state.hasMaidRoom,
                    onChanged: cubit.toggleMaidRoom,
                  ),
                  _ToggleItem(
                    icon: Icons.directions_car_outlined,
                    label: l10n.requirementsSpaceDriver,
                    value: state.hasDriverRoom,
                    onChanged: cubit.toggleDriverRoom,
                  ),
                  _ToggleItem(
                    icon: Icons.foundation_outlined,
                    label: l10n.requirementsSpaceBasement,
                    value: state.hasBasement,
                    onChanged: cubit.toggleBasement,
                  ),
                  _ToggleItem(
                    icon: Icons.pool_outlined,
                    label: l10n.requirementsSpacePool,
                    value: state.hasPool,
                    onChanged: cubit.togglePool,
                  ),
                  _ToggleItem(
                    icon: Icons.roofing_outlined,
                    label: l10n.requirementsSpaceRooftop,
                    value: state.hasRooftop,
                    onChanged: cubit.toggleRooftop,
                  ),
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

// ─── Room Counter ─────────────────────────────────────────────────────────────

class _RoomCounter extends StatelessWidget {
  const _RoomCounter({
    required this.label,
    required this.icon,
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
    required this.min,
    required this.max,
  });

  final String label;
  final IconData icon;
  final int count;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$16,
        vertical: Resources.verticalDims.$14,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: Resources.iconSizes.$20,
            color: Resources.colors.luxuryNavy,
          ),
          SizedBox(width: Resources.horizontalDims.$12),
          Expanded(
            child: Text(
              label,
              style: context.textTheme.labelLarge?.copyWith(
                    color: Resources.colors.luxuryInk,
                    fontWeight: Resources.fontWeights.medium,
                  ),
            ),
          ),
          _CountBtn(
            icon: Icons.remove,
            onTap: count > min ? onDecrement : null,
          ),
          SizedBox(width: Resources.horizontalDims.$16),
          SizedBox(
            width: 28.w,
            child: Center(
              child: Text(
                '$count',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: Resources.fontSizes.$16,
                      fontWeight: Resources.fontWeights.semiBold,
                      color: Resources.colors.luxuryNavy,
                    ),
              ),
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$16),
          _CountBtn(
            icon: Icons.add,
            onTap: count < max ? onIncrement : null,
          ),
        ],
      ),
    );
  }
}

class _CountBtn extends StatelessWidget {
  const _CountBtn({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25.r,
        height: 25.r,
        decoration: BoxDecoration(
          color: enabled
              ? Resources.colors.luxuryGold
              : Resources.colors.luxuryProgressTrack,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
        ),
        child: Icon(
          icon,
          size: Resources.iconSizes.$16,
          color: enabled
              ? Resources.colors.luxurySurface
              : Resources.colors.luxuryBodyMuted,
        ),
      ),
    );
  }
}

// ─── Toggle Grid ──────────────────────────────────────────────────────────────

class _ToggleItem {
  const _ToggleItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
}

class _ToggleGrid extends StatelessWidget {
  const _ToggleGrid({required this.items});

  final List<_ToggleItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Resources.horizontalDims.$12,
        mainAxisSpacing: Resources.verticalDims.$12,
        childAspectRatio: 2.4,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => _ToggleCard(item: items[i]),
    );
  }
}

class _ToggleCard extends StatelessWidget {
  const _ToggleCard({required this.item});

  final _ToggleItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => item.onChanged(!item.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$12,
        ),
        decoration: BoxDecoration(
          color: item.value
              ? Resources.colors.luxuryNavy
              : Resources.colors.luxurySurface,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          border: Border.all(
            color: item.value
                ? Resources.colors.luxuryNavy
                : Resources.colors.luxuryBorder,
          ),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: Resources.iconSizes.$18,
              color: item.value
                  ? Resources.colors.luxuryGoldLight
                  : Resources.colors.luxuryBodyMuted,
            ),
            SizedBox(width: Resources.horizontalDims.$8),
            Expanded(
              child: Text(
                item.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: Resources.fontSizes.$12,
                      fontWeight: Resources.fontWeights.semiBold,
                      color: item.value
                          ? Resources.colors.luxurySurface
                          : Resources.colors.luxuryInk,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
