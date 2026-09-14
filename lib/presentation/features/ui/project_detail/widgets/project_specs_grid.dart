import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectSpec {
  final IconData icon;
  final String label;
  final String value;

  const ProjectSpec({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class ProjectSpecsGrid extends StatelessWidget {
  const ProjectSpecsGrid({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final specs = [
      ProjectSpec(
        label: loc.specBedrooms,
        value: '${project.bedrooms}',
        icon: Icons.bed_outlined,
      ),
      ProjectSpec(
        label: loc.specBathrooms,
        value: '${project.bathrooms}',
        icon: Icons.bathtub_outlined,
      ),
      ProjectSpec(
        label: loc.specStyle,
        value: project.architecturalStyle?.localizedLabel(context) ?? '',
        icon: Icons.architecture_outlined,
      ),
      ProjectSpec(
        label: loc.specLand,
        value:
            '${project.landWidthM} × ${project.landLengthM} ${loc.unitMeter}',
        icon: Icons.straighten,
      ),
      ProjectSpec(
        label: loc.specCreated,
        value: DateFormat(
          'dd MMM yyyy',
          Localizations.localeOf(context).languageCode,
        ).format(project.createdAt ?? DateTime.now()),
        icon: Icons.calendar_today_outlined,
      ),
    ];
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 8 / 3.4,
        crossAxisSpacing: Resources.horizontalDims.$8,
        mainAxisSpacing: Resources.verticalDims.$8,
      ),
      children: specs
          .where((e) => e.value.trim().isNotEmpty && e.value != 'null')
          .map((e) => DetailFeatureChip(spec: e))
          .toList(),
    );
  }
}

class DetailFeatureChip extends StatelessWidget {
  const DetailFeatureChip({required this.spec, super.key});

  final ProjectSpec spec;

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
              spec.icon,
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
                  spec.label.toUpperCase(),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Resources.colors.luxuryBodyMuted,
                    letterSpacing: .8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$2),
                Text(
                  spec.value,
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
