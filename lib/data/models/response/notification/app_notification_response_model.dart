import 'package:equatable/equatable.dart';

/// A single in-app notification feed item response model.
class AppNotificationResponseModel extends Equatable {
  const AppNotificationResponseModel({
    this.id,
    this.title,
    this.body,
    this.createdAt,
    this.isRead,
    this.projectId,
  });

  final String? id;
  final String? title;
  final String? body;
  final DateTime? createdAt;
  final bool? isRead;

  /// Optional related project (for deep-linking when available).
  final String? projectId;

  AppNotificationResponseModel copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? createdAt,
    bool? isRead,
    String? projectId,
  }) => AppNotificationResponseModel(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
    isRead: isRead ?? this.isRead,
    projectId: projectId ?? this.projectId,
  );

  factory AppNotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      AppNotificationResponseModel(
        id: json['id']?.toString(),
        title: json['title']?.toString(),
        body: json['body']?.toString(),
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'].toString())
            : null,
        isRead: json['is_read'] != null
            ? (json['is_read'] is bool
                ? json['is_read'] as bool
                : bool.tryParse(json['is_read'].toString()))
            : null,
        projectId: json['project_id']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'created_at': createdAt?.toIso8601String(),
    'is_read': isRead,
    'project_id': projectId,
  };

  @override
  List<Object?> get props => [id, title, body, createdAt, isRead, projectId];

  @override
  String toString() {
    return 'AppNotificationResponseModel('
        'id: $id, '
        'title: $title, '
        'isRead: $isRead'
        ')';
  }
}
