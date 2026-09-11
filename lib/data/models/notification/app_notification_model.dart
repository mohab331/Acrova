import 'package:equatable/equatable.dart';

/// A single in-app notification feed item.
class AppNotificationModel extends Equatable {
  const AppNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
    this.projectId,
  });

  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;

  /// Optional related project (for deep-linking when available).
  final String? projectId;

  AppNotificationModel copyWith({bool? isRead}) => AppNotificationModel(
        id: id,
        title: title,
        body: body,
        createdAt: createdAt,
        isRead: isRead ?? this.isRead,
        projectId: projectId,
      );

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) =>
      AppNotificationModel(
        id: json['id'] as String,
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
            DateTime.now(),
        isRead: json['is_read'] as bool? ?? false,
        projectId: json['project_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'created_at': createdAt.toIso8601String(),
        'is_read': isRead,
        'project_id': projectId,
      };

  @override
  List<Object?> get props => [id, title, body, createdAt, isRead, projectId];
}
