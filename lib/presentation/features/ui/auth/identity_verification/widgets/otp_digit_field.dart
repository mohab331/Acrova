import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpDigitField extends StatefulWidget {
  const OtpDigitField({
    required this.hasError,
    required this.localError,
    required this.onChanged,
    super.key,
  });

  final bool hasError;
  final ValueChanged<String> onChanged;
  final String? localError;

  @override
  State<OtpDigitField> createState() => _OtpDigitFieldState();
}

class _OtpDigitFieldState extends State<OtpDigitField> {
  final _pinController = PinInputController();

  @override
  void didUpdateWidget(covariant OtpDigitField oldWidget) {
    _pinController.setErrorState(widget.localError?.isNotEmpty ?? false);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _pinController.hasError
        ? Resources.colors.luxuryError
        : Resources.colors.luxuryInputBorder;

    return MaterialPinField(
      obscureText: true,
      pinController: _pinController,
      theme: MaterialPinTheme(
        obscuringCharacter: '*',
        borderColor: borderColor,
        fillColor: Resources.colors.luxuryInputBg,
        focusedFillColor: Resources.colors.luxuryInputBg,
        focusedBorderColor: Resources.colors.luxuryGoldLight,
        errorColor: Resources.colors.luxuryError,
        filledBorderColor: Resources.colors.luxuryGoldBorder,
        borderWidth: 1,
        cursorWidth: 1,
        errorBorderWidth: 1,
        errorTextStyle: TextStyle(
          color: Resources.colors.luxuryError,
          fontSize: Resources.fontSizes.$20,
        ),
        errorBorderColor: Resources.colors.luxuryError,
        errorFillColor: Resources.colors.luxuryInputBg,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        cursorColor: Resources.colors.luxuryInk,
        spacing: Resources.horizontalDims.$10,
        textStyle: TextStyle(
          color: Resources.colors.luxuryInk,
          fontSize: Resources.fontSizes.$20,
        ),
      ),
      enableAutofill: true,
      length: 6,
      errorText: widget.localError,
      errorTextStyle: TextStyle(
        color: Resources.colors.luxuryError,
        fontWeight: Resources.fontWeights.medium,
        fontSize: Resources.fontSizes.$12,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: widget.onChanged,
    );
  }
}
