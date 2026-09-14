import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Filter options for payment history list.
enum PaymentFilter {
  all(0, 'All'),
  success(1, 'Success'),
  pending(2, 'Pending'),
  rejected(3, 'Rejected');

  final int id;
  final String value;
  const PaymentFilter(this.id, this.value);

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    return switch (this) {
      PaymentFilter.all => loc.filterAll,
      PaymentFilter.success => loc.paymentStatusSuccess,
      PaymentFilter.pending => loc.paymentStatusPending,
      PaymentFilter.rejected => loc.paymentStatusRejected,
    };
  }

  static PaymentFilter? fromId(int? id) {
    if (id == null) return null;
    for (final item in PaymentFilter.values) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  static PaymentFilter? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final parsed = int.tryParse(value.toString());
    if (parsed != null) return fromId(parsed);
    for (final item in PaymentFilter.values) {
      if (item.value.toLowerCase() == value.toString().toLowerCase() ||
          item.name.toLowerCase() == value.toString().toLowerCase()) {
        return item;
      }
    }
    return null;
  }
}
