import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'models/country.dart';

part 'phone_input_state.dart';

class PhoneInputCubit extends Cubit<PhoneInputState> {
  PhoneInputCubit() : super(PhoneInputState.initial());

  void onPhoneChanged(String value) {
    final formatted = PhoneFormatter.format(value, state.country);
    emit(state.copyWith(phone: formatted, clearError: true));
  }

  void onCountryChanged(Country country) {
    emit(state.copyWith(country: country, phone: '', clearError: true));
  }

  /// Returns `true` if valid — caller navigates; false shows inline error.
  bool validate() {
    final error = PhoneValidator.validate(state.phone, state.country);
    if (error != null) {
      emit(state.copyWith(error: error));
      return false;
    }
    return true;
  }

  /// Full E.164-like phone string passed to the backend: e.g. "+96651XXXXXXX"
  String get fullPhone =>
      '${state.country.code}${state.phone.replaceAll(' ', '')}';
}
