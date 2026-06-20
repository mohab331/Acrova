import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/phone_input_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/widgets/luxury_phone_input.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/widgets/phone_continue_button.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/widgets/terms_and_privacy_text.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneInputView extends StatelessWidget {
  const PhoneInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return BlocListener<AuthCubit, AuthCubitState>(
      listenWhen: (prev, curr) => prev.cubitStatus != curr.cubitStatus,
      listener: _handleAuthStateListener,
      child: CommonScreen(
        resizeToAvoidBottomInset: false,
        appBar: const AppAuthBrandHeader(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.identityVerificationTitle,
              style: context.textTheme.displaySmall?.copyWith(
                color: Resources.colors.luxuryNavy,
                fontWeight: Resources.fontWeights.semiBold,
                fontSize: Resources.fontSizes.$28,
                letterSpacing: Resources.letterSpacing.$0_25,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$12),
            Text(
              l10n.identityVerificationSubtitle,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Resources.colors.luxuryBody,
                letterSpacing: Resources.letterSpacing.$0_25,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$40),
            Text(
              l10n.identityVerificationPhoneLabel,
              style: context.theme.textTheme.labelSmall?.copyWith(
                fontSize: Resources.fontSizes.$10,
                letterSpacing: Resources.letterSpacing.$1_0,
                color: Resources.colors.luxuryBody,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$8),
            const LuxuryPhoneInput(),
            SizedBox(height: Resources.verticalDims.$16),
            Text(
              l10n.smsOtpNotice,
              style: context.textTheme.bodySmall?.copyWith(
                color: Resources.colors.luxuryBodyMuted,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$40),
            const PhoneContinueButton(),
            SizedBox(height: Resources.verticalDims.$16),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Resources.colors.luxuryBody,
                ),
                child: Text(
                  l10n.identityVerificationIssue,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Resources.colors.luxuryBody,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Center(child: TermsAndPrivacyText()),
          ],
        ),
      ),
    );
  }

  void _handleAuthStateListener(BuildContext context, AuthCubitState state) {
    if (state.isSuccess) {
      context.push(
        AppRouteEnum.identityVerificationPage.name,
        extra: context.read<PhoneInputCubit>().fullPhone,
      );
    }
  }
}
