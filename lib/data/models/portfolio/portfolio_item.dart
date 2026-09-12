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
    this.walkthroughVideo,
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
  final String? walkthroughVideo;

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
    walkthroughVideo,
  ];
}
