import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Architectural and interior design style options.
enum DesignStyle {
  modern('modern', 0),
  classic('classic', 1),
  contemporary('contemporary', 2),
  minimalist('minimalist', 3),
  neoClassical('neo_classical', 4);

  final String value;
  final int id;
  const DesignStyle(this.value, this.id);

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

  static DesignStyle? fromValue(int? id) {
    if (id == null) return null;
    for (final item in DesignStyle.values) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}
