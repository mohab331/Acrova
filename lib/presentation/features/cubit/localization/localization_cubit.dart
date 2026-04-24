import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/core/l10n/app_localizations.dart';
import 'package:acrova/domain/repository/localization/base_localization_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(initialLocale);

  /// English Supported Locale
  static const Locale localeEn = Locale('en');

  /// Arabic Supported Locale
  static const Locale localeAr = Locale('ar');

  static final BaseLocalizationRepo _localizationRepo =
      serviceLocatorInstance<BaseLocalizationRepo>();

  /// Contains all our localizationDelegates
  final List<LocalizationsDelegate> localizationDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  List<String> get supportedLanguageCodes =>
      supportedLocales.map((locale) => locale.languageCode).toList();

  static Locale get _defaultLocale => localeAr;
  static Locale get initialLocale {
    Locale locale = getCurrentLocale();
    final savedLang = _localizationRepo.getSavedLocale();
    savedLang.when(
      success: (data) {
        if (data != null && data.languageCode.isNotEmpty) {
          locale = data;
        }
      },
      failure: (_) {},
    );
    return _isLocaleSupported(locale) ? locale : _defaultLocale;
  }

  static String get getLanguageCodeFromLocalStorage {
    String savedLangCode = initialLocale.languageCode;
    final savedLang = _localizationRepo.getSavedLocale();
    savedLang.when(
      success: (data) => savedLangCode = data?.languageCode ?? savedLangCode,
      failure: (_) {},
    );
    return savedLangCode;
  }

  static Locale getCurrentLocale() {
    final String languageCode =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return Locale(languageCode);
  }

  static bool _isLocaleSupported(Locale locale) =>
      AppLocalizations.supportedLocales.contains(locale);

  Locale currentLocale() => state;

  void updateLocale(Locale locale) {
    if (supportedLocales.contains(locale)) {
      _localizationRepo.saveLocale(locale.languageCode);
      emit(locale);
    }
  }

  void updateLocaleToEnglish() => updateLocale(localeEn);

  void updateLocaleToArabic() => updateLocale(localeAr);

  Locale _resolvedLocaleLanguageCode() {
    if (getLanguageCodeFromLocalStorage == '"ar"' ||
        getLanguageCodeFromLocalStorage == 'ar') {
      return LocalizationCubit.localeAr;
    }
    return LocalizationCubit.localeEn;
  }

  Locale get appLocalization {
    return _resolvedLocaleLanguageCode();
  }
}
