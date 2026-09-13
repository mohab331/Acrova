import 'package:equatable/equatable.dart';

class BlueprintResponseModel extends Equatable {
  const BlueprintResponseModel({
    this.title,
    this.size,
    this.format,
    this.urlOrAsset,
  });

  final String? title;
  final String? size;
  final String? format;
  final String? urlOrAsset;

  factory BlueprintResponseModel.fromJson(Map<String, dynamic> json) =>
      BlueprintResponseModel(
        title: json['title']?.toString(),
        size: json['size']?.toString(),
        format: json['format']?.toString(),
        urlOrAsset: json['urlOrAsset']?.toString() ?? json['url']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'size': size,
    'format': format,
    'urlOrAsset': urlOrAsset,
  };

  @override
  List<Object?> get props => [title, size, format, urlOrAsset];

  @override
  String toString() {
    return 'BlueprintResponseModel('
        'title: $title, '
        'size: $size, '
        'format: $format'
        ')';
  }
}
