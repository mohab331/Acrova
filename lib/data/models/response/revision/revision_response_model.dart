import 'package:acrova/utils/enums/revision_category_enum.dart';
import 'package:acrova/utils/enums/revision_status_enum.dart';
import 'package:equatable/equatable.dart';

export 'package:acrova/utils/enums/revision_category_enum.dart';
export 'package:acrova/utils/enums/revision_status_enum.dart';

/// A customer revision response model (history item + detail).
class RevisionResponseModel extends Equatable {
  const RevisionResponseModel({
    this.id,
    this.status,
    this.category,
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
  final RevisionCategory? category;
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
        status: RevisionStatus.fromJson(json['status']),
        category: RevisionCategory.fromValue(json['category_id']?.toString()),
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
    'status_id': status?.id,
    'status': status?.id,
    if (category != null) ...{
      'category_id': category?.id,
      'category': category?.id,
    },
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
    RevisionCategory? category,
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
    category: category ?? this.category,
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
    category,
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
