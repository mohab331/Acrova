import 'package:equatable/equatable.dart';

class WalkthroughResponseModel extends Equatable {
  final String? thumbnailImageUrl;
  final String? videoUrl;
  final String? quality;
  final String? duration;
  final String? size;
  final String? description;
  final String? format;
  final String? title;

  const WalkthroughResponseModel({
    this.thumbnailImageUrl,
    this.videoUrl,
    this.quality,
    this.duration,
    this.size,
    this.description,
    this.title,
    this.format,
  });

  factory WalkthroughResponseModel.fromJson(Map<String, dynamic> json) {
    return WalkthroughResponseModel(
      thumbnailImageUrl: json['thumbnailImageUrl']?.toString(),
      videoUrl: json['videoUrl']?.toString(),
      quality: json['quality']?.toString(),
      duration: json['duration']?.toString(),
      size: json['size']?.toString(),
      description: json['description']?.toString(),
      title: json['title']?.toString(),
      format: json['format']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'thumbnailImageUrl': thumbnailImageUrl,
    'videoUrl': videoUrl,
    'quality': quality,
    'duration': duration,
    'size': size,
    'description': description,
    'title': title,
    'format': format,
  };

  @override
  List<Object?> get props => [
    thumbnailImageUrl,
    videoUrl,
    quality,
    duration,
    size,
    description,
    title,
    format,
  ];

  @override
  String toString() {
    return 'WalkthroughResponseModel('
        'title: $title, '
        'videoUrl: $videoUrl, '
        'quality: $quality'
        ')';
  }
}
