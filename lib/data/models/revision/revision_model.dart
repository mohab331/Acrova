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

  final String? id;
  final RevisionStatus status;
  final DateTime createdAt;
  final String? description;

  /// Collaborator initials shown as a stacked badge group (e.g. ["FA", "MK"]).
  final List<String>? collaborators;

  final String? engineerName;
  final String? engineerRole;
  final String? engineerNote;
  final String? engineerAvatarUrl;

  factory RevisionModel.fromJson(Map<String, dynamic> json) => RevisionModel(
    id: json['id'],
    status: RevisionStatus.fromJson(json['status']?.toString() ?? ''),
    createdAt:
        DateTime.tryParse(json['created_at']?.toString() ?? '') ??
        DateTime.now(),
    description: json['description'],
    collaborators: (json['collaborators'] as List?)
        ?.map((e) => e?.toString() ?? '')
        .toList(),
    engineerName: json['engineer_name'],
    engineerRole: json['engineer_role'],
    engineerNote: json['engineer_note'],
    engineerAvatarUrl: json['engineer_avatar_url'],
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
}
