import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Scope of interior design work.
enum InteriorDesignScope {
  all(1, 'all'),
  specific(2, 'specific');

  final int id;
  final String value;
  const InteriorDesignScope(this.id, this.value);

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    return switch (this) {
      InteriorDesignScope.all => loc.interiorDesignScopeEntireProject,
      InteriorDesignScope.specific => loc.interiorDesignScopeSpecificAreas,
    };
  }

  static InteriorDesignScope? fromId(int? id) {
    if (id == null) return null;
    for (final item in InteriorDesignScope.values) {
      if (item.id == id) return item;
    }
    return null;
  }

  static InteriorDesignScope? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final str = value.toString().trim();
    final parsedInt = int.tryParse(str);
    if (parsedInt != null) {
      final match = fromId(parsedInt);
      if (match != null) return match;
    }
    for (final item in InteriorDesignScope.values) {
      if (item.value == str || item.name == str) {
        return item;
      }
    }
    return null;
  }
}
