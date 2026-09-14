import 'package:acrova/core/config/mock_config.dart';
import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/core/di/injectors/base_injector.dart';
import 'package:acrova/data/data_source/base/base_auth_data_source.dart';
import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/data_source/base/base_contact_us_data_source.dart';
import 'package:acrova/data/data_source/base/base_dashboard_data_source.dart';
import 'package:acrova/data/data_source/base/base_interior_design_data_source.dart';
import 'package:acrova/data/data_source/base/base_notifications_data_source.dart';
import 'package:acrova/data/data_source/base/base_project_data_source.dart';
import 'package:acrova/data/data_source/base/base_revisions_data_source.dart';
import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/data/data_source/remote/services/config/app_config_service.dart';
import 'package:acrova/data/repository/auth/auth_repo_impl.dart';
import 'package:acrova/data/repository/billing/billing_repo_impl.dart';
import 'package:acrova/data/repository/config/app_config_repo_impl.dart';
import 'package:acrova/data/repository/contact_us/contact_us_repo_impl.dart';
import 'package:acrova/data/repository/dashboard/dashboard_repo.dart';
import 'package:acrova/data/repository/deliverables/deliverables_repo_impl.dart';
import 'package:acrova/data/repository/interior_design/interior_design_repo_impl.dart';
import 'package:acrova/data/repository/localization/localization_repo_impl.dart';
import 'package:acrova/data/repository/mock/mock_repositories.dart';
import 'package:acrova/data/repository/notifications/fcm_token_repo_impl.dart';
import 'package:acrova/data/repository/notifications/notification_provider_repo_impl.dart';
import 'package:acrova/data/repository/notifications/notifications_repo_impl.dart';
import 'package:acrova/data/repository/portfolio/portfolio_repo_impl.dart';
import 'package:acrova/data/repository/project/project_repo_impl.dart';
import 'package:acrova/data/repository/revisions/revisions_repo_impl.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/domain/repository/contact_us/base_contact_us_repo.dart';
import 'package:acrova/domain/repository/dashboard/base_dashboard_repo.dart';
import 'package:acrova/domain/repository/deliverables/base_deliverables_repo.dart';
import 'package:acrova/domain/repository/interior_design/base_interior_design_repo.dart';
import 'package:acrova/domain/repository/localization/base_localization_repo.dart';
import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:acrova/domain/repository/notifications/base_notification_provider_repo.dart';
import 'package:acrova/domain/repository/notifications/base_notifications_repo.dart';
import 'package:acrova/domain/repository/portfolio/base_portfolio_repo.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';

/// [ReposInjector] hold all application repos dependencies
class ReposInjector implements BaseInjector {
  static final reposInjectors = [
    () => serviceLocatorInstance.registerLazySingleton<BaseAuthRepo>(
      () => MockConfig.useMock(MockRepositoryKey.auth)
          ? MockAuthRepo()
          : AuthRepoImpl(
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
      () => MockConfig.useMock(MockRepositoryKey.dashboard)
          ? MockDashboardRepo()
          : DashboardRepo(
              dashboardDataSource:
                  serviceLocatorInstance<BaseDashboardDataSource>(),
            ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseAppConfigRepo>(
      () => MockConfig.useMock(MockRepositoryKey.appConfig)
          ? MockAppConfigRepo()
          : AppConfigRepoImpl(
              appConfigService: serviceLocatorInstance<AppConfigService>(),
            ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseLocalizationRepo>(
      () => MockConfig.useMock(MockRepositoryKey.localization)
          ? MockLocalizationRepo()
          : LocalizationRepoImpl(
              localStorage: serviceLocatorInstance<BaseLocalStorage>(),
            ),
    ),
    () => serviceLocatorInstance
        .registerLazySingleton<BaseNotificationProviderRepo>(
          NotificationProviderRepoImpl.new,
        ),

    () => serviceLocatorInstance.registerLazySingleton<BaseProjectRepo>(
      () => MockConfig.useMock(MockRepositoryKey.project)
          ? MockProjectRepo()
          : ProjectRepoImpl(
              dataSource: serviceLocatorInstance<BaseProjectDataSource>(),
            ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseNotificationsRepo>(
      () => MockConfig.useMock(MockRepositoryKey.notifications)
          ? MockNotificationsRepo()
          : NotificationsRepoImpl(
              dataSource: serviceLocatorInstance<BaseNotificationsDataSource>(),
            ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseRevisionsRepo>(
      () => MockConfig.useMock(MockRepositoryKey.revisions)
          ? MockRevisionsRepo()
          : RevisionsRepoImpl(
              dataSource: serviceLocatorInstance<BaseRevisionsDataSource>(),
            ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseBillingRepo>(
      () => MockConfig.useMock(MockRepositoryKey.billing)
          ? MockBillingRepo()
          : BillingRepoImpl(
              dataSource: serviceLocatorInstance<BaseBillingDataSource>(),
            ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BasePortfolioRepo>(
      () => MockConfig.useMock(MockRepositoryKey.portfolio)
          ? MockPortfolioRepo()
          : PortfolioRepoImpl(),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseDeliverablesRepo>(
      () => MockConfig.useMock(MockRepositoryKey.deliverables)
          ? MockDeliverablesRepo()
          : DeliverablesRepoImpl(),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseContactUsRepo>(
      () => MockConfig.useMock(MockRepositoryKey.contactUs)
          ? MockContactUsRepo()
          : ContactUsRepoImpl(
              dataSource: serviceLocatorInstance<BaseContactUsDataSource>(),
            ),
    ),

    () => serviceLocatorInstance.registerLazySingleton<BaseInteriorDesignRepo>(
      () => MockConfig.useMock(MockRepositoryKey.interiorDesign)
          ? MockInteriorDesignRepo()
          : InteriorDesignRepoImpl(
              dataSource:
                  serviceLocatorInstance<BaseInteriorDesignDataSource>(),
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
