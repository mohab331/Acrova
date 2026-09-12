import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/profile/user_profile_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/validation/app_validators.dart';
import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    required this.cubitStatus,
    required this.name,
    required this.email,
    required this.mobileNumber,
    this.appErrorModel,
    this.avatarPath,
    required this.initialProfile,
  });

  factory EditProfileState.fromProfile(UserProfileModel profile) =>
      EditProfileState(
        cubitStatus: CubitStatus.initial,
        name: profile.name ?? '',
        email: profile.email ?? '',
        mobileNumber: profile.mobileNumber ?? '',
        initialProfile: profile,
      );

  final CubitStatus cubitStatus;
  final String name;
  final String email;
  final String mobileNumber;
  final AppErrorModel? appErrorModel;
  final String? avatarPath;

  final UserProfileModel? initialProfile;

  bool get enableSubmit {
    final bool isSameName =
        (initialProfile?.name?.trim().toLowerCase() ==
        name.trim().toLowerCase());
    final bool isSameEmail =
        (initialProfile?.email?.trim().toLowerCase() !=
        email.trim().toLowerCase());
    final bool isSameMobile =
        (initialProfile?.mobileNumber?.trim().toLowerCase() !=
        mobileNumber.trim().toLowerCase());
    final bool hasAvatar = (avatarPath?.isNotEmpty ?? false);

    return (!isSameMobile || !isSameEmail || !isSameName || hasAvatar) &&
        validate();
  }

  bool validate() {
    final bool isNameValid = AppValidators.name(name) == null;
    final bool isEmailValid = AppValidators.isValidEmail(email);
    final bool isMobileValid = AppValidators.isValidSaudiPhone(mobileNumber);
    return isNameValid && isEmailValid && isMobileValid;
  }

  EditProfileState copyWith({
    CubitStatus? cubitStatus,
    String? name,
    String? email,
    String? mobileNumber,
    AppErrorModel? appErrorModel,
    String? avatarPath,
    UserProfileModel? profile,
  }) => EditProfileState(
    cubitStatus: cubitStatus ?? this.cubitStatus,
    name: name ?? this.name,
    email: email ?? this.email,
    mobileNumber: mobileNumber ?? this.mobileNumber,
    appErrorModel: appErrorModel,
    avatarPath: avatarPath,
    initialProfile: profile ?? this.initialProfile,
  );

  @override
  List<Object?> get props => [
    cubitStatus,
    name,
    email,
    mobileNumber,
    avatarPath,
    appErrorModel,
    initialProfile,
  ];
}
