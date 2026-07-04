import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    required this.cubitStatus,
    required this.name,
    required this.email,
    required this.mobileNumber,
    this.avatarPath,
    this.avatarUrl,
    this.avatarRemoved = false,
    this.nameError,
    this.emailError,
    this.mobileError,
    this.showErrorBanner = false,
    this.updatedProfile,
    this.appErrorModel,
  });

  factory EditProfileState.fromProfile(UserProfileModel profile) =>
      EditProfileState(
        cubitStatus: CubitStatus.initial,
        name: profile.name,
        email: profile.email,
        mobileNumber: profile.mobileNumber,
        avatarUrl: profile.avatarUrl,
      );

  final CubitStatus cubitStatus;
  final String name;
  final String email;
  final String mobileNumber;

  /// Local path of a newly-picked avatar.
  final String? avatarPath;

  /// Existing remote avatar url.
  final String? avatarUrl;

  /// Whether the user removed the current photo (shows placeholder).
  final bool avatarRemoved;

  final String? nameError;
  final String? emailError;
  final String? mobileError;

  /// Whether the top "please correct errors" banner is visible.
  final bool showErrorBanner;

  /// Set on a successful save.
  final UserProfileModel? updatedProfile;

  final AppErrorModel? appErrorModel;

  bool get isSubmitting => cubitStatus == CubitStatus.loading;
  bool get isSuccess    => cubitStatus == CubitStatus.success;
  bool get isError      => cubitStatus == CubitStatus.error;

  EditProfileState copyWith({
    CubitStatus? cubitStatus,
    String? name,
    String? email,
    String? mobileNumber,
    String? avatarPath,
    String? avatarUrl,
    bool? avatarRemoved,
    String? Function()? nameError,
    String? Function()? emailError,
    String? Function()? mobileError,
    bool? showErrorBanner,
    UserProfileModel? updatedProfile,
    AppErrorModel? appErrorModel,
  }) =>
      EditProfileState(
        cubitStatus: cubitStatus ?? this.cubitStatus,
        name: name ?? this.name,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        avatarPath: avatarPath ?? this.avatarPath,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        avatarRemoved: avatarRemoved ?? this.avatarRemoved,
        nameError: nameError != null ? nameError() : this.nameError,
        emailError: emailError != null ? emailError() : this.emailError,
        mobileError: mobileError != null ? mobileError() : this.mobileError,
        showErrorBanner: showErrorBanner ?? this.showErrorBanner,
        updatedProfile: updatedProfile ?? this.updatedProfile,
        appErrorModel: appErrorModel,
      );

  @override
  List<Object?> get props => [
        cubitStatus,
        name,
        email,
        mobileNumber,
        avatarPath,
        avatarUrl,
        avatarRemoved,
        nameError,
        emailError,
        mobileError,
        showErrorBanner,
        updatedProfile,
        appErrorModel,
      ];
}
