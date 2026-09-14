import 'package:equatable/equatable.dart';

class RenderResponseModel extends Equatable {
  const RenderResponseModel({this.resolution, this.imageAsset});

  final String? resolution;
  final String? imageAsset;

  factory RenderResponseModel.fromJson(Map<String, dynamic> json) =>
      RenderResponseModel(
        resolution: json['resolution']?.toString(),
        imageAsset: json['imageAsset']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'resolution': resolution,
    'imageAsset': imageAsset,
  };

  @override
  List<Object?> get props => [resolution, imageAsset];

  @override
  String toString() {
    return 'RenderResponseModel('
        'resolution: $resolution, '
        'imageAsset: $imageAsset'
        ')';
  }
}
