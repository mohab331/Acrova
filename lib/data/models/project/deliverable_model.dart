import 'package:equatable/equatable.dart';

enum DeliverableType { image, video, pdf, document, other }

extension DeliverableTypeX on DeliverableType {
  String get jsonKey {
    switch (this) {
      case DeliverableType.image:
        return 'image';
      case DeliverableType.video:
        return 'video';
      case DeliverableType.pdf:
        return 'pdf';
      case DeliverableType.document:
        return 'document';
      case DeliverableType.other:
        return 'other';
    }
  }

  static DeliverableType fromJson(String key) {
    switch (key) {
      case 'image':
        return DeliverableType.image;
      case 'video':
        return DeliverableType.video;
      case 'pdf':
        return DeliverableType.pdf;
      case 'document':
        return DeliverableType.document;
      default:
        return DeliverableType.other;
    }
  }
}

class DeliverableModel extends Equatable {
  const DeliverableModel({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    required this.createdAt,
  });

  final String id;
  final String title;
  final DeliverableType type;
  final String url;
  final String? thumbnailUrl;
  final DateTime createdAt;

  factory DeliverableModel.fromJson(Map<String, dynamic> json) => DeliverableModel(
        id: json['id'] as String,
        title: json['title'] as String,
        type: DeliverableTypeX.fromJson(json['type'] as String),
        url: json['url'] as String,
        thumbnailUrl: json['thumbnail_url'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type.jsonKey,
        'url': url,
        'thumbnail_url': thumbnailUrl,
        'created_at': createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, title, type, url, thumbnailUrl, createdAt];
}
