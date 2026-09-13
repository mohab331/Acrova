import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/core/di/injectors/base_injector.dart';
import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/domain/repository/contact_us/base_contact_us_repo.dart';
import 'package:acrova/domain/repository/deliverables/base_deliverables_repo.dart';
import 'package:acrova/domain/repository/localization/base_localization_repo.dart';
import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:acrova/domain/repository/notifications/base_notification_provider_repo.dart';
import 'package:acrova/domain/repository/notifications/base_notifications_repo.dart';
import 'package:acrova/domain/repository/portfolio/base_portfolio_repo.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/localization/localization_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/cubit/profile_completion_cubit.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/cubit/make_payment_cubit.dart';
import 'package:acrova/presentation/features/ui/billing/payment_details/cubit/payment_details_cubit.dart';
import 'package:acrova/presentation/features/ui/billing/payment_history/cubit/payment_history_cubit.dart';
import 'package:acrova/presentation/features/ui/contact_us/cubit/contact_us_cubit.dart';
import 'package:acrova/presentation/features/ui/dashboard/cubit/dashboard_cubit.dart';
import 'package:acrova/presentation/features/ui/deliverables/cubit/deliverables_cubit.dart';
import 'package:acrova/presentation/features/ui/interior_design/cubit/interior_design_cubit.dart';
import 'package:acrova/presentation/features/ui/notifications/cubit/notifications_cubit.dart';
import 'package:acrova/presentation/features/ui/portfolio/cubit/portflio_details/portfolio_details_cubit.dart';
import 'package:acrova/presentation/features/ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/cubit/profile_cubit.dart';
import 'package:acrova/presentation/features/ui/project_creation/cubit/project_creation_cubit.dart';
import 'package:acrova/presentation/features/ui/project_detail/cubit/project_detail_cubit.dart';
import 'package:acrova/presentation/features/ui/projects/cubit/projects_cubit.dart';
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
      () => DashboardCubit(),
    ),

    () => serviceLocatorInstance.registerFactory<ProjectsCubit>(
      () =>
          ProjectsCubit(projectRepo: serviceLocatorInstance<BaseProjectRepo>()),
    ),

    () => serviceLocatorInstance.registerFactory<ProjectDetailCubit>(
      () => ProjectDetailCubit(
        projectRepo: serviceLocatorInstance<BaseProjectRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<DeliverablesCubit>(
      () => DeliverablesCubit(
        deliverablesRepo: serviceLocatorInstance<BaseDeliverablesRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<PortfolioCubit>(
      () => PortfolioCubit(
        portfolioRepo: serviceLocatorInstance<BasePortfolioRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<ProfileCubit>(
      () => ProfileCubit(authRepo: serviceLocatorInstance<BaseAuthRepo>()),
    ),
    () => serviceLocatorInstance.registerFactory<ProfileCompletionCubit>(
      () => ProfileCompletionCubit(
        authRepo: serviceLocatorInstance<BaseAuthRepo>(),
        imagePicker: serviceLocatorInstance<BaseImagePickerService>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<NotificationsCubit>(
      () => NotificationsCubit(
        notificationsRepo: serviceLocatorInstance<BaseNotificationsRepo>(),
      ),
    ),
    () => serviceLocatorInstance.registerFactory<InteriorDesignCubit>(
      () => InteriorDesignCubit(
        projectRepo: serviceLocatorInstance<BaseProjectRepo>(),
        imagePicker: serviceLocatorInstance<BaseImagePickerService>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<ProjectCreationCubit>(
      () => ProjectCreationCubit(
        projectRepo: serviceLocatorInstance<BaseProjectRepo>(),
        imagePicker: serviceLocatorInstance<BaseImagePickerService>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<RevisionsCubit>(
      () => RevisionsCubit(
        revisionsRepo: serviceLocatorInstance<BaseRevisionsRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<PortfolioDetailsCubit>(
      () => PortfolioDetailsCubit(
        portfolioRepo: serviceLocatorInstance<BasePortfolioRepo>(),
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

    () => serviceLocatorInstance.registerFactory<PaymentHistoryCubit>(
      () => PaymentHistoryCubit(
        billingRepo: serviceLocatorInstance<BaseBillingRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<PaymentDetailsCubit>(
      () => PaymentDetailsCubit(
        billingRepo: serviceLocatorInstance<BaseBillingRepo>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<MakePaymentCubit>(
      () => MakePaymentCubit(
        billingRepo: serviceLocatorInstance<BaseBillingRepo>(),
        baseImagePickerService:
            serviceLocatorInstance<BaseImagePickerService>(),
      ),
    ),

    () => serviceLocatorInstance.registerFactory<ContactUsCubit>(
      () => ContactUsCubit(
        contactUsRepo: serviceLocatorInstance<BaseContactUsRepo>(),
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
