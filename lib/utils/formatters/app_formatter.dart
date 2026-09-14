import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Centralized formatting utility for currencies, numbers, dates, and relative timestamps.
abstract final class AppFormatter {
  /// Formats a monetary amount with currency code (e.g. 'SAR 14,000').
  /// Returns `null` if [amount] is null.
  static String? formatCurrency(
    num? amount, {
    String currency = 'SAR',
    String? locale,
    int? decimalDigits,
  }) {
    if (amount == null) return null;
    final formatted = formatAmount(
      amount,
      locale: locale,
      decimalDigits: decimalDigits,
    );
    return '$currency $formatted';
  }

  /// Formats a numeric amount with thousands commas (e.g. '14,000' or '1,234.50').
  /// Returns `null` if [amount] is null.
  static String? formatAmount(
    num? amount, {
    String? locale,
    int? decimalDigits,
  }) {
    if (amount == null) return null;
    final pattern = decimalDigits != null && decimalDigits > 0
        ? '#,##0.${'0' * decimalDigits}'
        : '#,##0';
    final formatter = NumberFormat(pattern, locale);
    return formatter.format(amount);
  }

  /// Formats a [DateTime] into a localized string pattern (e.g. '01 Jan 2025').
  /// Returns `null` if [date] is null.
  static String? formatDate(
    DateTime? date, {
    String format = 'dd MMM yyyy',
    String? locale,
  }) {
    if (date == null) return null;
    return DateFormat(format, locale).format(date);
  }

  /// Returns localized relative time (e.g. 'Just now', '5m', '2h', '3d').
  /// Returns `null` if [time] is null.
  static String? relativeTime(BuildContext context, DateTime? time) {
    if (time == null) return null;
    final l10n = context.localization;
    final diff = DateTime.now().difference(time);

    if (diff.isNegative || diff.inMinutes < 1) {
      return l10n.timeJustNow;
    }
    if (diff.inMinutes < 60) {
      return l10n.timeMinutesShort(diff.inMinutes);
    }
    if (diff.inHours < 24) {
      return l10n.timeHoursShort(diff.inHours);
    }
    return l10n.timeDaysShort(diff.inDays);
  }
}

class SaudiPhoneFormatter extends TextInputFormatter {
  static const String prefix = '+966 ';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Extract everything after +966, then keep digits only.
    String digits;

    if (newValue.text.startsWith(prefix)) {
      digits = newValue.text.substring(prefix.length);
    } else if (newValue.text.startsWith('+966')) {
      digits = newValue.text.substring(4);
    } else {
      // User may paste/type a complete number.
      digits = newValue.text;
    }

    digits = digits.replaceAll(RegExp(r'\D'), '');

    // If they entered 966 again, remove it.
    if (digits.startsWith('966')) {
      digits = digits.substring(3);
    }

    // Saudi mobile number = 9 digits after +966.
    // Example: +966 50 123 4567
    if (digits.length > 9) {
      digits = digits.substring(0, 9);
    }

    final buffer = StringBuffer(prefix);

    for (var i = 0; i < digits.length; i++) {
      if (i == 2 || i == 5) {
        buffer.write(' ');
      }

      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class NationalIdFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    final limited = digits.substring(0, digits.length.clamp(0, 10));

    return TextEditingValue(
      text: limited,
      selection: TextSelection.collapsed(offset: limited.length),
    );
  }
}
