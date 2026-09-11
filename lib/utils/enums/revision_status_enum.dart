import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Lifecycle status of a customer revision request.
enum RevisionStatus {
  inProgress('in_progress'),
  completed('completed');

  final String value;
  const RevisionStatus(this.value);

  String get displayLabel {
    switch (this) {
      case RevisionStatus.inProgress:
        return 'In Progress';
      case RevisionStatus.completed:
        return 'Completed';
    }
  }

  String get displayLabelAr {
    switch (this) {
      case RevisionStatus.inProgress:
        return 'قيد التنفيذ';
      case RevisionStatus.completed:
        return 'مكتمل';
    }
  }

  String localizedLabel(BuildContext context) =>
      context.isRtl ? displayLabelAr : displayLabel;

  String get jsonKey => value;

  bool get isInProgress => this == RevisionStatus.inProgress;

  static RevisionStatus? fromValue(String? value) {
    if (value == null) return null;
    for (final item in RevisionStatus.values) {
      if (item.value == value || item.name == value) {
        return item;
      }
    }
    return null;
  }

  static RevisionStatus fromJson(String value) {
    return fromValue(value) ?? RevisionStatus.inProgress;
  }
}
