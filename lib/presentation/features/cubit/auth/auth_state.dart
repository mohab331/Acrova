import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class AuthCubitState extends Equatable {
  const AuthCubitState({
    required this.cubitStatus,
    required this.appErrorModel,
    this.isNewUser,
  });

  const AuthCubitState.initial()
      : this(cubitStatus: CubitStatus.initial, appErrorModel: null);

  final CubitStatus cubitStatus;
  final AppErrorModel? appErrorModel;

  /// Set after successful OTP verification.
  /// `true`  → redirect to ProfileSetupPage (mandatory KYC)
  /// `false` → redirect to HomePage
  /// `null`  → not yet determined
  final bool? isNewUser;

  bool get isLoading  => cubitStatus == CubitStatus.loading;
  bool get isSuccess  => cubitStatus == CubitStatus.success;
  bool get isError    => cubitStatus == CubitStatus.error;
  bool get isAuthorized => cubitStatus == CubitStatus.success;

  AuthCubitState copyWith({
    CubitStatus? cubitStatus,
    AppErrorModel? appErrorModel,
    bool? isNewUser,
  }) =>
      AuthCubitState(
        cubitStatus:   cubitStatus   ?? this.cubitStatus,
        appErrorModel: appErrorModel,
        isNewUser:     isNewUser     ?? this.isNewUser,
      );

  @override
  List<Object?> get props => [cubitStatus, appErrorModel, isNewUser];
}
