import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/validation/app_validators.dart';
import 'package:equatable/equatable.dart';

class ProfileCompletionState extends Equatable {
  const ProfileCompletionState({
    required this.cubitStatus,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.nationalId,
    required this.language,
    this.avatarPath,
    this.appErrorModel,
  });

  const ProfileCompletionState.initial({
    String mobileNumber = '',
    String language = 'en',
  }) : this(
         cubitStatus: CubitStatus.initial,
         name: '',
         email: '',
         mobileNumber: mobileNumber,
         nationalId: '',
         language: language,
         avatarPath: null,
         appErrorModel: null,
       );

  final CubitStatus cubitStatus;
  final String name;
  final String email;
  final String mobileNumber;
  final String nationalId;
  final String language;
  final String? avatarPath;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError => cubitStatus == CubitStatus.error;

  bool validate() {
    final bool isNameValid = AppValidators.name(name.trim()) == null;
    final bool isEmailValid = AppValidators.isValidEmail(email.trim());
    final bool isMobileValid =
        mobileNumber.trim().isNotEmpty &&
        (AppValidators.isValidSaudiPhone(mobileNumber.trim()) ||
            AppValidators.isValidPhone(mobileNumber.trim()));
    final bool isIdValid =
        AppValidators.saudiNationalId(nationalId.trim()) == null;
    return isNameValid && isEmailValid && isMobileValid && isIdValid;
  }

  ProfileCompletionState copyWith({
    CubitStatus? cubitStatus,
    String? name,
    String? email,
    String? mobileNumber,
    String? nationalId,
    String? language,
    String? avatarPath,
    bool clearAvatar = false,
    AppErrorModel? appErrorModel,
  }) {
    return ProfileCompletionState(
      cubitStatus: cubitStatus ?? this.cubitStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      nationalId: nationalId ?? this.nationalId,
      language: language ?? this.language,
      avatarPath: clearAvatar ? null : (avatarPath ?? this.avatarPath),
      appErrorModel: appErrorModel,
    );
  }

  @override
  List<Object?> get props => [
    cubitStatus,
    name,
    email,
    mobileNumber,
    nationalId,
    language,
    avatarPath,
    appErrorModel,
  ];
}
