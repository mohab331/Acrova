import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/core/di/injectors/base_injector.dart';
import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/data/data_source/remote/services/auth/auth_service.dart';
import 'package:acrova/data/data_source/remote/services/config/app_config_service.dart';
import 'package:acrova/data/repository/auth/auth_repo_impl.dart';
import 'package:acrova/data/repository/config/app_config_repo_impl.dart';
import 'package:acrova/data/repository/notifications/fcm_token_repo_impl.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:acrova/domain/repository/localization/base_localization_repo.dart';
import 'package:acrova/data/repository/localization/localization_repo_impl.dart';
import 'package:acrova/domain/repository/notifications/base_notification_provider_repo.dart';
import 'package:acrova/data/repository/notifications/notification_provider_repo_impl.dart';

/// [ReposInjector] hold all application repos dependencies
class ReposInjector implements BaseInjector {
  static final reposInjectors = [
    () => serviceLocatorInstance.registerLazySingleton<BaseAuthRepo>(
      () => AuthRepoImpl(
        authService: serviceLocatorInstance<AuthService>(),
        secureStorage: serviceLocatorInstance<BaseSecureStorage>(),
        localStorage: serviceLocatorInstance<BaseLocalStorage>(),
      ),
    ),
    () => serviceLocatorInstance.registerLazySingleton<BaseFCMTokenRepo>(
      () => FcmTokenRepoImpl(
        authService: serviceLocatorInstance<AuthService>(),
        secureStorage: serviceLocatorInstance<BaseSecureStorage>(),
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
          () => NotificationProviderRepoImpl(),
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
