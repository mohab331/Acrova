import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Lifecycle status of a customer revision request.
enum RevisionStatus {
  inProgress(1, 'in_progress'),
  completed(2, 'completed');

  final int id;
  final String value;
  const RevisionStatus(this.id, this.value);

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

  static RevisionStatus? fromId(int? id) {
    if (id == null) return null;
    for (final item in RevisionStatus.values) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  static RevisionStatus? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final parsed = int.tryParse(value.toString());
    if (parsed != null) return fromId(parsed);
    for (final item in RevisionStatus.values) {
      if (item.value.toLowerCase() == value.toString().toLowerCase() ||
          item.name.toLowerCase() == value.toString().toLowerCase()) {
        return item;
      }
    }
    return null;
  }

  static RevisionStatus? fromJson(dynamic value) => fromValue(value);
}
