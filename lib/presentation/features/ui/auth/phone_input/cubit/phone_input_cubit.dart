import 'package:acrova/core/l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/country.dart';

part 'phone_input_state.dart';

class PhoneInputCubit extends Cubit<PhoneInputState> {
  PhoneInputCubit() : super(PhoneInputState.initial());

  void onPhoneChanged(String value) {
    emit(state.copyWith(phone: value, clearError: true));
  }

  void onCountryChanged(Country country) {
    emit(state.copyWith(country: country, phone: '', clearError: true));
  }

  /// Returns `true` if valid — caller navigates; false shows inline error.
  bool validate(AppLocalizations l10n) {
    final error = PhoneValidator.validate(state.phone, state.country, l10n);
    if (error != null) {
      emit(state.copyWith(error: error));
      return false;
    }
    return true;
  }
}
