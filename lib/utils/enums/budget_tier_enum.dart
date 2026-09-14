import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Budget tier for interior design.
enum BudgetTier {
  standard(1, 'standard'),
  premium(2, 'premium'),
  ultraLuxury(3, 'ultra_luxury');

  final int id;
  final String value;
  const BudgetTier(this.id, this.value);

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    return switch (this) {
      BudgetTier.standard => loc.interiorDesignBudgetStandard,
      BudgetTier.premium => loc.interiorDesignBudgetPremium,
      BudgetTier.ultraLuxury => loc.interiorDesignBudgetUltraLuxury,
    };
  }

  static BudgetTier? fromId(int? id) {
    if (id == null) return null;
    for (final item in BudgetTier.values) {
      if (item.id == id) return item;
    }
    return null;
  }

  static BudgetTier? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final str = value.toString().trim();
    final parsedInt = int.tryParse(str);
    if (parsedInt != null) {
      final match = fromId(parsedInt);
      if (match != null) return match;
    }
    for (final item in BudgetTier.values) {
      if (item.value == str || item.name == str) {
        return item;
      }
    }
    return null;
  }
}
