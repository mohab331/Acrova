import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/otp_digit_field.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/otp_timer_section.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    setState(() => _localError = null);
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
          context.pushReplacement(AppRouteEnum.homePage.name);
        } else if (state.isError) {
          final fallback = context.localization.otpVerificationCodeError;
          setState(() => _localError = state.appErrorModel?.message ?? fallback);
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
            Text(
              phoneNumber.isEmpty
                  ? l10n.otpVerificationSubtitle
                  : l10n.otpVerificationSubtitleWithPhone(
                      '\n+966 •••••• ${phoneNumber.substring(9)}',
                    ),
              textAlign: TextAlign.left,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Resources.colors.luxuryBody,
                letterSpacing: Resources.letterSpacing.$0_25,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$40),
            Directionality(
              textDirection: TextDirection.ltr,
              child: OtpDigitField(
                hasError: _localError != null,
                localError: _localError,
                onChanged: (v) => _pinCode = v,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$40),
            const Center(
              child: AnimatedSwitcher(
                duration: AppDurations.fast,
                child: OtpTimerSection(),
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
