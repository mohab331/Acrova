import 'package:acrova/data/models/request/contact_us/submit_inquiry_request_model.dart';
import 'package:acrova/domain/repository/contact_us/base_contact_us_repo.dart';
import 'package:acrova/utils/enums/contact_us_field_error_enum.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/validation/app_validators.dart';
import 'package:bloc/bloc.dart';

import 'contact_us_state.dart';

export 'package:acrova/utils/enums/contact_us_field_error_enum.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit({
    required BaseContactUsRepo contactUsRepo,
    String email = '',
    String mobileNumber = '',
  }) : _contactUsRepo = contactUsRepo,
       super(ContactUsState.initial(email: email, mobileNumber: mobileNumber));

  final BaseContactUsRepo _contactUsRepo;

  void updateEmail(String value) =>
      emit(state.copyWith(email: value, emailError: () => null));

  void updateMobile(String value) => emit(state.copyWith(mobileNumber: value));

  void updateDetails(String value) =>
      emit(state.copyWith(details: value, detailsError: () => null));

  Future<void> submit({
    required String Function(ContactUsFieldError) resolve,
  }) async {
    final email = state.email.trim();
    final details = state.details.trim();

    final emailInvalid = email.isNotEmpty && !AppValidators.isValidEmail(email);
    final detailsMissing = details.isEmpty;

    if (emailInvalid || detailsMissing) {
      emit(
        state.copyWith(
          emailError: () =>
              emailInvalid ? resolve(ContactUsFieldError.emailInvalid) : null,
          detailsError: () => detailsMissing
              ? resolve(ContactUsFieldError.detailsRequired)
              : null,
        ),
      );
      return;
    }

    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    final result = await _contactUsRepo.submitInquiry(
      SubmitInquiryRequestModel(
        email: email,
        mobileNumber: state.mobileNumber.trim(),
        details: details,
      ),
    );
    result.when(
      success: (_) => emit(state.copyWith(cubitStatus: CubitStatus.success)),
      failure: (error) => emit(
        state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
      ),
    );
  }
}
