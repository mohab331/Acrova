import 'package:acrova/utils/enums/design_style_enum.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/enums/smart_home_level_enum.dart';
import 'package:equatable/equatable.dart';

import 'deliverable_response_model.dart';
import 'engineer_response_model.dart';

/// Immutable read model for a customer project.
///
/// ID format: ARC-YYYY-XXXXX (SRS business rule).
class ProjectResponseModel extends Equatable {
  const ProjectResponseModel({
    this.id,
    this.name,
    this.status,
    this.type,
    this.createdAt,
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
    this.deliverables,
    this.additionalNotes,
    this.engineer,
    this.estimatedTimeline,
    this.interiorDesignId,
  });

  final String? id;
  final String? interiorDesignId;
  final String? name;
  final ProjectStatus? status;
  final ProjectType? type;
  final DateTime? createdAt;

  // Land details
  final String? location;
  final double? landAreaSqm;
  final double? landWidthM;
  final double? landLengthM;
  final int? floors;
  final int? employeeCount;

  // Building requirements
  final int? bedrooms;
  final int? bathrooms;
  final bool? hasMajlis;
  final bool? hasMaidRoom;
  final bool? hasDriverRoom;
  final bool? hasBasement;
  final bool? hasPool;
  final bool? hasRooftop;
  final SmartHomeLevel? smartHomeLevel;

  // Design preferences
  final DesignStyle? architecturalStyle;

  // Media
  final String? thumbnailUrl;

  // Project details

  final List<DeliverableResponseModel>? deliverables;
  final String? additionalNotes;
  final EngineerResponseModel? engineer;
  final String? estimatedTimeline;

  double get progressRatio => status?.progressRatio ?? 0.0;

  String get progressLabel => '${(progressRatio * 100).round()}%';

  factory ProjectResponseModel.fromJson(Map<String, dynamic> json) {
    return ProjectResponseModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      status: ProjectStatus.fromId(int.tryParse(json['status_id'].toString())),
      type: ProjectType.fromJson(json['type_id']),
      createdAt: DateTime.tryParse(json['created_at'].toString()),
      location: json['location']?.toString(),
      landAreaSqm: double.tryParse(json['land_area_sqm'].toString()),
      landWidthM: double.tryParse(json['land_width_m'].toString()),
      landLengthM: double.tryParse(json['land_length_m'].toString()),
      floors: int.tryParse(json['floors'].toString()),
      employeeCount: int.tryParse(json['employee_count'].toString()),
      bedrooms: int.tryParse(json['bedrooms'].toString()),
      bathrooms: int.tryParse(json['bathrooms'].toString()),
      hasMajlis: bool.tryParse(json['has_majlis'].toString()),
      hasMaidRoom: bool.tryParse(json['has_maid_room'].toString()),
      hasDriverRoom: bool.tryParse(json['has_driver_room'].toString()),
      hasBasement: bool.tryParse(json['has_basement'].toString()),
      hasPool: bool.tryParse(json['has_pool'].toString()),
      hasRooftop: bool.tryParse(json['has_rooftop'].toString()),
      smartHomeLevel: SmartHomeLevel.fromValue(json['smart_home_level_id']),
      architecturalStyle: DesignStyle.fromValue(json['architectural_style_id']),
      thumbnailUrl: json['thumbnail_url']?.toString(),
      deliverables: _parseList(
        json['deliverables'],
        DeliverableResponseModel.fromJson,
      ),
      additionalNotes: json['additionalNotes']?.toString(),
      engineer: json['engineer'] is Map
          ? EngineerResponseModel.fromJson(
              Map<String, dynamic>.from(json['engineer'] as Map),
            )
          : null,
      estimatedTimeline: json['estimated_timeline']?.toString(),
      interiorDesignId: json['interior_design_id'] as String? ??
          json['interiorDesignId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'interior_design_id': interiorDesignId,
      'name': name,
      'status_id': status?.id,
      'status': status?.id,
      'type_id': type?.id,
      'type': type?.id,
      'created_at': createdAt?.toIso8601String(),
      'location': location,
      'land_area_sqm': landAreaSqm,
      'land_width_m': landWidthM,
      'land_length_m': landLengthM,
      'floors': floors,
      'employee_count': employeeCount,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'has_majlis': hasMajlis,
      'has_maid_room': hasMaidRoom,
      'has_driver_room': hasDriverRoom,
      'has_basement': hasBasement,
      'has_pool': hasPool,
      'has_rooftop': hasRooftop,
      'smart_home_level_id': smartHomeLevel?.id,
      'smart_home_level': smartHomeLevel?.id,
      'architectural_style_id': architecturalStyle?.id,
      'architectural_style': architecturalStyle?.id,
      'thumbnail_url': thumbnailUrl,
      'deliverables': deliverables?.map((e) => e.toJson()).toList(),
      'additionalNotes': additionalNotes,
      'engineer': engineer?.toJson(),
      'estimated_timeline': estimatedTimeline,
    };
  }

