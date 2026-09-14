import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Type of project the customer is commissioning.
enum ProjectType {
  villa(1, 'villa'),
  houseApartment(2, 'house_apartment'),
  commercial(3, 'commercial');

  final int id;
  final String value;
  const ProjectType(this.id, this.value);

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

  static ProjectType? fromId(int? id) {
    if (id == null) return null;
    for (final item in ProjectType.values) {
      if (item.id == id) return item;
    }
    return null;
  }

  static ProjectType? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final str = value.toString().trim();
    final parsedInt = int.tryParse(str);
    if (parsedInt != null) {
      final match = fromId(parsedInt);
      if (match != null) return match;
    }
    for (final item in ProjectType.values) {
      if (item.value.toLowerCase() == str.toLowerCase() ||
          item.name.toLowerCase() == str.toLowerCase()) {
        return item;
      }
    }
    return null;
  }

  static ProjectType? fromJson(dynamic value) => fromValue(value);
}

extension ProjectTypeX on ProjectType {
  String localizedLabel(BuildContext context) => this.localizedLabel(context);
}
