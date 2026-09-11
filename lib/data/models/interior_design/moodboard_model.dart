import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class MoodboardModel extends Equatable {
  const MoodboardModel({
    required this.id,
    required this.url,
    required this.label,
    this.labelAr,
  });

  final String id;
  final String url;
  final String label;
  final String? labelAr;

  String localizedLabel(BuildContext context) {
    return (context.isRtl && labelAr != null && labelAr!.isNotEmpty)
        ? labelAr!
        : label;
  }

  @override
  List<Object?> get props => [id, url, label, labelAr];
}

