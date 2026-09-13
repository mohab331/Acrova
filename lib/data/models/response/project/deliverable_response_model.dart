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

class DeliverableResponseModel extends Equatable {
  const DeliverableResponseModel({
    this.id,
    this.title,
    this.type,
    this.url,
    this.thumbnailUrl,
    this.createdAt,
  });

  final String? id;
  final String? title;
  final DeliverableType? type;
  final String? url;
  final String? thumbnailUrl;
  final DateTime? createdAt;

  factory DeliverableResponseModel.fromJson(Map<String, dynamic> json) =>
      DeliverableResponseModel(
        id: json['id']?.toString(),
        title: json['title']?.toString(),
        type: json['type'] != null
            ? DeliverableTypeX.fromJson(json['type'].toString())
            : null,
        url: json['url']?.toString(),
        thumbnailUrl: json['thumbnail_url']?.toString(),
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'].toString())
            : null,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'type': type?.jsonKey,
    'url': url,
    'thumbnail_url': thumbnailUrl,
    'created_at': createdAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [id, title, type, url, thumbnailUrl, createdAt];

  @override
  String toString() {
    return 'DeliverableResponseModel('
        'id: $id, '
        'title: $title, '
        'type: $type, '
        'url: $url'
        ')';
  }
}
