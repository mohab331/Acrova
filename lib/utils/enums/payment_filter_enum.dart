import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/widgets.dart';

/// Filter options for payment history list.
enum PaymentFilter {
  all('All'),
  success('Success'),
  pending('Pending'),
  rejected('Rejected');

  final String value;
  const PaymentFilter(this.value);

  String localizedLabel(BuildContext context) {
    final loc = context.localization;
    return switch (this) {
      PaymentFilter.all => loc.filterAll,
      PaymentFilter.success => loc.paymentStatusSuccess,
      PaymentFilter.pending => loc.paymentStatusPending,
      PaymentFilter.rejected => loc.paymentStatusRejected,
    };
  }

  static PaymentFilter? fromValue(String? value) {
    if (value == null) return null;
    for (final item in PaymentFilter.values) {
      if (item.value.toLowerCase() == value.toLowerCase() ||
          item.name.toLowerCase() == value.toLowerCase()) {
        return item;
      }
    }
    return null;
  }
}
