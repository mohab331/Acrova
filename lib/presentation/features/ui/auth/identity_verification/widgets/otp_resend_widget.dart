import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/cubit/otp_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/cubit/otp_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPResendWidget extends StatelessWidget {
  const OTPResendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final authCubit = context.read<AuthCubit>();
    final authState = context.watch<AuthCubit>().state;

    return BlocBuilder<OTPCubit, OTPState>(
      builder: (context, state) {
        if (!state.isTimerFinished) {
          return const SizedBox.shrink();
        }
        return Row(
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
              onPressed: authState.resendOTPCubitStatus == CubitStatus.loading
                  ? null
                  : () {
                      context.read<OTPCubit>().incrementResendOtpCount();
                      if (state.shouldBlockResend) {
                        _onResendExceedLimit(context);
                        return;
                      }
                      authCubit.resendOTP();
                    },
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
        );
      },
    );
  }

  void _onResendExceedLimit(BuildContext context) {
    CustomToastification.success(
      context: context,
      message: context.localization.resend_otp_limit,
    ).showToast();
    context.read<AuthCubit>().resetToInitial();
    context.pop();
  }
}
