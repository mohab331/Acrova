import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Architectural and interior design style options.
enum DesignStyle {
  modern('modern'),
  classic('classic'),
  contemporary('contemporary'),
  minimalist('minimalist'),
  neoClassical('neo_classical');

  final String value;
  const DesignStyle(this.value);

  static List<DesignStyle> get all => values;

  String get label {
    switch (this) {
      case DesignStyle.modern:
        return 'Modern';
      case DesignStyle.classic:
        return 'Classic';
      case DesignStyle.contemporary:
        return 'Contemporary';
      case DesignStyle.minimalist:
        return 'Minimalist';
      case DesignStyle.neoClassical:
        return 'Neo-Classical';
    }
  }

  String localizedLabel(BuildContext context) {
    final l10n = context.localization;
    return switch (this) {
      DesignStyle.modern => l10n.designStyleModern,
      DesignStyle.classic => l10n.designStyleClassic,
      DesignStyle.contemporary => l10n.designStyleContemporary,
      DesignStyle.minimalist => l10n.designStyleMinimalist,
      DesignStyle.neoClassical => l10n.designStyleNeoClassical,
    };
  }

  static DesignStyle? fromValue(String? value) {
    if (value == null) return null;
    for (final item in DesignStyle.values) {
      if (item.value == value || item.name == value) {
        return item;
      }
    }
    return null;
  }
}
