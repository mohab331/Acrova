import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/core/di/injectors/base_injector.dart';
import 'package:acrova/data/data_source/base/base_auth_data_source.dart';
import 'package:acrova/data/data_source/base/base_dashboard_data_source.dart';
import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/data/data_source/remote/services/config/app_config_service.dart';
import 'package:acrova/data/repository/auth/auth_repo_impl.dart';
import 'package:acrova/data/repository/config/app_config_repo_impl.dart';
import 'package:acrova/data/repository/dashboard/dashboard_repo.dart';
import 'package:acrova/data/repository/localization/localization_repo_impl.dart';
import 'package:acrova/data/repository/notifications/fcm_token_repo_impl.dart';
import 'package:acrova/data/repository/notifications/notification_provider_repo_impl.dart';
import 'package:acrova/data/repository/project/project_repo_impl.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/domain/repository/dashboard/base_dashboard_repo.dart';
import 'package:acrova/domain/repository/localization/base_localization_repo.dart';
import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:acrova/domain/repository/notifications/base_notification_provider_repo.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';

/// [ReposInjector] hold all application repos dependencies
class ReposInjector implements BaseInjector {
  static final reposInjectors = [
    () => serviceLocatorInstance.registerLazySingleton<BaseAuthRepo>(
      () => AuthRepoImpl(
        authDataSource: serviceLocatorInstance<BaseAuthDataSource>(),
        secureStorage: serviceLocatorInstance<BaseSecureStorage>(),
        localStorage: serviceLocatorInstance<BaseLocalStorage>(),
      ),
    ),
    () => serviceLocatorInstance.registerLazySingleton<BaseFCMTokenRepo>(
      () => FcmTokenRepoImpl(
        authDataSource: serviceLocatorInstance<BaseAuthDataSource>(),
        secureStorage: serviceLocatorInstance<BaseSecureStorage>(),
      ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseDashboardRepo>(
      () => DashboardRepo(
        dashboardDataSource: serviceLocatorInstance<BaseDashboardDataSource>(),
      ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseAppConfigRepo>(
      () => AppConfigRepoImpl(
        appConfigService: serviceLocatorInstance<AppConfigService>(),
      ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseLocalizationRepo>(
      () => LocalizationRepoImpl(
        localStorage: serviceLocatorInstance<BaseLocalStorage>(),
      ),
    ),
    () => serviceLocatorInstance
        .registerLazySingleton<BaseNotificationProviderRepo>(
          NotificationProviderRepoImpl.new,
        ),

    () => serviceLocatorInstance.registerLazySingleton<BaseProjectRepo>(
      () => ProjectRepoImpl(
        dataSource: serviceLocatorInstance<BaseProjectDataSource>(),
      ),
    ),
  ];

  /// iterate and inject all repos
  @override
  Future<void> injectModules() async {
    for (final repoInjector in reposInjectors) {
      repoInjector.call();
    }
  }
}
