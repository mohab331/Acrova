import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InteriorDesignSpec {
  final IconData icon;
  final String label;
  final String value;

  const InteriorDesignSpec({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class InteriorDesignSpecsGrid extends StatelessWidget {
  const InteriorDesignSpecsGrid({required this.item, super.key});

  final InteriorDesignResponseModel item;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    final specs = [
      if (item.scope != null)
        InteriorDesignSpec(
          label: loc.interiorDesignScopeTitle,
          value: item.scope!.localizedLabel(context),
          icon: Icons.fullscreen,
        ),
      if (item.budgetTier != null)
        InteriorDesignSpec(
          label: loc.interiorDesignBudgetTier,
          value: item.budgetTier!.localizedLabel(context),
          icon: Icons.monetization_on_outlined,
        ),
      if (item.timeline != null)
        InteriorDesignSpec(
          label: loc.interiorDesignTimeline,
          value: item.timeline!.localizedLabel(context),
          icon: Icons.schedule_outlined,
        ),
      InteriorDesignSpec(
        label: loc.interiorDesignSpacePlanningTitle,
        value: item.spacePlanningRequired
            ? loc.interiorDesignSpacePlanningIncluded
            : loc.notIncluded,
        icon: Icons.space_dashboard_outlined,
      ),
      InteriorDesignSpec(
        label: loc.interiorDesignRooms,
        value: item.specificRooms.isNotEmpty
            ? '${item.specificRooms.length} ${loc.interiorDesignRooms}'
            : loc.interiorDesignNoRoomsSpecified,
        icon: Icons.meeting_room_outlined,
      ),
      if (item.createdAt != null)
        InteriorDesignSpec(
          label: loc.specCreated,
          value: DateFormat(
            'dd MMM yyyy',
            Localizations.localeOf(context).languageCode,
          ).format(item.createdAt!),
          icon: Icons.calendar_today_outlined,
        ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: specs.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 8 / 3.4,
        crossAxisSpacing: Resources.horizontalDims.$8,
        mainAxisSpacing: Resources.verticalDims.$8,
      ),
      itemBuilder: (context, index) {
        return _SpecCard(spec: specs[index]);
      },
    );
  }
}

class _SpecCard extends StatelessWidget {
  const _SpecCard({required this.spec});

  final InteriorDesignSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        border: Border.all(color: Resources.colors.luxuryBorder),
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$12,
        vertical: Resources.verticalDims.$8,
      ),
      child: Row(
        children: [
          Icon(
            spec.icon,
            color: Resources.colors.luxuryNavy,
            size: Resources.fontSizes.$20,
          ),
          SizedBox(width: Resources.horizontalDims.$8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  spec.label,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: Resources.fontSizes.$10,
                    fontWeight: Resources.fontWeights.medium,
                    color: Resources.colors.luxuryBodyMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Resources.verticalDims.$2),
                Text(
                  spec.value,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: Resources.fontSizes.$12,
                    fontWeight: Resources.fontWeights.bold,
                    color: Resources.colors.luxuryInk,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
