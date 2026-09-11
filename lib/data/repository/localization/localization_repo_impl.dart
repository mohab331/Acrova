import 'dart:ui';

import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/domain/repository/localization/base_localization_repo.dart';
import 'package:acrova/utils/constants/local_constants.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';


class LocalizationRepoImpl implements BaseLocalizationRepo {
  LocalizationRepoImpl({
    required BaseLocalStorage localStorage,
  }) : _localStorage = localStorage;
  final BaseLocalStorage _localStorage;

  @override
  Future<Result<void>> saveLocale(String languageCode) => safeAsyncCall(
    () => _localStorage.write(LocalConstants.languageCode, languageCode),
  );

  @override
  Result<Locale?> getSavedLocale() {
    return safeCall(() {
      final lang = _localStorage.read<String>(LocalConstants.languageCode);
      if (lang?.isEmpty ?? true) return null;
      return Locale(lang!);
    });
  }

  @override
  Future<Result<void>> clearLocale() =>
      safeAsyncCall(() => _localStorage.delete(LocalConstants.languageCode));

}
