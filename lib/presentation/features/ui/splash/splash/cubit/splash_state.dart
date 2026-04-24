import 'package:equatable/equatable.dart';

import '../../../../../../core/error/app_error_model.dart';
import '../../../../../../utils/enums/cubit_status.dart';

class SplashState extends Equatable {
  const SplashState({
    required this.splashStatus,
    required this.userToken,
    required this.language,
    required this.error,
    required this.forceUpdateRequired,
  });

  const SplashState.initial({
    this.splashStatus = CubitStatus.initial,
    this.userToken,
    this.language,
    this.error,
    this.forceUpdateRequired = false,
  });
  final CubitStatus splashStatus;
  final String? userToken;
  final String? language;
  final AppErrorModel? error;
  final bool forceUpdateRequired;

  SplashState copyWith({
    CubitStatus? splashStatus,
    String? userToken,
    String? language,
    AppErrorModel? error,
    bool? forceUpdateRequired,
  }) {
    return SplashState(
      splashStatus: splashStatus ?? this.splashStatus,
      userToken: userToken ?? this.userToken,
      language: language ?? this.language,
      error: error,
      forceUpdateRequired: forceUpdateRequired ?? this.forceUpdateRequired,
    );
  }

  bool get hasError => (splashStatus == CubitStatus.error && error != null);
  bool get isLoading => (splashStatus == CubitStatus.loading || splashStatus == CubitStatus.initial);
  @override
  List<Object?> get props => [
    splashStatus,
    userToken,
    language,
    forceUpdateRequired,
  ];
}
