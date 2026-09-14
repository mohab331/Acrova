import 'package:acrova/utils/enums/design_style_enum.dart';
import 'package:equatable/equatable.dart';

import 'walkthrough_response_model.dart';

class PortfolioItemResponseModel extends Equatable {
  const PortfolioItemResponseModel({
    this.id,
    this.style,
    this.category,
    this.title,
    this.location,
    this.area,
    this.floors,
    this.narrative,
    this.imageUrls,
    this.features,
    this.walkthroughModel,
  });

  final String? id;
  final DesignStyle? style;
  final String? category;
  final String? title;
  final String? location;
  final String? area;
  final String? floors;
  final String? narrative;
  final List<String>? imageUrls;
  final List<String>? features;
  final WalkthroughResponseModel? walkthroughModel;

  String? get styleLabel => style?.label;

  factory PortfolioItemResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => PortfolioItemResponseModel(
    id: json['id']?.toString(),
    style: DesignStyle.fromValue(json['style_id']),
    category: json['category']?.toString(),
    title: json['title']?.toString(),
    location: json['location']?.toString(),
    area: json['area']?.toString(),
    floors: json['floors']?.toString(),
    narrative: json['narrative']?.toString(),
    imageUrls: (json['imageUrls'] as List?)?.map((e) => e.toString()).toList(),
    features: (json['features'] as List?)?.map((e) => e.toString()).toList(),
    walkthroughModel: json['walkthroughModel'] is Map
        ? WalkthroughResponseModel.fromJson(
            Map<String, dynamic>.from(json['walkthroughModel'] as Map),
          )
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'style_id': style?.id,
    'style': style?.id,
    'category': category,
    'title': title,
    'location': location,
    'area': area,
    'floors': floors,
    'narrative': narrative,
    'imageUrls': imageUrls,
    'features': features,
    'walkthroughModel': walkthroughModel?.toJson(),
  };



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
    walkthroughModel,
  ];

  @override
  String toString() {
    return 'PortfolioItemResponseModel('
        'id: $id, '
        'title: $title, '
        'category: $category, '
        'style: $style'
        ')';
  }
}
