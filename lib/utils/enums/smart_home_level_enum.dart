import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Smart home integration automation levels.
enum SmartHomeLevel {
  basic('basic'),
  intermediate('intermediate'),
  advanced('advanced');

  final String value;
  const SmartHomeLevel(this.value);

  String localizedLabel(BuildContext context) {
    final l10n = context.localization;
    return switch (this) {
      SmartHomeLevel.basic => l10n.requirementsSmartHomeBasic,
      SmartHomeLevel.intermediate => l10n.requirementsSmartHomeIntermediate,
      SmartHomeLevel.advanced => l10n.requirementsSmartHomeAdvanced,
    };
  }

  static SmartHomeLevel? fromValue(String? value) {
    if (value == null) return null;
    for (final item in SmartHomeLevel.values) {
      if (item.value == value || item.name == value) {
        return item;
      }
    }
    return null;
  }
}
