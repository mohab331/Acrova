import 'dart:ui';

import 'package:acrova/domain/repository/notifications/base_notification_provider_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../core/error/app_error_model.dart';
import '../../../../../../data/data_source/remote/network/models/network_response.dart';
import '../../../../../../data/models/response/config/min_app_version_response_model.dart';
import '../../../../../../domain/repository/auth/base_auth_repo.dart';
import '../../../../../../domain/repository/config/base_app_config_repo.dart';
import '../../../../../../domain/repository/localization/base_localization_repo.dart';
import '../../../../../../domain/repository/notifications/base_fcm_token_repo.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/enums/cubit_status.dart';
import '../../../../../../utils/helpers/result.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required BaseAuthRepo authRepo,
    required BaseLocalizationRepo localizationRepository,
    required BaseAppConfigRepo appConfigRepo,
    required BaseNotificationProviderRepo notificationProviderRepo,
    required BaseFCMTokenRepo fcmTokenRepo,
  }) : _authRepo = authRepo,
       _localizationRepository = localizationRepository,
       _appConfigRepo = appConfigRepo,
       _notificationProviderRepo = notificationProviderRepo,
       _fcmTokenRepo = fcmTokenRepo,
       super(const SplashState.initial());

  final BaseAuthRepo _authRepo;
  final BaseLocalizationRepo _localizationRepository;
  final BaseAppConfigRepo _appConfigRepo;
  final BaseNotificationProviderRepo _notificationProviderRepo;
  final BaseFCMTokenRepo _fcmTokenRepo;

  Future<void> init({required Locale defaultLocale}) async {
    /// 0) loading
    emit(state.copyWith(splashStatus: CubitStatus.loading));
    await _requestPermissions();
    final results = await Future.wait<Object?>([
      _authRepo.getAccessToken(),
      _fcmTokenRepo.init(),
      _notificationProviderRepo.initializeConfig(),
      _appConfigRepo.getMinAppVersion(),
    ]);
    final tokenResult = results[0] as Result<String?>;
    final minAppVersionResult =
        results[3] as Result<NetworkResponse<MinAppVersionResponseModel>>;
    final localeResult = _localizationRepository.getSavedLocale();
    String? token;
    String languageCode = defaultLocale.languageCode;
    AppErrorModel? failure;
    bool forceUpdateRequired = false;

    /// 1)  Getting token result
    tokenResult.when(success: (t) => token = t, failure: (e) => failure = e);

    /// 2) Getting min app version (ignore failures)
    minAppVersionResult.when(
      success: (response) {
        final minVersionFromApi = response.data?.minAppVersion;
        if (minVersionFromApi == null) return;
        forceUpdateRequired =
            AppConstants.minimumSupportedAppVersion < minVersionFromApi;
      },
      failure: (_) {},
    );

    /// 3) Getting locale
    localeResult.when(
      success: (loc) =>
          languageCode = (loc?.languageCode ?? defaultLocale.languageCode),
      failure: (e) => failure = e,
    );

    /// 4) single emit (either success OR error)
    emit(
      state.copyWith(
        splashStatus: failure != null ? CubitStatus.error : CubitStatus.success,
        language: languageCode,
        error: failure,
        userToken: token,
        forceUpdateRequired: forceUpdateRequired,
      ),
    );
  }

  Future<void> _requestPermissions() async {
    final permission = await Permission.notification.status;
    if (permission.isGranted || permission.isLimited) {
      return;
    }
    await Permission.notification.request();
  }
}
