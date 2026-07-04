import 'package:acrova/data/models/project/deliverable_model.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class InteriorDesignHeader extends StatelessWidget {
  const InteriorDesignHeader({
    required this.project,
    super.key,
  });

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
              Icon(Icons.business_center_outlined, color: Resources.colors.luxuryGoldLight),
              SizedBox(width: Resources.horizontalDims.$8),
              Text(
                'PROJECT SUMMARY',
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
              Icon(Icons.location_on_outlined, size: 16, color: Resources.colors.luxuryBody),
              SizedBox(width: Resources.horizontalDims.$4),
              Text(
                project.location?.isNotEmpty == true ? project.location! : 'Location Not Set',
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
          if (project.type == ProjectType.commercial && project.employeeCount != null) ...[
            _SummaryRow(
              icon: Icons.people_outline,
              label: 'Employee Count',
              value: '${project.employeeCount}',
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],
          if (project.bedrooms != null) ...[
            _SummaryRow(
              icon: Icons.bed_outlined,
              label: 'Bedrooms',
              value: '${project.bedrooms}',
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],
          if (project.bathrooms != null) ...[
            _SummaryRow(
              icon: Icons.bathtub_outlined,
              label: 'Bathrooms',
              value: '${project.bathrooms}',
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],
          _SummaryRow(
            icon: Icons.layers_outlined,
            label: 'Floors',
            value: '${project.floors ?? 1}',
          ),
          SizedBox(height: Resources.verticalDims.$12),
          if (project.landAreaSqm != null) ...[
            _SummaryRow(
              icon: Icons.square_foot_outlined,
              label: 'Area',
              value: '${project.landAreaSqm?.toStringAsFixed(0)} m²',
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],
          if (project.landWidthM != null && project.landLengthM != null) ...[
            _SummaryRow(
              icon: Icons.straighten_outlined,
              label: 'Dimensions',
              value: '${project.landWidthM?.toStringAsFixed(1)}m × ${project.landLengthM?.toStringAsFixed(1)}m',
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
              label: 'Architectural Style',
              value: project.architecturalStyle!,
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],

          if (project.smartHomeLevel != null) ...[
            _SummaryRow(
              icon: Icons.smart_toy_outlined,
              label: 'Smart Home',
              value: project.smartHomeLevel!,
            ),
            SizedBox(height: Resources.verticalDims.$12),
          ],

          // Deliverables Foldable Section
          if (project.deliverables.isNotEmpty) ...[
            Divider(color: Resources.colors.luxuryBorder),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                iconColor: Resources.colors.luxuryNavy,
                collapsedIconColor: Resources.colors.luxuryBody,
                title: Row(
                  children: [
                    Icon(Icons.folder_open_outlined, color: Resources.colors.luxuryNavy, size: 20),
                    SizedBox(width: Resources.horizontalDims.$8),
                    Text(
                      'Deliverables',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: Resources.fontWeights.semiBold,
                        color: Resources.colors.luxuryNavy,
                      ),
                    ),
                    SizedBox(width: Resources.horizontalDims.$8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${project.deliverables.length}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: Resources.fontWeights.bold,
                          color: Resources.colors.luxuryGoldLight,
                        ),
                      ),
                    ),
                  ],
                ),
                children: project.deliverables.map((d) => _DeliverableItem(deliverable: d)).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool _hasAnyAmenities(ProjectModel p) {
    return (p.hasMajlis == true) || (p.hasMaidRoom == true) || (p.hasDriverRoom == true) ||
           (p.hasBasement == true) || (p.hasPool == true) || (p.hasRooftop == true);
  }

  List<Widget> _buildAmenityChips(BuildContext context) {
    final chips = <Widget>[];
    void addChip(String label, IconData icon) {
      chips.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Resources.colors.luxurySurface,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Resources.colors.luxuryBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: Resources.colors.luxuryBody),
            SizedBox(width: Resources.horizontalDims.$4),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: Resources.colors.luxuryBody,
              ),
            ),
          ],
        ),
      ));
    }

    if (project.hasMajlis == true) addChip('Majlis', Icons.chair_outlined);
    if (project.hasMaidRoom == true) addChip('Maid Room', Icons.cleaning_services_outlined);
    if (project.hasDriverRoom == true) addChip('Driver Room', Icons.directions_car_outlined);
    if (project.hasBasement == true) addChip('Basement', Icons.stairs_outlined);
    if (project.hasPool == true) addChip('Pool', Icons.pool_outlined);
    if (project.hasRooftop == true) addChip('Rooftop', Icons.deck_outlined);

    return chips;
  }
}

class _DeliverableItem extends StatelessWidget {
  const _DeliverableItem({required this.deliverable});

  final DeliverableModel deliverable;

  IconData _getIcon() {
    switch (deliverable.type) {
      case DeliverableType.pdf: return Icons.picture_as_pdf_outlined;
      case DeliverableType.image: return Icons.image_outlined;
      case DeliverableType.video: return Icons.play_circle_outline;
      case DeliverableType.document: return Icons.description_outlined;
      default: return Icons.insert_drive_file_outlined;
    }
  }

  Color _getColor() {
    switch (deliverable.type) {
      case DeliverableType.pdf: return Colors.redAccent;
      case DeliverableType.image: return Colors.blueAccent;
      case DeliverableType.video: return Colors.purpleAccent;
      case DeliverableType.document: return Colors.orangeAccent;
      default: return Resources.colors.luxuryBody;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Resources.verticalDims.$12, left: Resources.horizontalDims.$12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(_getIcon(), size: 20, color: _getColor()),
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
                const SizedBox(height: 2),
                Text(
                  '${deliverable.createdAt.day}/${deliverable.createdAt.month}/${deliverable.createdAt.year}',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    color: Resources.colors.luxuryBody,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.download_outlined, size: 20, color: Resources.colors.luxuryGoldLight),
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
        Icon(icon, size: 18, color: Resources.colors.luxuryNavy),
        SizedBox(width: Resources.horizontalDims.$8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Resources.colors.luxuryBody,
              ),
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
