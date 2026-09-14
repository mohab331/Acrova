import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Smart home integration automation levels.
enum SmartHomeLevel {
  basic('basic', 0),
  intermediate('intermediate', 1),
  advanced('advanced', 2);

  final String value;
  final int id;
  const SmartHomeLevel(this.value, this.id);

  String localizedLabel(BuildContext context) {
    final l10n = context.localization;
    return switch (this) {
      SmartHomeLevel.basic => l10n.requirementsSmartHomeBasic,
      SmartHomeLevel.intermediate => l10n.requirementsSmartHomeIntermediate,
      SmartHomeLevel.advanced => l10n.requirementsSmartHomeAdvanced,
    };
  }

  static SmartHomeLevel? fromValue(int? value) {
    if (value == null) return null;

    for (final item in SmartHomeLevel.values) {
      if (item.id == value) {
        return item;
      }
    }
    return null;
  }
}
