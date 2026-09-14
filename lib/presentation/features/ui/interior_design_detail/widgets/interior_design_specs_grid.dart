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

  final InteriorDesignResponseModel? item;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    final specs = [
      if (item?.scope != null)
        InteriorDesignSpec(
          label: loc.interiorDesignScopeTitle,
          value: item?.scope?.localizedLabel(context) ?? '',
          icon: Icons.fullscreen,
        ),
      if (item?.budgetTier != null)
        InteriorDesignSpec(
          label: loc.interiorDesignBudgetTier,
          value: item?.budgetTier?.localizedLabel(context) ?? '',
          icon: Icons.monetization_on_outlined,
        ),
      if (item?.timeline != null)
        InteriorDesignSpec(
          label: loc.interiorDesignTimeline,
          value: item?.timeline?.localizedLabel(context) ?? '',
          icon: Icons.schedule_outlined,
        ),
      InteriorDesignSpec(
        label: loc.interiorDesignSpacePlanningTitle,
        value: (item?.spacePlanningRequired ?? false)
            ? loc.interiorDesignSpacePlanningIncluded
            : loc.notIncluded,
        icon: Icons.space_dashboard_outlined,
      ),
      if (item?.createdAt != null)
        InteriorDesignSpec(
          label: loc.specCreated,
          value: DateFormat(
            'dd MMM yyyy',
            Localizations.localeOf(context).languageCode,
          ).format(item?.createdAt ?? DateTime.now()),
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
        childAspectRatio: 8 / 3.6,
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

  final InteriorDesignSpec? spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$8,
        vertical: Resources.verticalDims.$10,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
        border: Border.all(color: Resources.colors.luxuryGoldBorder),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryGoldLight.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(Resources.radius.$r8),
            ),
            child: Icon(
              spec?.icon,
              size: Resources.iconSizes.$16,
              color: Resources.colors.luxuryGoldLight,
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$8),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spec?.label.toUpperCase() ?? '',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Resources.colors.luxuryBodyMuted,
                    letterSpacing: .8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$2),
                Text(
                  spec?.value ?? '',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Resources.colors.luxuryNavy,
                    fontWeight: Resources.fontWeights.semiBold,
                    fontSize: Resources.fontSizes.$12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
