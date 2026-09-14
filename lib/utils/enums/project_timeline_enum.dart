import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Expected project delivery timeline for interior design.
enum ProjectTimeline {
  flexible(1, 'flexible'),
  threeToSixMonths(2, '3_6_months'),
  asap(3, 'asap');

  final int id;
  final String value;
  const ProjectTimeline(this.id, this.value);

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    return switch (this) {
      ProjectTimeline.flexible => loc.interiorDesignTimelineFlexible,
      ProjectTimeline.threeToSixMonths =>
        loc.interiorDesignTimelineThreeToSixMonths,
      ProjectTimeline.asap => loc.interiorDesignTimelineAsap,
    };
  }

  static ProjectTimeline? fromId(int? id) {
    if (id == null) return null;
    for (final item in ProjectTimeline.values) {
      if (item.id == id) return item;
    }
    return null;
  }

  static ProjectTimeline? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final str = value.toString().trim();
    final parsedInt = int.tryParse(str);
    if (parsedInt != null) {
      final match = fromId(parsedInt);
      if (match != null) return match;
    }
    for (final item in ProjectTimeline.values) {
      if (item.value == str || item.name == str) {
        return item;
      }
    }
    return null;
  }
}
