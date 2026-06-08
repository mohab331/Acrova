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
    this.floors,
    this.thumbnailUrl,
  });

  final String id;            // "ARC-2024-00018"
  final String name;
  final ProjectStatus status;
  final ProjectType type;
  final DateTime createdAt;
  final String? location;
  final double? landAreaSqm;
  final int? floors;
  final String? thumbnailUrl;

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
        floors:       json['floors']        as int?,
        thumbnailUrl: json['thumbnail_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id':            id,
        'name':          name,
        'status':        status.jsonKey,
        'type':          type.jsonKey,
        'created_at':    createdAt.toIso8601String(),
        'location':      location,
        'land_area':     landAreaSqm,
        'floors':        floors,
        'thumbnail_url': thumbnailUrl,
      };

  @override
  List<Object?> get props =>
      [id, name, status, type, createdAt, location, landAreaSqm, floors];
}
