part of 'phone_input_cubit.dart';

class PhoneInputState extends Equatable {
  const PhoneInputState({
    required this.country,
    required this.phone,
    this.error,
  });

  factory PhoneInputState.initial() => PhoneInputState(
        country: kSupportedCountries.first,
        phone: '',
      );

  final Country country;
  final String phone;
  final String? error;

  PhoneInputState copyWith({
    Country? country,
    String? phone,
    String? error,
    bool clearError = false,
  }) {
    return PhoneInputState(
      country: country ?? this.country,
      phone:   phone   ?? this.phone,
      error:   clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [country.iso2, phone, error];
}
