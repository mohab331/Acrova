import 'package:acrova/utils/enums/revision_status_enum.dart';
import 'package:equatable/equatable.dart';

/// A customer revision response model (history item + detail).
class RevisionResponseModel extends Equatable {
  const RevisionResponseModel({
    this.id,
    this.status,
    this.createdAt,
    this.description,
    this.collaborators,
    this.engineerName,
    this.engineerRole,
    this.engineerNote,
    this.engineerAvatarUrl,
  });

  final String? id;
  final RevisionStatus? status;
  final DateTime? createdAt;
  final String? description;

  /// Collaborator initials shown as a stacked badge group (e.g. ["FA", "MK"]).
  final List<String>? collaborators;

  final String? engineerName;
  final String? engineerRole;
  final String? engineerNote;
  final String? engineerAvatarUrl;

  factory RevisionResponseModel.fromJson(Map<String, dynamic> json) =>
      RevisionResponseModel(
        id: json['id']?.toString(),
        status: json['status'] != null
            ? RevisionStatus.fromJson(json['status'].toString())
            : null,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'].toString())
            : null,
        description: json['description']?.toString(),
        collaborators: (json['collaborators'] as List?)
            ?.map((e) => e?.toString() ?? '')
            .toList(),
        engineerName: json['engineer_name']?.toString(),
        engineerRole: json['engineer_role']?.toString(),
        engineerNote: json['engineer_note']?.toString(),
        engineerAvatarUrl: json['engineer_avatar_url']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status?.jsonKey,
    'created_at': createdAt?.toIso8601String(),
    'description': description,
    'collaborators': collaborators,
    'engineer_name': engineerName,
    'engineer_role': engineerRole,
    'engineer_note': engineerNote,
    'engineer_avatar_url': engineerAvatarUrl,
  };

  RevisionResponseModel copyWith({
    String? id,
    RevisionStatus? status,
    DateTime? createdAt,
    String? description,
    List<String>? collaborators,
    String? engineerName,
    String? engineerRole,
    String? engineerNote,
    String? engineerAvatarUrl,
  }) => RevisionResponseModel(
    id: id ?? this.id,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    description: description ?? this.description,
    collaborators: collaborators ?? this.collaborators,
    engineerName: engineerName ?? this.engineerName,
    engineerRole: engineerRole ?? this.engineerRole,
    engineerNote: engineerNote ?? this.engineerNote,
    engineerAvatarUrl: engineerAvatarUrl ?? this.engineerAvatarUrl,
  );

  @override
  List<Object?> get props => [
    id,
    status,
    createdAt,
    description,
    collaborators,
    engineerName,
    engineerRole,
    engineerNote,
    engineerAvatarUrl,
  ];

  @override
  String toString() {
    return 'RevisionResponseModel('
        'id: $id, '
        'status: $status, '
        'createdAt: $createdAt'
        ')';
  }
}
