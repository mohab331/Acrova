import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/user_status.dart';
import 'package:equatable/equatable.dart';

class AuthCubitState extends Equatable {
  const AuthCubitState({
    required this.sendOTPCubitStatus,
    required this.verifyOTPCubitStatus,
    required this.getUserCubitStatus,
    required this.userModel,
    required this.sendOTPAppErrorModel,
    required this.verifyOtpAppErrorModel,
    required this.getUserErrorModel,
    required this.resendOTPAppErrorModel,
    required this.resendOTPCubitStatus,
    required this.phoneNumber,
  });

  const AuthCubitState.initial()
    : this(
        sendOTPCubitStatus: CubitStatus.initial,
        verifyOTPCubitStatus: CubitStatus.initial,
        getUserCubitStatus: CubitStatus.initial,
        resendOTPCubitStatus: CubitStatus.initial,
        userModel: null,
        sendOTPAppErrorModel: null,
        verifyOtpAppErrorModel: null,
        getUserErrorModel: null,
        resendOTPAppErrorModel: null,
        phoneNumber: null,
      );

  final CubitStatus sendOTPCubitStatus;
  final CubitStatus verifyOTPCubitStatus;
  final CubitStatus getUserCubitStatus;
  final CubitStatus resendOTPCubitStatus;

  final AppErrorModel? resendOTPAppErrorModel;
  final UserProfileResponseModel? userModel;
  final AppErrorModel? sendOTPAppErrorModel;
  final AppErrorModel? verifyOtpAppErrorModel;
  final AppErrorModel? getUserErrorModel;
  final String? phoneNumber;
  bool get isAuthorized => verifyOTPCubitStatus == CubitStatus.success;

  UserStatus get userStatus {
    if (userModel != null && userModel!.isProfileComplete) {
      return UserStatus.authenticated;
    }
    if (getUserCubitStatus == CubitStatus.success &&
        (userModel == null || !userModel!.isProfileComplete)) {
      return UserStatus.visitor;
    }
    if (isAuthorized) {
      return UserStatus.visitor;
    }
    return UserStatus.unauthenticated;
  }

  bool get isVisitor => userStatus == UserStatus.visitor;
  bool get isFullyAuthenticated => userStatus == UserStatus.authenticated;

  AuthCubitState copyWith({
    CubitStatus? sendOTPCubitStatus,
    CubitStatus? verifyOTPCubitStatus,
    CubitStatus? getUserCubitStatus,
    CubitStatus? resendOTPCubitStatus,
    UserProfileResponseModel? userModel,
    bool clearUserModel = false,
    AppErrorModel? sendOTPAppErrorModel,
    AppErrorModel? verifyOtpAppErrorModel,
    AppErrorModel? getUserErrorModel,
    AppErrorModel? resendOTPAppErrorModel,
    String? phoneNumber,
  }) => AuthCubitState(
    sendOTPCubitStatus: sendOTPCubitStatus ?? this.sendOTPCubitStatus,
    verifyOTPCubitStatus: verifyOTPCubitStatus ?? this.verifyOTPCubitStatus,
    getUserCubitStatus: getUserCubitStatus ?? this.getUserCubitStatus,
    userModel: clearUserModel ? null : (userModel ?? this.userModel),
    sendOTPAppErrorModel: sendOTPAppErrorModel ?? this.sendOTPAppErrorModel,
    verifyOtpAppErrorModel:
        verifyOtpAppErrorModel ?? this.verifyOtpAppErrorModel,
    getUserErrorModel: getUserErrorModel ?? this.getUserErrorModel,
    resendOTPAppErrorModel:
        resendOTPAppErrorModel ?? this.resendOTPAppErrorModel,
    resendOTPCubitStatus: resendOTPCubitStatus ?? this.resendOTPCubitStatus,
    phoneNumber: phoneNumber ?? this.phoneNumber,
  );

  @override
  List<Object?> get props => [
    sendOTPCubitStatus,
    verifyOTPCubitStatus,
    getUserCubitStatus,
    userModel,
    sendOTPAppErrorModel,
    verifyOtpAppErrorModel,
    getUserErrorModel,
    resendOTPCubitStatus,
    resendOTPAppErrorModel,
    phoneNumber,
  ];
}
