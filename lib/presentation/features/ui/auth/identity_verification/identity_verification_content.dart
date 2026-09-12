import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/cubit/otp_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/cubit/otp_state.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/otp_digit_field.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/otp_resend_widget.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/otp_timer_section.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/api_error_l10n_x.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentityVerificationContent extends StatelessWidget {
  const IdentityVerificationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final authCubit = context.read<AuthCubit>();
    final authState = context.watch<AuthCubit>().state;
    var verifyOtpAppErrorModel = authState.verifyOtpAppErrorModel;
    final phoneNumber = authState.phoneNumber ?? '';

    final otpCubit = context.read<OTPCubit>();

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthCubitState>(
          listenWhen: (previous, current) =>
              previous.verifyOTPCubitStatus != current.verifyOTPCubitStatus,
          listener: (context, state) {
            if (state.verifyOTPCubitStatus == CubitStatus.success) {
              context.pushReplacement(AppRouteEnum.homePage.name);
            }
          },
        ),

        BlocListener<AuthCubit, AuthCubitState>(
          listenWhen: (previous, current) =>
              previous.resendOTPCubitStatus != current.resendOTPCubitStatus,
          listener: (context, state) {
            if (state.resendOTPCubitStatus == CubitStatus.success) {
              CustomToastification.success(
                context: context,
                message: context.localization.resend_otp_success,
              ).showToast();
            }

            if (state.resendOTPCubitStatus == CubitStatus.error) {
              context.read<OTPCubit>().decrementResendOtpCount();
            }
          },
        ),

        BlocListener<OTPCubit, OTPState>(listener: (context, state) {}),
      ],
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
                      '\n+966 •••••• ${phoneNumber.substring(10)}',
                    ),
              textAlign: TextAlign.left,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Resources.colors.luxuryBody,
                letterSpacing: Resources.letterSpacing.$0_25,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$40),
            Center(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: OtpDigitField(
                  hasError: authState.verifyOTPCubitStatus == CubitStatus.error,
                  localError:
                      verifyOtpAppErrorModel?.message ??
                      verifyOtpAppErrorModel?.code.messageOf(context),
                  onChanged: otpCubit.onOTPChanged,
                ),
              ),
            ),
            SizedBox(height: Resources.verticalDims.$40),
            const Center(
              child: AnimatedSwitcher(
                duration: AppDurations.otpCountdown,
                child: OtpTimerSection(duration: AppDurations.otpCountdown),
              ),
            ),
            const Spacer(),
            BlocBuilder<OTPCubit, OTPState>(
              builder: (context, state) {
                final isLoading =
                    (authState.verifyOTPCubitStatus == CubitStatus.loading);
                var isEnabled = ((state.otp?.length ?? 0) >= 6);
                return SizedBox(
                  height: Resources.verticalDims.$55,
                  width: double.infinity,
                  child: AppPrimaryButton(
                    label: l10n.otpVerificationCta,
                    onPressed: () => authCubit.verifyOtp(state.otp),
                    enabled: isEnabled,
                    isLoading: isLoading,
                  ),
                );
              },
            ),
            SizedBox(height: Resources.verticalDims.$32),
            const OTPResendWidget(),
          ],
        ),
      ),
    );
  }

  void _handleAuthStateListener(BuildContext context, AuthCubitState state) {
    if (state.verifyOTPCubitStatus == CubitStatus.success) {
      context.pushReplacement(AppRouteEnum.homePage.name);
      return;
    }

    if (state.resendOTPCubitStatus == CubitStatus.success) {
      CustomToastification.success(
        context: context,
        message: context.localization.resend_otp_success,
      ).showToast();
      return;
    }

    if (state.resendOTPCubitStatus == CubitStatus.error) {
      context.read<OTPCubit>().decrementResendOtpCount();
    }
  }
}
