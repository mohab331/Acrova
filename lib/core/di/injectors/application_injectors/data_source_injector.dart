import 'package:acrova/core/config/mock_config.dart';
import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/core/di/injectors/base_injector.dart';
import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/local_storage/local_storag_impl.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/secure_storage_impl.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/data_source/base/base_auth_data_source.dart';
import 'package:acrova/data/data_source/remote/services/auth/remote_auth_data_source.dart';
import 'package:acrova/data/data_source/mock/services/auth/mock_auth_data_source.dart';
import 'package:acrova/data/data_source/base/base_dashboard_data_source.dart';
import 'package:acrova/data/data_source/remote/services/dashboard/remote_dashboard_data_source.dart';
import 'package:acrova/data/data_source/mock/services/dashboard/mock_dashboard_data_source.dart';
import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/data_source/mock/services/project/mock_project_data_source.dart';
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

    () => serviceLocatorInstance.registerLazySingleton<BaseAuthDataSource>(
      () {
        final useMockSystem = EnvironmentConfig.enableMock;
        if (useMockSystem) {
          return MockAuthDataSource();
        } else {
          return RemoteAuthDataSource(
            apiClient: serviceLocatorInstance<ApiClient>(),
          );
        }
      },
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseDashboardDataSource>(
      () {
        final useMockSystem = EnvironmentConfig.enableMock;
        if (useMockSystem) {
          return MockDashboardDataSource();
        } else {
          return RemoteDashboardDataSource(
            apiClient: serviceLocatorInstance<ApiClient>(),
          );
        }
      },
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseProjectDataSource>(
      () => MockProjectDataSource(),
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
