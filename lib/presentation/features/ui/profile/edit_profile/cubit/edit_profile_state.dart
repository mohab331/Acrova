import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';
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
    required this.nationalID,
  });

  factory EditProfileState.fromProfile(UserProfileResponseModel profile) =>
      EditProfileState(
        cubitStatus: CubitStatus.initial,
        name: profile.name ?? '',
        email: profile.email ?? '',
        mobileNumber: profile.mobileNumber ?? '',
        initialProfile: profile,
        nationalID: profile.nationalId ?? '',
        avatarPath: profile.avatarUrl,
      );

  final CubitStatus cubitStatus;
  final String name;
  final String email;
  final String mobileNumber;
  final String nationalID;
  final AppErrorModel? appErrorModel;
  final String? avatarPath;

  final UserProfileResponseModel? initialProfile;

  bool get enableSubmit {
    final isSameName =
        initialProfile?.name?.trim().toLowerCase() == name.trim().toLowerCase();

    final isSameEmail =
        initialProfile?.email?.trim().toLowerCase() ==
        email.trim().toLowerCase();

    final isSameMobile =
        initialProfile?.mobileNumber?.trim() == mobileNumber.trim();

    final isSameNationalId =
        initialProfile?.nationalId?.trim() == nationalID.trim();

    final hasAvatarChanged = avatarPath != initialProfile?.avatarUrl;

    final hasChanges =
        !isSameName ||
        !isSameEmail ||
        !isSameMobile ||
        !isSameNationalId ||
        hasAvatarChanged;

    return hasChanges && validate();
  }

  bool validate() {
    final nameTrimmed = name.trim();
    final emailTrimmed = email.trim();
    final mobileTrimmed = mobileNumber.trim();
    final nationalIDTrimmed = nationalID.trim();

    final bool isNameValid = AppValidators.name(nameTrimmed) == null;
    final bool isEmailValid =
        emailTrimmed.isEmpty || AppValidators.isValidEmail(emailTrimmed);
    final bool isMobileValid = AppValidators.isValidSaudiPhone(mobileTrimmed);
    final bool isNationalValid = AppValidators.isValidSaudiNationalId(
      nationalIDTrimmed,
    );
    return isNameValid && isEmailValid && isMobileValid && isNationalValid;
  }

  EditProfileState copyWith({
    CubitStatus? cubitStatus,
    String? name,
    String? email,
    String? mobileNumber,
    AppErrorModel? appErrorModel,
    String? avatarPath,
    UserProfileResponseModel? profile,
    String? nationalId,
  }) => EditProfileState(
    cubitStatus: cubitStatus ?? this.cubitStatus,
    name: name ?? this.name,
    email: email ?? this.email,
    mobileNumber: mobileNumber ?? this.mobileNumber,
    appErrorModel: appErrorModel,
    avatarPath: avatarPath ?? this.avatarPath,
    initialProfile: profile ?? initialProfile,
    nationalID: nationalId ?? this.nationalID,
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
    nationalID,
  ];
}
