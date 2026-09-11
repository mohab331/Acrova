import 'dart:ui';
import 'package:acrova/presentation/features/cubit/localization/localization_cubit.dart';

enum LanguageCodes {
  english(0, LocalizationCubit.localeEn),
  arabic(1, LocalizationCubit.localeAr);

  final int serverValue;
  final Locale locale;

  const LanguageCodes(this.serverValue, this.locale);

  static LanguageCodes fromCode(String code) {
    return LanguageCodes.values.firstWhere(
      (e) => e.locale.languageCode == code,
      orElse: () => LanguageCodes.english,
    );
  }
}
