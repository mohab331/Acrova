import 'dart:ui';
import 'package:acrova/presentation/features/cubit/localization/localization_cubit.dart';

enum LanguageCodes {
  english(0, LocalizationCubit.localeEn),
  arabic(1, LocalizationCubit.localeAr);

  final int serverValue;
  final Locale locale;

  const LanguageCodes(this.serverValue, this.locale);

  int get id => serverValue;

  static LanguageCodes? fromId(int? id) {
    if (id == null) return null;
    for (final e in LanguageCodes.values) {
      if (e.serverValue == id) return e;
    }
    return null;
  }

  static LanguageCodes? fromCode(String? code) {
    if (code == null) return null;
    for (final e in LanguageCodes.values) {
      if (e.locale.languageCode == code || e.name == code) return e;
    }
    return null;
  }

  static LanguageCodes? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final parsed = int.tryParse(value.toString());
    if (parsed != null) return fromId(parsed);
    return fromCode(value.toString().trim());
  }
}
