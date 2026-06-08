/// Phone number country definition.
class Country {
  const Country({
    required this.name,
    required this.nameAr,
    required this.code,
    required this.iso2,
    required this.minLength,
    required this.maxLength,
  });

  final String name;
  final String nameAr;
  final String code;  // e.g. '+966'
  final String iso2;  // e.g. 'SA'
  final int minLength;
  final int maxLength;

  /// Unicode flag emoji derived from ISO2 code.
  String get flagEmoji => iso2.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (m) => String.fromCharCode(m.group(0)!.codeUnitAt(0) + 127397),
      );
}

/// Supported countries — expand as needed.
const List<Country> kSupportedCountries = [
  Country(
    name:      'Saudi Arabia',
    nameAr:    'المملكة العربية السعودية',
    code:      '+966',
    iso2:      'SA',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name:      'United Arab Emirates',
    nameAr:    'الإمارات العربية المتحدة',
    code:      '+971',
    iso2:      'AE',
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name:      'Egypt',
    nameAr:    'مصر',
    code:      '+20',
    iso2:      'EG',
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name:      'Kuwait',
    nameAr:    'الكويت',
    code:      '+965',
    iso2:      'KW',
    minLength: 8,
    maxLength: 8,
  ),
];

// ── Helpers ──────────────────────────────────────────────────────────────────

abstract final class PhoneFormatter {
  /// Formats a raw digit string into groups appropriate for the country.
  static String format(String input, Country country) {
    final digits = input.replaceAll(RegExp(r'\D'), '');
    if (country.iso2 == 'SA') return _formatSA(digits);
    return digits;
  }

  static String _formatSA(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) return '${digits.substring(0, 3)} ${digits.substring(3)}';
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, digits.length.clamp(0, 9))}';
  }
}

abstract final class PhoneValidator {
  static String? validate(String input, Country country) {
    final digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return 'Phone number is required';
    if (digits.length < country.minLength) return 'Number is too short';
    if (digits.length > country.maxLength) return 'Number is too long';
    if (country.iso2 == 'SA' && !digits.startsWith('5')) {
      return 'Saudi numbers must start with 5';
    }
    return null;
  }
}
