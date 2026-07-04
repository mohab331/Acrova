import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/cards/app_card.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    required this.projectsCount,
    required this.completedCount,
    super.key,
  });

  final int projectsCount;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: '$projectsCount',
            label: loc.profileStatProjects,
            valueColor: Resources.colors.luxuryGoldLight,
          ),
        ),
        SizedBox(width: Resources.horizontalDims.$12),
        Expanded(
          child: _StatCard(
            value: '$completedCount',
            label: loc.profileStatCompleted,
            valueColor: Resources.colors.luxurySuccess,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(Resources.horizontalDims.$16),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: Resources.fonts.notoSerif,
              fontSize: Resources.fontSizes.$26,
              fontWeight: Resources.fontWeights.bold,
              color: valueColor,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$4),
          Text(
            label,
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$12,
              color: Resources.colors.luxuryBodyMuted,
              letterSpacing: Resources.letterSpacing.$0_4,
            ),
          ),
        ],
      ),
    );
  }
}
