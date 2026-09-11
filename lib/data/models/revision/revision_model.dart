import 'package:acrova/utils/enums/revision_status_enum.dart';
import 'package:equatable/equatable.dart';

/// A customer revision request (history item + detail).
class RevisionModel extends Equatable {
  const RevisionModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.description,
    this.collaborators = const [],
    this.engineerName,
    this.engineerRole,
    this.engineerNote,
    this.engineerAvatarUrl,
  });

  final String id; // e.g. "REV-003"
  final RevisionStatus status;
  final DateTime createdAt;
  final String description;

  /// Collaborator initials shown as a stacked badge group (e.g. ["FA", "MK"]).
  final List<String> collaborators;

  final String? engineerName;
  final String? engineerRole;
  final String? engineerNote;
  final String? engineerAvatarUrl;

  factory RevisionModel.fromJson(Map<String, dynamic> json) => RevisionModel(
        id: json['id'] as String,
        status: RevisionStatusX.fromJson(json['status'] as String? ?? ''),
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
            DateTime.now(),
        description: json['description'] as String? ?? '',
        collaborators:
            (json['collaborators'] as List?)?.cast<String>() ?? const [],
        engineerName: json['engineer_name'] as String?,
        engineerRole: json['engineer_role'] as String?,
        engineerNote: json['engineer_note'] as String?,
        engineerAvatarUrl: json['engineer_avatar_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status.jsonKey,
        'created_at': createdAt.toIso8601String(),
        'description': description,
        'collaborators': collaborators,
        'engineer_name': engineerName,
        'engineer_role': engineerRole,
        'engineer_note': engineerNote,
        'engineer_avatar_url': engineerAvatarUrl,
      };

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
}
