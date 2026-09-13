import 'package:acrova/data/models/project/deliverable_model.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:equatable/equatable.dart';

/// Immutable read model for a customer project.
///
/// ID format: ARC-YYYY-XXXXX (SRS business rule).
class ProjectModel extends Equatable {
  const ProjectModel({
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
    this.description,
    this.engineer,
    this.provisions,
    this.estimatedTimeline,
  });

  final String? id;
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
  final String? smartHomeLevel;
  // Design preferences
  final String? architecturalStyle;
  // Media
  final String? thumbnailUrl;
  // Project details
  final List<DeliverableModel>? deliverables;
  final String? description;
  final EngineerModel? engineer;
  final List<String>? provisions;
  final String? estimatedTimeline;

  double get progressRatio => status?.progressRatio ?? 0.0;

  String get progressLabel => '${(progressRatio * 100).round()}%';

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),

      status: json['status'] != null
          ? ProjectStatusX.fromJson(json['status'].toString())
          : null,

      type: json['type'] != null
          ? ProjectType.fromJson(json['type'].toString())
          : null,

      createdAt: _parseDateTime(json['created_at']),

      location: json['location']?.toString(),

      landAreaSqm: _parseDouble(json['land_area_sqm'] ?? json['land_area']),

      landWidthM: _parseDouble(json['land_width_m'] ?? json['land_width']),

      landLengthM: _parseDouble(json['land_length_m'] ?? json['land_length']),

      floors: _parseInt(json['floors']),

      employeeCount: _parseInt(json['employee_count']),

      bedrooms: _parseInt(json['bedrooms']),

      bathrooms: _parseInt(json['bathrooms']),

      hasMajlis: _parseBool(json['has_majlis']),

      hasMaidRoom: _parseBool(json['has_maid_room']),

      hasDriverRoom: _parseBool(json['has_driver_room']),

      hasBasement: _parseBool(json['has_basement']),

      hasPool: _parseBool(json['has_pool']),

      hasRooftop: _parseBool(json['has_rooftop']),

      smartHomeLevel: json['smart_home_level']?.toString(),

      architecturalStyle: json['architectural_style']?.toString(),

      thumbnailUrl: json['thumbnail_url']?.toString(),

      deliverables: _parseList(
        json['deliverables'],
        (item) => DeliverableModel.fromJson(item),
      ),

      description: json['description']?.toString(),

      engineer: json['engineer'] is Map
          ? EngineerModel.fromJson(Map<String, dynamic>.from(json['engineer']))
          : null,

      provisions: _parseStringList(json['provisions']),

      estimatedTimeline: json['estimated_timeline']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status?.jsonKey,
      'type': type?.jsonKey,
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
      'smart_home_level': smartHomeLevel,

      'architectural_style': architecturalStyle,

      'thumbnail_url': thumbnailUrl,

      'deliverables': deliverables?.map((e) => e.toJson()).toList(),

      'description': description,

      'engineer': engineer?.toJson(),

      'provisions': provisions,

      'estimated_timeline': estimatedTimeline,
    };
  }

  @override
  List<Object?> get props => [
    id,
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
    description,
    engineer,
    provisions,
    estimatedTimeline,
  ];

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString());
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value.toString());
  }

  static bool? _parseBool(dynamic value) {
    if (value == null) return null;

    if (value is bool) {
      return value;
    }

    if (value is num) {
      return value != 0;
    }

    final stringValue = value.toString().toLowerCase();

    if (stringValue == 'true' || stringValue == '1') {
      return true;
    }

    if (stringValue == 'false' || stringValue == '0') {
      return false;
    }

    return null;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;

    return DateTime.tryParse(value.toString());
  }

  static List<T>? _parseList<T>(
    dynamic value,
    T Function(Map<String, dynamic>) mapper,
  ) {
    if (value is! List) {
      return null;
    }

    return value
        .whereType<Map>()
        .map((item) => mapper(Map<String, dynamic>.from(item)))
        .toList();
  }

  static List<String>? _parseStringList(dynamic value) {
    if (value is! List) {
      return null;
    }

    return value.map((item) => item.toString()).toList();
  }
}

class EngineerModel extends Equatable {
  const EngineerModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatarUrl,
    this.specialization,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final String? specialization;

  factory EngineerModel.fromJson(Map<String, dynamic> json) {
    return EngineerModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      avatarUrl: json['avatar_url']?.toString(),
      specialization: json['specialization']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'specialization': specialization,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    avatarUrl,
    specialization,
  ];
}
