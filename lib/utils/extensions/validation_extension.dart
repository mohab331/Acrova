import 'package:acrova/utils/validation/app_validators.dart';

/// String extensions for convenient validation.
extension StringValidationX on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String? validateRequired([String message = 'This field is required']) =>
      AppValidators.required(this, message);

  String? validateEmail({
    String requiredMessage = 'Email is required',
    String invalidMessage = 'Please enter a valid email address',
  }) => AppValidators.email(
    this,
    requiredMessage: requiredMessage,
    invalidMessage: invalidMessage,
  );

  String? validateSaudiPhone({
    String requiredMessage = 'Phone number is required',
    String invalidMessage =
        'Please enter a valid 9-digit Saudi mobile number starting with 5',
  }) => AppValidators.saudiPhone(
    this,
    requiredMessage: requiredMessage,
    invalidMessage: invalidMessage,
  );

  String? validateOtp({
    int length = 6,
    String requiredMessage = 'Verification code is required',
    String invalidMessage = 'Please enter a valid verification code',
  }) => AppValidators.otp(
    this,
    length: length,
    requiredMessage: requiredMessage,
    invalidMessage: invalidMessage,
  );

  String? validateSaudiIban({
    String requiredMessage = 'IBAN is required',
    String invalidMessage =
        'Please enter a valid Saudi IBAN (SA followed by 22 digits)',
  }) => AppValidators.saudiIban(
    this,
    requiredMessage: requiredMessage,
    invalidMessage: invalidMessage,
  );

  String? validateSaudiNationalId({
    String requiredMessage = 'National ID / Iqama is required',
    String invalidMessage =
        'National ID must be 10 digits starting with 1 or 2',
  }) => AppValidators.saudiNationalId(
    this,
    requiredMessage: requiredMessage,
    invalidMessage: invalidMessage,
  );

  String? validateUrl({
    String requiredMessage = 'URL is required',
    String invalidMessage =
        'Please enter a valid URL starting with http:// or https://',
  }) => AppValidators.url(
    this,
    requiredMessage: requiredMessage,
    invalidMessage: invalidMessage,
  );

  String? validateNumeric({
    String requiredMessage = 'This field is required',
    String invalidMessage = 'Please enter a valid number',
    bool allowDecimal = false,
  }) => AppValidators.numeric(
    this,
    requiredMessage: requiredMessage,
    invalidMessage: invalidMessage,
    allowDecimal: allowDecimal,
  );

  String? validateAmount({
    String requiredMessage = 'Amount is required',
    String invalidMessage = 'Please enter a valid amount',
    double? min,
    double? max,
    String? minMessage,
    String? maxMessage,
  }) => AppValidators.amount(
    this,
    requiredMessage: requiredMessage,
    invalidMessage: invalidMessage,
    min: min,
    max: max,
    minMessage: minMessage,
    maxMessage: maxMessage,
  );

  String? validateName({
    int minLength = 2,
    String requiredMessage = 'Name is required',
    String invalidMessage = 'Name is too short',
  }) => AppValidators.name(
    this,
    minLength: minLength,
    requiredMessage: requiredMessage,
    invalidMessage: invalidMessage,
  );
}
