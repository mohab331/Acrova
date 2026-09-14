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

  static SmartHomeLevel? fromId(int? id) {
    if (id == null) return null;
    for (final item in SmartHomeLevel.values) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  static SmartHomeLevel? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final parsed = int.tryParse(value.toString());
    if (parsed != null) return fromId(parsed);
    for (final item in SmartHomeLevel.values) {
      if (item.value.toLowerCase() == value.toString().toLowerCase() ||
          item.name.toLowerCase() == value.toString().toLowerCase()) {
        return item;
      }
    }
    return null;
  }
}
