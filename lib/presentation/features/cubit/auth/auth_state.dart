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
    required this.userStatus,
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
        userStatus: null,
      );

  final CubitStatus sendOTPCubitStatus;
  final CubitStatus verifyOTPCubitStatus;
  final CubitStatus getUserCubitStatus;
  final CubitStatus resendOTPCubitStatus;

  final UserStatus? userStatus;
  final AppErrorModel? resendOTPAppErrorModel;
  final UserProfileResponseModel? userModel;
  final AppErrorModel? sendOTPAppErrorModel;
  final AppErrorModel? verifyOtpAppErrorModel;
  final AppErrorModel? getUserErrorModel;
  final String? phoneNumber;
  bool get isProfileCompleted {
    return isFullyAuthenticated && (userModel?.isProfileComplete ?? false);
  }

  bool get isFullyAuthenticated => userStatus == UserStatus.authenticated;
  bool get isVisitor => userStatus == UserStatus.visitor;
  bool get isGuest =>
      userStatus == null ||
      isVisitor ||
      userStatus == UserStatus.unauthenticated;

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
    UserStatus? userStatus,
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
    userStatus: userStatus ?? this.userStatus,
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
    userStatus,
  ];
}
