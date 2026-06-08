import 'dart:async';

import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class IdentityVerificationPage extends StatefulWidget {
  const IdentityVerificationPage({this.phoneNumber, super.key});

  final String? phoneNumber;

  @override
  State<IdentityVerificationPage> createState() =>
      _IdentityVerificationPageState();
}

class _IdentityVerificationPageState extends State<IdentityVerificationPage> {

  String? _localError;
  String? _pinCode;

  void _verifyCode(BuildContext context) {
    setState(() {
      _localError = null;
    });

    context.read<AuthCubit>().verifyOtpAndCheckNewUser(_pinCode ?? '');
  }

  void _resendCode(BuildContext context) {
    setState(() => _localError = null);

    final phone = widget.phoneNumber;
    if (phone != null && phone.isNotEmpty) {
      context.read<AuthCubit>().login(phone);
    }
  }
  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final phoneNumber = widget.phoneNumber ?? '';

    return BlocListener<AuthCubit, AuthCubitState>(
      listenWhen: (prev, curr) => prev.cubitStatus != curr.cubitStatus,
      listener: (context, state) {
        if (state.isSuccess) {
          if (state.isNewUser == true) {
            context.pushReplacement(AppRouteEnum.homePage.name);
          } else {
            context.pushReplacement(AppRouteEnum.homePage.name);
          }
        } else if (state.isError) {
          setState(
            () => _localError =
                state.appErrorModel?.message ??
                'Invalid code. Please try again.',
          );
        }
      },
      child: CommonScreen(
        resizeToAvoidBottomInset: false,
        appBar: const AppAuthBrandHeader(showBack: true),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.otpVerificationTitle,
              style: context.textTheme.displaySmall?.copyWith(
                color: Resources.colors.luxuryNavy,
                fontWeight: Resources.fontWeights.semiBold,
                fontSize: Resources.fontSizes.$28,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                phoneNumber.isEmpty
                    ? l10n.otpVerificationSubtitle
                    : l10n.otpVerificationSubtitleWithPhone(
                        '\n+966 •••••• ${phoneNumber.substring(9, phoneNumber.length)}',
                      ),
                textAlign: TextAlign.left,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Resources.colors.luxuryBody,

                  letterSpacing: 0.25,
                ),
              ),
            ),
            SizedBox(height: Resources.verticalDims.$40),

            Directionality(
              textDirection: TextDirection.ltr,
              child: _OtpDigitField(
                hasError: _localError != null,
                localError: _localError,
                onChanged: (v) {
                  _pinCode = v;
                },
              ),
            ),
            SizedBox(height: Resources.verticalDims.$40),
            const Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 180),
                child: _OtpTimerSection(),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: Resources.verticalDims.$55,
              width: double.infinity,
              child: AppPrimaryButton(
                label: l10n.otpVerificationCta,
                onPressed: () => _verifyCode(context),
              ),
            ),
            SizedBox(height: Resources.verticalDims.$32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.otpVerificationResendPrompt,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Resources.colors.luxuryBody,
                  ),
                ),
                SizedBox(width: Resources.horizontalDims.$4),
                TextButton(
                  onPressed: () => _resendCode(context),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    l10n.otpVerificationResend,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Resources.colors.luxuryGold,
                      fontWeight: Resources.fontWeights.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpDigitField extends StatefulWidget {
  const _OtpDigitField({
    required this.hasError,
    required this.localError,
    required this.onChanged,
  });

  final bool hasError;
  final ValueChanged<String> onChanged;
  final String? localError;

  @override
  State<_OtpDigitField> createState() => _OtpDigitFieldState();
}

class _OtpDigitFieldState extends State<_OtpDigitField> {
  final pinController = PinInputController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _OtpDigitField oldWidget) {
    pinController.setErrorState(widget.localError?.isNotEmpty ?? false);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final borderColor = pinController.hasError? Resources.colors.luxuryError : Resources.colors.luxuryInputBorder;
    return MaterialPinField(
      obscureText: true,
      pinController: pinController,
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

        errorTextStyle: context.textTheme.titleMedium?.copyWith(
          color: Colors.red.shade700,
          fontSize: 20.sp,

        ),
        errorBorderColor: Resources.colors.luxuryError,
        errorFillColor: Resources.colors.luxuryInputBg,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        cursorColor: Resources.colors.luxuryInk,
        spacing: Resources.horizontalDims.$10,
        textStyle: context.textTheme.titleMedium?.copyWith(
          color: Resources.colors.luxuryInk,
          fontSize: 20.sp,
        ),
      ),
      enableAutofill: true,
      length: 6,
      errorText: widget.localError,
      errorTextStyle: context.textTheme.bodySmall?.copyWith(
        color: Colors.red.shade700,
        fontWeight: Resources.fontWeights.medium,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: widget.onChanged,
    );
  }
}

// ── Timer Section ────────────────────────────────────────────────────────────

class _OtpTimerSection extends StatelessWidget {
  const _OtpTimerSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.localization.timeRemaining.toUpperCase(),
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: Resources.fontWeights.semiBold,
            letterSpacing: Resources.letterSpacing.$1_0,
            color: Resources.colors.luxuryGoldLight,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        const _OtpCountdownTimer(),
      ],
    );
  }
}

class _OtpCountdownTimer extends StatefulWidget {
  const _OtpCountdownTimer();

  @override
  State<_OtpCountdownTimer> createState() => _OtpCountdownTimerState();
}

class _OtpCountdownTimerState extends State<_OtpCountdownTimer> {
  static const int _initialSeconds = 300; // 5 min

  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = _initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_remaining <= 0) {
        _timer?.cancel();
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final m = _remaining ~/ 60;
    final s = _remaining % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time,
          size: 16.sp,
          color: Resources.colors.luxuryGold,
        ),
        SizedBox(width: 4.w),
        Text(
          _formattedTime,
          style: context.textTheme.labelLarge?.copyWith(
            letterSpacing: Resources.letterSpacing.$n0_9,
            color: _remaining > 60
                ? Resources.colors.luxuryNavy
                : Resources.colors.luxuryError,
          ),
        ),
      ],
    );
  }
}

// ── Inline Error ─────────────────────────────────────────────────────────────

class _InlineError extends StatelessWidget {
  const _InlineError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline_rounded,
          size: Resources.iconSizes.$16,
          color: Resources.colors.luxuryError,
        ),
        SizedBox(width: Resources.horizontalDims.$6),
        Flexible(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: Resources.colors.luxuryError,
              fontWeight: Resources.fontWeights.medium,
            ),
          ),
        ),
      ],
    );
  }
}
