import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/phone_input_cubit.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneContinueButton extends StatelessWidget {
  const PhoneContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneInputCubit, PhoneInputState>(
      builder: (context, phoneState) {
        return BlocBuilder<AuthCubit, AuthCubitState>(
          builder: (context, authState) {
            return AppPrimaryButton(
              label: context.localization.identityVerificationContinue,
              isLoading: authState.isLoading,
              onPressed: () {
                FocusScope.of(context).unfocus();
                final phoneCubit = context.read<PhoneInputCubit>();
                if (phoneCubit.validate(context.localization)) {
                  context.read<AuthCubit>().login(phoneCubit.fullPhone);
                }
              },
            );
          },
        );
      },
    );
  }
}