  ProjectResponseModel copyWith({
    String? id,
    String? name,
    ProjectStatus? status,
    ProjectType? type,
    DateTime? createdAt,
    String? location,
    double? landAreaSqm,
    double? landWidthM,
    double? landLengthM,
    int? floors,
    int? employeeCount,
    int? bedrooms,
    int? bathrooms,
    bool? hasMajlis,
    bool? hasMaidRoom,
    bool? hasDriverRoom,
    bool? hasBasement,
    bool? hasPool,
    bool? hasRooftop,
    SmartHomeLevel? smartHomeLevel,
    DesignStyle? architecturalStyle,
    String? thumbnailUrl,
    List<DeliverableResponseModel>? deliverables,
    String? additionalNotes,
    EngineerResponseModel? engineer,
    String? estimatedTimeline,
    String? interiorDesignId,
  }) {
    return ProjectResponseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      location: location ?? this.location,
      landAreaSqm: landAreaSqm ?? this.landAreaSqm,
      landWidthM: landWidthM ?? this.landWidthM,
      landLengthM: landLengthM ?? this.landLengthM,
      floors: floors ?? this.floors,
      employeeCount: employeeCount ?? this.employeeCount,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      hasMajlis: hasMajlis ?? this.hasMajlis,
      hasMaidRoom: hasMaidRoom ?? this.hasMaidRoom,
      hasDriverRoom: hasDriverRoom ?? this.hasDriverRoom,
      hasBasement: hasBasement ?? this.hasBasement,
      hasPool: hasPool ?? this.hasPool,
      hasRooftop: hasRooftop ?? this.hasRooftop,
      smartHomeLevel: smartHomeLevel ?? this.smartHomeLevel,
      architecturalStyle: architecturalStyle ?? this.architecturalStyle,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      deliverables: deliverables ?? this.deliverables,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      engineer: engineer ?? this.engineer,
      estimatedTimeline: estimatedTimeline ?? this.estimatedTimeline,
      interiorDesignId: interiorDesignId ?? this.interiorDesignId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    interiorDesignId,
    name,
    status,
    type,
    createdAt,
    location,
    landAreaSqm,
    landWidthM,
    landLengthM,
    floors,
    employeeCount,
    bedrooms,
    bathrooms,
    hasMajlis,
    hasMaidRoom,
    hasDriverRoom,
    hasBasement,
    hasPool,
    hasRooftop,
    smartHomeLevel,
    architecturalStyle,
    thumbnailUrl,
    deliverables,
    additionalNotes,
    engineer,
    estimatedTimeline,
  ];

  static List<T>? _parseList<T>(
    dynamic value,
    T Function(Map<String, dynamic>) mapper,
  ) {
    if (value is! List) return null;
    return value
        .whereType<Map>()
        .map((item) => mapper(Map<String, dynamic>.from(item)))
        .toList();
  }

  @override
  String toString() {
    return 'ProjectResponseModel('
        'id: $id, '
        'name: $name, '
        'status: $status, '
        'type: $type'
        ')';
  }
}
