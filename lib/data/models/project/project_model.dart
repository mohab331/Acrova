import 'package:acrova/data/models/project/deliverable_model.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:equatable/equatable.dart';

/// Immutable read model for a customer project.
///
/// ID format: ARC-YYYY-XXXXX (SRS business rule).
class ProjectModel extends Equatable {
  const ProjectModel({
    required this.id,
    required this.name,
    required this.status,
    required this.type,
    required this.createdAt,
    this.location,
    this.landAreaSqm,
    this.landWidthM,
    this.landLengthM,
    this.floors,
    this.employeeCount,
    this.bedrooms,
    this.bathrooms,
    this.hasMajlis,
    this.hasMaidRoom,
    this.hasDriverRoom,
    this.hasBasement,
    this.hasPool,
    this.hasRooftop,
    this.smartHomeLevel,
    this.architecturalStyle,
    this.thumbnailUrl,
    this.deliverables = const [],
  });

  final String id;            // "ARC-2024-00018"
  final String name;
  final ProjectStatus status;
  final ProjectType type;
  final DateTime createdAt;
  final String? location;
  final double? landAreaSqm;
  final double? landWidthM;
  final double? landLengthM;
  final int? floors;
  final int? employeeCount;
  final int? bedrooms;
  final int? bathrooms;
  final bool? hasMajlis;
  final bool? hasMaidRoom;
  final bool? hasDriverRoom;
  final bool? hasBasement;
  final bool? hasPool;
  final bool? hasRooftop;
  final String? smartHomeLevel;
  final String? architecturalStyle;
  final String? thumbnailUrl;
  final List<DeliverableModel> deliverables;

  /// Progress ratio [0.0 – 1.0] derived from current [status].
  double get progressRatio => status.progressRatio;

  /// Human-readable progress percentage string, e.g. "33%".
  String get progressLabel => '${(progressRatio * 100).round()}%';

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id:           json['id']   as String,
        name:         json['name'] as String,
        status:       ProjectStatusX.fromJson(json['status'] as String),
        type:         ProjectTypeX.fromJson(json['type'] as String? ?? ''),
        createdAt:    DateTime.parse(json['created_at'] as String),
        location:     json['location']      as String?,
        landAreaSqm:  (json['land_area']    as num?)?.toDouble(),
        landWidthM:   (json['land_width']   as num?)?.toDouble(),
        landLengthM:  (json['land_length']  as num?)?.toDouble(),
        floors:       json['floors']        as int?,
        employeeCount: json['employee_count'] as int?,
        bedrooms:     json['bedrooms']      as int?,
        bathrooms:    json['bathrooms']     as int?,
        hasMajlis:    json['has_majlis']    as bool?,
        hasMaidRoom:  json['has_maid_room'] as bool?,
        hasDriverRoom: json['has_driver_room'] as bool?,
        hasBasement:  json['has_basement']  as bool?,
        hasPool:      json['has_pool']      as bool?,
        hasRooftop:   json['has_rooftop']   as bool?,
        smartHomeLevel: json['smart_home_level'] as String?,
        architecturalStyle: json['architectural_style'] as String?,
        thumbnailUrl: json['thumbnail_url'] as String?,
        deliverables: (json['deliverables'] as List<dynamic>?)
                ?.map((e) => DeliverableModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => {
        'id':            id,
        'name':          name,
        'status':        status.jsonKey,
        'type':          type.jsonKey,
        'created_at':    createdAt.toIso8601String(),
        'location':      location,
        'land_area':     landAreaSqm,
        'land_width':    landWidthM,
        'land_length':   landLengthM,
        'floors':        floors,
        'employee_count': employeeCount,
        'bedrooms':      bedrooms,
        'bathrooms':     bathrooms,
        'has_majlis':    hasMajlis,
        'has_maid_room': hasMaidRoom,
        'has_driver_room': hasDriverRoom,
        'has_basement':  hasBasement,
        'has_pool':      hasPool,
        'has_rooftop':   hasRooftop,
        'smart_home_level': smartHomeLevel,
        'architectural_style': architecturalStyle,
        'thumbnail_url': thumbnailUrl,
        'deliverables':  deliverables.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id, name, status, type, createdAt, location, landAreaSqm, landWidthM, landLengthM,
        floors, employeeCount, bedrooms, bathrooms, hasMajlis, hasMaidRoom, hasDriverRoom,
        hasBasement, hasPool, hasRooftop, smartHomeLevel, architecturalStyle,
        thumbnailUrl, deliverables,
      ];
}
