import 'package:acrova/domain/repository/contact_us/base_contact_us_repo.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
import 'package:acrova/utils/validation/app_validators.dart';
import 'package:bloc/bloc.dart';

import 'contact_us_state.dart';

/// Validation error codes — resolved to localized strings in the UI layer.
enum ContactUsFieldError { emailInvalid, detailsRequired }

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

    await safeCubitCall<void>(
      call: () => _contactUsRepo.submitInquiry(
        email: email,
        mobileNumber: state.mobileNumber.trim(),
        details: details,
      ),
      onSuccess: (_) => emit(state.copyWith(cubitStatus: CubitStatus.success)),
      onError: (error) => emit(
        state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
      ),
    );
  }
}
