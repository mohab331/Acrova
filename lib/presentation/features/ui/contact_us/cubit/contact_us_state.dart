import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class ContactUsState extends Equatable {
  const ContactUsState({
    required this.cubitStatus,
    required this.email,
    required this.mobileNumber,
    required this.details,
    this.emailError,
    this.detailsError,
    this.appErrorModel,
  });

  factory ContactUsState.initial({
    String email = '',
    String mobileNumber = '',
  }) =>
      ContactUsState(
        cubitStatus: CubitStatus.initial,
        email: email,
        mobileNumber: mobileNumber,
        details: '',
      );

  final CubitStatus cubitStatus;
  final String email;
  final String mobileNumber;
  final String details;
  final String? emailError;
  final String? detailsError;
  final AppErrorModel? appErrorModel;

  bool get isSubmitting => cubitStatus == CubitStatus.loading;
  bool get isSuccess    => cubitStatus == CubitStatus.success;
  bool get isError      => cubitStatus == CubitStatus.error;

  ContactUsState copyWith({
    CubitStatus? cubitStatus,
    String? email,
    String? mobileNumber,
    String? details,
    String? Function()? emailError,
    String? Function()? detailsError,
    AppErrorModel? appErrorModel,
  }) =>
      ContactUsState(
        cubitStatus: cubitStatus ?? this.cubitStatus,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        details: details ?? this.details,
        emailError: emailError != null ? emailError() : this.emailError,
        detailsError: detailsError != null ? detailsError() : this.detailsError,
        appErrorModel: appErrorModel,
      );

  @override
  List<Object?> get props => [
        cubitStatus,
        email,
        mobileNumber,
        details,
        emailError,
        detailsError,
        appErrorModel,
      ];
}
