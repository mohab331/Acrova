import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class MoodboardResponseModel extends Equatable {
  const MoodboardResponseModel({
    this.id,
    this.url,
    this.label,
    this.labelAr,
  });

  final String? id;
  final String? url;
  final String? label;
  final String? labelAr;

  String localizedLabel(BuildContext context) {
    return (context.isRtl && labelAr != null && labelAr!.isNotEmpty)
        ? labelAr!
        : (label ?? '');
  }

  factory MoodboardResponseModel.fromJson(Map<String, dynamic> json) =>
      MoodboardResponseModel(
        id: json['id']?.toString(),
        url: json['url']?.toString(),
        label: json['label']?.toString(),
        labelAr: json['labelAr']?.toString() ?? json['label_ar']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'label': label,
    'labelAr': labelAr,
  };

  @override
  List<Object?> get props => [id, url, label, labelAr];

  @override
  String toString() {
    return 'MoodboardResponseModel('
        'id: $id, '
        'label: $label, '
        'url: $url'
        ')';
  }
}
