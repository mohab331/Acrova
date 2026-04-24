import 'package:intl/intl.dart';

/// Extension for formatting numbers with thousand separators.
///
/// Example:
/// ```dart
/// 1234567.formatWithCommas();        // "1,234,567"
/// 1234.5.formatWithCommas();         // "1,234.5"
/// 1234.567.formatWithCommas(decimalDigits: 2); // "1,234.57"
/// ```
extension NumberFormatting on num {
  String formatWithCommas({final int? decimalDigits}) {
    final formatter = NumberFormat.decimalPattern();
    if (decimalDigits != null) {
      formatter
        ..minimumFractionDigits = decimalDigits
        ..maximumFractionDigits = decimalDigits;
    }
    return formatter.format(this);
  }
}
