import 'package:acrova/utils/enums/deliverable_type_enum.dart';
import 'package:equatable/equatable.dart';

export 'package:acrova/utils/enums/deliverable_type_enum.dart';

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
        type: DeliverableType.fromId(
          int.tryParse(
            json['type_id']?.toString() ??
                json['deliverable_type_id']?.toString() ??
                json['type']?.toString() ??
                '',
          ),
        ) ?? DeliverableType.fromValue(json['type']),
        url: json['url']?.toString(),
        thumbnailUrl: json['thumbnail_url']?.toString(),
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'].toString())
            : null,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'type_id': type?.id,
    'type': type?.id,
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
