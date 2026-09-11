import 'package:acrova/data/models/project/deliverable_model.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/formatters/app_formatter.dart';
import 'package:flutter/material.dart';

class InteriorDesignHeader extends StatelessWidget {
  const InteriorDesignHeader({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Resources.horizontalDims.$20),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
        border: Border.all(color: Resources.colors.luxuryBorder),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.business_center_outlined,
                color: Resources.colors.luxuryGoldLight,
              ),
              SizedBox(width: Resources.horizontalDims.$8),
              Text(
                l10n.interiorDesignProjectSummary,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: Resources.fontWeights.bold,
                  letterSpacing: 1.2,
                  color: Resources.colors.luxuryGoldLight,
                ),
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Text(
            project.name.isNotEmpty ? project.name : l10n.projectTypeVillaLabel,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$8),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: Resources.iconSizes.$16,
                color: Resources.colors.luxuryBody,
              ),
              SizedBox(width: Resources.horizontalDims.$4),
              Text(
                project.location?.isNotEmpty == true
                    ? project.location!
                    : l10n.interiorDesignLocationNotSet,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Resources.colors.luxuryBody,
                ),
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Divider(color: Resources.colors.luxuryBorder),
          SizedBox(height: Resources.verticalDims.$16),

          // Core Specs
          if (project.type == ProjectType.commercial &&
              project.employeeCount != null) ...[
            _SummaryRow(
              icon: Icons.people_outline,
              label: l10n.specEmployeeCount,
              value: '${project.employeeCount}',
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],
          if (project.bedrooms != null) ...[
            _SummaryRow(
              icon: Icons.bed_outlined,
              label: l10n.specBedrooms,
              value: '${project.bedrooms}',
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],
          if (project.bathrooms != null) ...[
            _SummaryRow(
              icon: Icons.bathtub_outlined,
              label: l10n.specBathrooms,
              value: '${project.bathrooms}',
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],
          _SummaryRow(
            icon: Icons.layers_outlined,
            label: l10n.specFloors,
            value: '${project.floors ?? 1}',
          ),
          SizedBox(height: Resources.verticalDims.$12),
          if (project.landAreaSqm != null) ...[
            _SummaryRow(
              icon: Icons.square_foot_outlined,
              label: l10n.specArea,
              value: '${project.landAreaSqm?.toStringAsFixed(0)} m²',
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],
          if (project.landWidthM != null && project.landLengthM != null) ...[
            _SummaryRow(
              icon: Icons.straighten_outlined,
              label: l10n.specDimensions,
              value:
                  '${project.landWidthM?.toStringAsFixed(1)}m × ${project.landLengthM?.toStringAsFixed(1)}m',
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],

          // Amenities (Wrap)
          if (_hasAnyAmenities(project)) ...[
            SizedBox(height: Resources.verticalDims.$4),
            Wrap(
              spacing: Resources.horizontalDims.$8,
              runSpacing: Resources.verticalDims.$8,
              children: _buildAmenityChips(context),
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],

          if (project.architecturalStyle != null) ...[
            _SummaryRow(
              icon: Icons.architecture_outlined,
              label: l10n.specArchitecturalStyle,
              value: project.architecturalStyle!,
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],

          if (project.smartHomeLevel != null) ...[
            _SummaryRow(
              icon: Icons.smart_toy_outlined,
              label: l10n.specSmartHome,
              value: project.smartHomeLevel!,
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],

          // Deliverables Foldable Section
          if (project.deliverables.isNotEmpty) ...[
            Divider(color: Resources.colors.luxuryBorder),
            Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Resources.colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                iconColor: Resources.colors.luxuryNavy,
                collapsedIconColor: Resources.colors.luxuryBody,
                title: Row(
                  children: [
                    Icon(
                      Icons.folder_open_outlined,
                      color: Resources.colors.luxuryNavy,
                      size: Resources.iconSizes.$20,
                    ),
                    SizedBox(width: Resources.horizontalDims.$8),
                    Text(
                      l10n.deliverablesTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: Resources.fontWeights.semiBold,
                        color: Resources.colors.luxuryNavy,
                      ),
                    ),
                    SizedBox(width: Resources.horizontalDims.$8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Resources.horizontalDims.$6,
                        vertical: Resources.verticalDims.$2,
                      ),
                      decoration: BoxDecoration(
                        color: Resources.colors.luxuryGoldLight.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(
                          Resources.radius.$r10,
                        ),
                      ),
                      child: Text(
                        '${project.deliverables.length}',
                        style: TextStyle(
                          fontSize: Resources.fontSizes.$10,
                          fontWeight: Resources.fontWeights.bold,
                          color: Resources.colors.luxuryGoldLight,
                        ),
                      ),
                    ),
                  ],
                ),
                children: project.deliverables
                    .map((d) => _DeliverableItem(deliverable: d))
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool _hasAnyAmenities(ProjectModel p) {
    return (p.hasMajlis == true) ||
        (p.hasMaidRoom == true) ||
        (p.hasDriverRoom == true) ||
        (p.hasBasement == true) ||
        (p.hasPool == true) ||
        (p.hasRooftop == true);
  }

  List<Widget> _buildAmenityChips(BuildContext context) {
    final l10n = context.localization;
    final chips = <Widget>[];
    void addChip(String label, IconData icon) {
      chips.add(
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$8,
            vertical: Resources.verticalDims.$4,
          ),
          decoration: BoxDecoration(
            color: Resources.colors.luxurySurface,
            borderRadius: BorderRadius.circular(Resources.radius.$r4),
            border: Border.all(color: Resources.colors.luxuryBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: Resources.iconSizes.$12,
                color: Resources.colors.luxuryBody,
              ),
              SizedBox(width: Resources.horizontalDims.$4),
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: Resources.fontSizes.$10,
                  color: Resources.colors.luxuryBody,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (project.hasMajlis == true) {
      addChip(l10n.requirementsSpaceMajlis, Icons.chair_outlined);
    }
    if (project.hasMaidRoom == true) {
      addChip(l10n.requirementsSpaceMaid, Icons.cleaning_services_outlined);
    }
    if (project.hasDriverRoom == true) {
      addChip(l10n.requirementsSpaceDriver, Icons.directions_car_outlined);
    }
    if (project.hasBasement == true) {
      addChip(l10n.requirementsSpaceBasement, Icons.stairs_outlined);
    }
    if (project.hasPool == true) {
      addChip(l10n.requirementsSpacePool, Icons.pool_outlined);
    }
    if (project.hasRooftop == true) {
      addChip(l10n.requirementsSpaceRooftop, Icons.deck_outlined);
    }

    return chips;
  }
}

class _DeliverableItem extends StatelessWidget {
  const _DeliverableItem({required this.deliverable});

  final DeliverableModel deliverable;

  IconData _getIcon() {
    switch (deliverable.type) {
      case DeliverableType.pdf:
        return Icons.picture_as_pdf_outlined;
      case DeliverableType.image:
        return Icons.image_outlined;
      case DeliverableType.video:
        return Icons.play_circle_outline;
      case DeliverableType.document:
        return Icons.description_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  Color _getColor() {
    switch (deliverable.type) {
      case DeliverableType.pdf:
        return Resources.colors.filePdf;
      case DeliverableType.image:
        return Resources.colors.fileImage;
      case DeliverableType.video:
        return Resources.colors.fileVideo;
      case DeliverableType.document:
        return Resources.colors.fileDocument;
      default:
        return Resources.colors.luxuryBody;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = AppFormatter.formatDate(
      deliverable.createdAt,
      locale: Localizations.localeOf(context).languageCode,
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: Resources.verticalDims.$12,
        left: Resources.horizontalDims.$12,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Resources.squareDims.$8),
            decoration: BoxDecoration(
              color: _getColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Resources.radius.$r8),
            ),
            child: Icon(
              _getIcon(),
              size: Resources.iconSizes.$20,
              color: _getColor(),
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deliverable.title,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$2),
                Text(
                  formattedDate ?? '',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: Resources.fontSizes.$10,
                    color: Resources.colors.luxuryBody,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.download_outlined,
            size: Resources.iconSizes.$20,
            color: Resources.colors.luxuryGoldLight,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: Resources.iconSizes.$18,
          color: Resources.colors.luxuryNavy,
        ),
        SizedBox(width: Resources.horizontalDims.$8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Resources.colors.luxuryBody),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
          ),
        ),
      ],
    );
  }
}
