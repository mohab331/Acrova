import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'contact_us_state.dart';

/// Validation error codes — resolved to localized strings in the UI layer.
enum ContactUsFieldError { emailInvalid, detailsRequired }

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit({String email = '', String mobileNumber = ''})
      : super(ContactUsState.initial(email: email, mobileNumber: mobileNumber));

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  void updateEmail(String value) =>
      emit(state.copyWith(email: value, emailError: () => null));

  void updateMobile(String value) => emit(state.copyWith(mobileNumber: value));

  void updateDetails(String value) =>
      emit(state.copyWith(details: value, detailsError: () => null));

  /// Validates and submits the inquiry (mock — no support backend yet).
  Future<void> submit({
    required String Function(ContactUsFieldError) resolve,
  }) async {
    final email = state.email.trim();
    final details = state.details.trim();

    final emailInvalid = email.isNotEmpty && !_emailRegex.hasMatch(email);
    final detailsMissing = details.isEmpty;

    if (emailInvalid || detailsMissing) {
      emit(state.copyWith(
        emailError: () =>
            emailInvalid ? resolve(ContactUsFieldError.emailInvalid) : null,
        detailsError: () =>
            detailsMissing ? resolve(ContactUsFieldError.detailsRequired) : null,
      ));
      return;
    }

    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    // Mock submission until a support backend exists.
    await Future<void>.delayed(const Duration(milliseconds: 900));
    emit(state.copyWith(cubitStatus: CubitStatus.success));
  }
}
