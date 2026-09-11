import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Categories for filtering portfolio designs.
enum PortfolioFilter {
  all('all'),
  exterior('exterior'),
  modern('modern'),
  traditional('traditional'),
  interior('interior');

  final String value;
  const PortfolioFilter(this.value);

  String localizedLabel(BuildContext context) {
    final l10n = context.localization;
    return switch (this) {
      PortfolioFilter.all => l10n.filterAll,
      PortfolioFilter.exterior => l10n.filterExterior,
      PortfolioFilter.modern => l10n.filterModern,
      PortfolioFilter.traditional => l10n.filterTraditional,
      PortfolioFilter.interior => l10n.filterInterior,
    };
  }

  static PortfolioFilter? fromValue(String? value) {
    if (value == null) return null;
    for (final item in PortfolioFilter.values) {
      if (item.value == value || item.name == value) {
        return item;
      }
    }
    return null;
  }
}
