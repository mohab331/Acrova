import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/core/di/injectors/base_injector.dart';
import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/local_storage/local_storag_impl.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/secure_storage_impl.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/data_source/remote/services/auth/auth_service.dart';
import 'package:acrova/data/data_source/remote/services/config/app_config_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [DataSourcesInjector] hold all application data sources dependencies
class DataSourcesInjector implements BaseInjector {
  static final dataSourcesInjectors = [
    () => serviceLocatorInstance.registerSingletonAsync<SharedPreferences>(
      SharedPreferences.getInstance,
    ),
    () => serviceLocatorInstance.registerSingletonAsync<BaseLocalStorage>(
      () async {
        final sharedPrefs = await serviceLocatorInstance
            .getAsync<SharedPreferences>();
        return LocalStorageImpl(prefs: sharedPrefs);
      },
      dependsOn: [SharedPreferences],
    ),
    () => serviceLocatorInstance.registerLazySingleton<BaseSecureStorage>(
      SecureStorageImpl.new,
    ),

    () => serviceLocatorInstance.registerLazySingleton<AuthService>(
      () => AuthService(apiClient: serviceLocatorInstance<ApiClient>()),
    ),

    () => serviceLocatorInstance.registerLazySingleton<AppConfigService>(
      () => AppConfigService(apiClient: serviceLocatorInstance<ApiClient>()),
    ),
  ];

  /// iterate and inject all data sources
  @override
  Future<void> injectModules() async {
    for (final dataSourceInjector in dataSourcesInjectors) {
      dataSourceInjector.call();
    }
  }
}
