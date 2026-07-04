import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/core/di/injectors/base_injector.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/domain/repository/localization/base_localization_repo.dart';
import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:acrova/domain/repository/notifications/base_notification_provider_repo.dart';
import 'package:acrova/domain/repository/notifications/base_notifications_repo.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_cubit.dart';
import 'package:acrova/presentation/features/cubit/deliverables/deliverables_cubit.dart';
import 'package:acrova/presentation/features/cubit/localization/localization_cubit.dart';
import 'package:acrova/presentation/features/cubit/profile/profile_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_detail/project_detail_cubit.dart';
import 'package:acrova/presentation/features/cubit/projects/projects_cubit.dart';
import 'package:acrova/presentation/features/ui/notifications/cubit/notifications_cubit.dart';
import 'package:acrova/presentation/features/ui/revisions/cubit/revisions/revisions_cubit.dart';
import 'package:acrova/presentation/features/ui/splash/splash/cubit/splash_cubit.dart';

/// [CubitsInjector] hold all application global singleton cubits dependencies
///
/// global cubits are injected here
class CubitsInjector implements BaseInjector {
  static final cubitsInjectors = [
    () => serviceLocatorInstance.registerLazySingleton<LocalizationCubit>(
      LocalizationCubit.new,
    ),
    () => serviceLocatorInstance.registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        baseAuthRepo: serviceLocatorInstance<BaseAuthRepo>(),
        baseFCMTokenRepo: serviceLocatorInstance<BaseFCMTokenRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<DashboardCubit>(
      () => DashboardCubit(
        projectRepo: serviceLocatorInstance<BaseProjectRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<ProjectsCubit>(
      () => ProjectsCubit(
        projectRepo: serviceLocatorInstance<BaseProjectRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<ProjectDetailCubit>(
      () => ProjectDetailCubit(
        projectRepo: serviceLocatorInstance<BaseProjectRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<DeliverablesCubit>(
      DeliverablesCubit.new,
    ),

    () => serviceLocatorInstance.registerFactory<ProfileCubit>(
      () => ProfileCubit(
        authRepo: serviceLocatorInstance<BaseAuthRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<NotificationsCubit>(
      () => NotificationsCubit(
        notificationsRepo: serviceLocatorInstance<BaseNotificationsRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<RevisionsCubit>(
      () => RevisionsCubit(
        revisionsRepo: serviceLocatorInstance<BaseRevisionsRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<SplashCubit>(
      () => SplashCubit(
        authRepo: serviceLocatorInstance<BaseAuthRepo>(),
        appConfigRepo: serviceLocatorInstance<BaseAppConfigRepo>(),
        notificationProviderRepo:
            serviceLocatorInstance<BaseNotificationProviderRepo>(),
        fcmTokenRepo: serviceLocatorInstance<BaseFCMTokenRepo>(),
        localizationRepository: serviceLocatorInstance<BaseLocalizationRepo>(),
      ),
    ),
  ];

  /// iterate and inject all cubits

  @override
  void injectModules() {
    for (final cubitInjector in cubitsInjectors) {
      cubitInjector.call();
    }
  }
}
