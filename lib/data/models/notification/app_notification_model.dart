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

  final String? id;
  final String? title;
  final String? body;
  final DateTime? createdAt;
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
        id: json['id'],
        title: json['title'],
        body: json['body'],
        createdAt:
            DateTime.tryParse(json['created_at'] as String? ?? '') ??
            DateTime.now(),
        isRead: bool.tryParse(json['is_read']?.toString() ?? '') ?? false,
        projectId: json['project_id'],
      );

  @override
  List<Object?> get props => [id, title, body, createdAt, isRead, projectId];
}
