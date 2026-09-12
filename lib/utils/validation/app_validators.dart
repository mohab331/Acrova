/// Centralized validation library tailored for the Saudi Arabia market and Acrova.
abstract final class AppValidators {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _urlRegex = RegExp(
    r'^(https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/.*)?$',
    caseSensitive: false,
  );

  static final RegExp _arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
  static final RegExp _englishRegex = RegExp(r'^[a-zA-Z\s]+$');

  /// Validates that a string is non-null and not empty after trimming.
  static String? required(
    String? value, [
    String message = 'This field is required',
  ]) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// Validates email format.
  static String? email(
    String? value, {
    String requiredMessage = 'Email is required',
    String invalidMessage = 'Please enter a valid email address',
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;
    if (!_emailRegex.hasMatch(trimmed)) return invalidMessage;
    return null;
  }

  /// Validates Saudi Arabian phone numbers.
  /// Must be 9 digits starting with 5 (ignoring leading +966, 00966, 0, or spaces).
  static String? saudiPhone(
    String? value, {
    String requiredMessage = 'Phone number is required',
    String invalidMessage =
        'Please enter a valid 9-digit Saudi mobile number starting with 5',
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;

    var digits = trimmed.replaceAll(RegExp(r'\D'), '');

    if (!digits.startsWith('966')) {
      return 'Saudi mobile number should start with +966';
    }
    // Strip Saudi country code
    if (digits.startsWith('966')) {
      digits = digits.substring(3);
    }
    // Strip leading 0
    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }

    if (digits.length != 9 || !digits.startsWith('5')) {
      return invalidMessage;
    }
    return null;
  }

  /// Validates generic international phone numbers (8-15 digits).
  static String? phone(
    String? value, {
    String requiredMessage = 'Phone number is required',
    String invalidMessage = 'Please enter a valid phone number',
    int minLength = 8,
    int maxLength = 15,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;

    final digits = trimmed.replaceAll(RegExp(r'\D'), '');
    if (digits.length < minLength || digits.length > maxLength) {
      return invalidMessage;
    }
    return null;
  }

  /// Validates OTP code of specific length (default: 6 digits).
  static String? otp(
    String? value, {
    int length = 6,
    String requiredMessage = 'Verification code is required',
    String invalidMessage = 'Please enter a valid verification code',
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;

    final digits = trimmed.replaceAll(RegExp(r'\D'), '');
    if (digits.length != length) return invalidMessage;
    return null;
  }

  /// Validates Saudi Arabian IBAN (format: SA followed by 22 alphanumeric chars).
  static String? saudiIban(
    String? value, {
    String requiredMessage = 'IBAN is required',
    String invalidMessage =
        'Please enter a valid Saudi IBAN (SA followed by 22 digits)',
  }) {
    final clean = (value ?? '').replaceAll(RegExp(r'\s'), '').toUpperCase();
    if (clean.isEmpty) return requiredMessage;

    final ibanRegex = RegExp(r'^SA\d{2}[0-9A-Z]{20}$');
    if (!ibanRegex.hasMatch(clean)) {
      return invalidMessage;
    }
    return null;
  }

  /// Validates Saudi National ID or Iqama (10 digits starting with 1 or 2).
  static String? saudiNationalId(
    String? value, {
    String requiredMessage = 'National ID / Iqama is required',
    String invalidMessage =
        'National ID must be 10 digits starting with 1 or 2',
  }) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return requiredMessage;

    if (digits.length != 10 ||
        (!digits.startsWith('1') && !digits.startsWith('2'))) {
      return invalidMessage;
    }
    return null;
  }

  /// Validates URL format (http/https).
  static String? url(
    String? value, {
    String requiredMessage = 'URL is required',
    String invalidMessage =
        'Please enter a valid URL starting with http:// or https://',
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;

    if (!trimmed.startsWith('http://') && !trimmed.startsWith('https://')) {
      return invalidMessage;
    }
    if (!_urlRegex.hasMatch(trimmed)) {
      return invalidMessage;
    }
    return null;
  }

  /// Validates numeric input.
  static String? numeric(
    String? value, {
    String requiredMessage = 'This field is required',
    String invalidMessage = 'Please enter a valid number',
    bool allowDecimal = false,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;

    if (allowDecimal) {
      if (double.tryParse(trimmed) == null) return invalidMessage;
    } else {
      if (int.tryParse(trimmed) == null) return invalidMessage;
    }
    return null;
  }

  /// Validates monetary amount within optional min/max bounds.
  static String? amount(
    String? value, {
    String requiredMessage = 'Amount is required',
    String invalidMessage = 'Please enter a valid amount',
    double? min,
    double? max,
    String? minMessage,
    String? maxMessage,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;

    final parsed = double.tryParse(trimmed.replaceAll(',', ''));
    if (parsed == null || parsed <= 0) return invalidMessage;

    if (min != null && parsed < min) {
      return minMessage ?? 'Amount must be at least $min';
    }
    if (max != null && parsed > max) {
      return maxMessage ?? 'Amount cannot exceed $max';
    }
    return null;
  }

  /// Validates person or company name.
  static String? name(
    String? value, {
    int minLength = 2,
    String requiredMessage = 'Name is required',
    String invalidMessage = 'Name is too short',
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;
    if (trimmed.length < minLength) return invalidMessage;
    return null;
  }

  /// Validates that text contains only Arabic characters and spaces.
  static String? arabicText(
    String? value, {
    String requiredMessage = 'This field is required',
    String invalidMessage = 'Please enter Arabic text only',
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;
    if (!_arabicRegex.hasMatch(trimmed)) return invalidMessage;
    return null;
  }

  /// Validates that text contains only English characters and spaces.
  static String? englishText(
    String? value, {
    String requiredMessage = 'This field is required',
    String invalidMessage = 'Please enter English text only',
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;
    if (!_englishRegex.hasMatch(trimmed)) return invalidMessage;
    return null;
  }

  // ── Boolean Checks ────────────────────────────────────────────────────────

  /// Returns true if [value] is a valid email address.
  static bool isValidEmail(String? value) => email(value) == null;

  /// Returns true if [value] is a valid Saudi mobile number.
  static bool isValidSaudiPhone(String? value) => saudiPhone(value) == null;

  /// Returns true if [value] is a valid international phone number.
  static bool isValidPhone(String? value) => phone(value) == null;

  /// Returns true if [value] is a valid HTTP/HTTPS URL.
  static bool isValidUrl(String? value) => url(value) == null;

  /// Returns true if [value] is a valid Saudi IBAN.
  static bool isValidSaudiIban(String? value) => saudiIban(value) == null;

  /// Returns true if [value] is a valid Saudi National ID or Iqama.
  static bool isValidSaudiNationalId(String? value) =>
      saudiNationalId(value) == null;
}
