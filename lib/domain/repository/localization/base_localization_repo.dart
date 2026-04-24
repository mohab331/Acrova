import 'dart:ui';

import 'package:acrova/utils/helpers/result.dart';

abstract class BaseLocalizationRepo {
  Future<Result<void>> saveLocale(String languageCode);

  Result<Locale?> getSavedLocale();

  Future<Result<void>> clearLocale();

}
