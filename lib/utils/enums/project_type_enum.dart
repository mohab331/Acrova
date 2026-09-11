import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Type of project the customer is commissioning.
enum ProjectType {
  villa('villa'),
  houseApartment('house_apartment'),
  commercial('commercial');

  final String value;
  const ProjectType(this.value);

  String get displayLabel {
    switch (this) {
      case ProjectType.villa:
        return 'Villa';
      case ProjectType.houseApartment:
        return 'House / Apartment';
      case ProjectType.commercial:
        return 'Commercial';
    }
  }

  String get displayLabelAr {
    switch (this) {
      case ProjectType.villa:
        return 'فيلا';
      case ProjectType.houseApartment:
        return 'منزل / شقة';
      case ProjectType.commercial:
        return 'تجاري';
    }
  }

  String localizedLabel(BuildContext context) {
    final l10n = context.localization;
    return switch (this) {
      ProjectType.villa => l10n.projectTypeVillaLabel,
      ProjectType.houseApartment => l10n.projectTypeHouseApartmentLabel,
      ProjectType.commercial => l10n.projectTypeCommercialLabel,
    };
  }

  String get jsonKey => value;

  static ProjectType? fromValue(String? value) {
    if (value == null) return null;
    for (final item in ProjectType.values) {
      if (item.value == value || item.name == value) {
        return item;
      }
    }
    return null;
  }

  static ProjectType fromJson(String value) {
    return fromValue(value) ?? ProjectType.villa;
  }
}

extension ProjectTypeX on ProjectType {
  String localizedLabel(BuildContext context) => this.localizedLabel(context);
}
