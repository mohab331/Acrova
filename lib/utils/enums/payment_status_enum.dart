import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

enum PaymentStatus {
  success(1, 'success'),
  pending(2, 'pending'),
  rejected(3, 'rejected');

  final int id;
  final String value;

  const PaymentStatus(this.id, this.value);

  /// Resolves an integer ID to [PaymentStatus?].
  static PaymentStatus? fromId(int? id) {
    if (id == null) return null;
    for (final item in PaymentStatus.values) {
      if (item.id == id) return item;
    }
    return null;
  }

  /// Resolves dynamic string or integer input to [PaymentStatus?].
  static PaymentStatus? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);

    final str = value.toString().trim();
    final parsedInt = int.tryParse(str);
    if (parsedInt != null) {
      final match = fromId(parsedInt);
      if (match != null) return match;
    }

    for (final item in PaymentStatus.values) {
      if (item.value.toLowerCase() == str.toLowerCase() ||
          item.name.toLowerCase() == str.toLowerCase()) {
        return item;
      }
    }
    return null;
  }

  /// Deserializes a JSON value into [PaymentStatus?].
  static PaymentStatus? fromJson(dynamic json) => fromValue(json);
}

extension PaymentStatusX on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.success:
        return 'Success';
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.rejected:
        return 'Rejected';
    }
  }

  String localizedName(BuildContext context) {
    switch (this) {
      case PaymentStatus.success:
        return context.localization.paymentStatusSuccess;
      case PaymentStatus.pending:
        return context.localization.paymentStatusPending;
      case PaymentStatus.rejected:
        return context.localization.paymentStatusRejected;
    }
  }

  Color get color {
    switch (this) {
      case PaymentStatus.success:
        return Resources.colors.luxurySuccess;
      case PaymentStatus.rejected:
        return Resources.colors.luxuryError;
      case PaymentStatus.pending:
        return Resources.colors.luxuryWarning;
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentStatus.success:
        return Icons.check_circle;
      case PaymentStatus.rejected:
        return Icons.error;
      case PaymentStatus.pending:
        return Icons.schedule;
    }
  }

  Color get backgroundColor => color.withValues(alpha: 0.1);

  static PaymentStatus? fromString(String? status) {
    return PaymentStatus.fromValue(status);
  }
}
