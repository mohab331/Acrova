import 'package:equatable/equatable.dart';

class PortfolioItem extends Equatable {
  const PortfolioItem({
    required this.id,
    required this.style,
    required this.category,
    required this.title,
    required this.location,
    required this.area,
    required this.floors,
    required this.narrative,
    required this.imageUrls,
    required this.features,
    this.walkthroughModel,
  });

  final String? id;
  final String? style;
  final String? category;
  final String? title;
  final String? location;
  final String? area;
  final String? floors;
  final String? narrative;
  final List<String>? imageUrls;
  final List<String>? features;
  final WalkthroughModel? walkthroughModel;

  @override
  List<Object?> get props => [
    id,
    style,
    category,
    title,
    location,
    area,
    floors,
    narrative,
    imageUrls,
    features,
  ];
}

class WalkthroughModel extends Equatable {
  final String? thumbnailImageUrl;
  final String? videoUrl;
  final String? quality;
  final String? duration;
  final String? size;
  final String? description;

  final String? format;
  final String? title;

  const WalkthroughModel({
    this.thumbnailImageUrl,
    this.videoUrl,
    this.quality,
    this.duration,
    this.size,
    this.description,
    this.title,
    this.format,
  });

  factory WalkthroughModel.fromJson(Map<String, dynamic> json) {
    return WalkthroughModel(
      thumbnailImageUrl: json['thumbnailImageUrl'],
      videoUrl: json['videoUrl'],
      quality: json['quality'],
      duration: json['duration'],
      size: json['size'],
      description: json['description'],
      title: json['title'],
      format: json['format'],
    );
  }
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
}
