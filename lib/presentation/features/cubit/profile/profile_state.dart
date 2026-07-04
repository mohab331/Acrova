import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class ProfileCubitState extends Equatable {
  const ProfileCubitState({
    required this.cubitStatus,
    this.profile,
    this.appErrorModel,
  });

  const ProfileCubitState.initial() : this(cubitStatus: CubitStatus.initial);

  final CubitStatus cubitStatus;
  final UserProfileModel? profile;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError   => cubitStatus == CubitStatus.error;

  ProfileCubitState copyWith({
    CubitStatus? cubitStatus,
    UserProfileModel? profile,
    AppErrorModel? appErrorModel,
  }) =>
      ProfileCubitState(
        cubitStatus: cubitStatus ?? this.cubitStatus,
        profile: profile ?? this.profile,
        appErrorModel: appErrorModel,
      );

  @override
  List<Object?> get props => [cubitStatus, profile, appErrorModel];
}
