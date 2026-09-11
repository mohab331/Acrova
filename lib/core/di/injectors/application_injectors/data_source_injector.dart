import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/core/di/injectors/base_injector.dart';
import 'package:acrova/data/data_source/base/base_auth_data_source.dart';
import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/data_source/base/base_dashboard_data_source.dart';
import 'package:acrova/data/data_source/base/base_notifications_data_source.dart';
import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/data_source/base/base_revisions_data_source.dart';
import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/local_storage/local_storag_impl.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/secure_storage_impl.dart';
import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/data/data_source/local/services/image_picker/image_picker_impl.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/data_source/remote/services/auth/remote_auth_data_source.dart';
import 'package:acrova/data/data_source/remote/services/billing/remote_billing_data_source.dart';
import 'package:acrova/data/data_source/remote/services/config/app_config_service.dart';
import 'package:acrova/data/data_source/remote/services/dashboard/remote_dashboard_data_source.dart';
import 'package:acrova/data/data_source/remote/services/notifications/remote_notifications_data_source.dart';
import 'package:acrova/data/data_source/remote/services/project/remote_project_data_source.dart';
import 'package:acrova/data/data_source/remote/services/revisions/remote_revisions_data_source.dart';
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
      () => RemoteAuthDataSource(
        apiClient: serviceLocatorInstance<ApiClient>(),
      ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseDashboardDataSource>(
      () => RemoteDashboardDataSource(
        apiClient: serviceLocatorInstance<ApiClient>(),
      ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseProjectDataSource>(
      () => RemoteProjectDataSource(
        apiClient: serviceLocatorInstance<ApiClient>(),
      ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<AppConfigService>(
      () => AppConfigService(apiClient: serviceLocatorInstance<ApiClient>()),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseImagePickerService>(
      ImagePickerServiceImpl.new,
    ),

    () => serviceLocatorInstance
        .registerLazySingleton<BaseNotificationsDataSource>(
      () => RemoteNotificationsDataSource(
        apiClient: serviceLocatorInstance<ApiClient>(),
      ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseRevisionsDataSource>(
      () => RemoteRevisionsDataSource(
        apiClient: serviceLocatorInstance<ApiClient>(),
      ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseBillingDataSource>(
      () => RemoteBillingDataSource(
        apiClient: serviceLocatorInstance<ApiClient>(),
      ),
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
