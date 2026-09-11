import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/inputs/app_filled_field.dart';
import 'package:acrova/presentation/features/ui/contact_us/cubit/contact_us_cubit.dart';
import 'package:acrova/presentation/features/ui/contact_us/cubit/contact_us_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsForm extends StatelessWidget {
  const ContactUsForm({
    required this.emailController,
    required this.mobileController,
    required this.detailsController,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController detailsController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final cubit = context.read<ContactUsCubit>();

    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$24),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
        boxShadow: AppShadows.card,
      ),
      child: BlocBuilder<ContactUsCubit, ContactUsState>(
        buildWhen: (p, c) =>
            p.emailError != c.emailError ||
            p.detailsError != c.detailsError ||
            p.isSubmitting != c.isSubmitting,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppFilledField(
                label: l10n.contactUsEmailLabel,
                controller: emailController,
                error: state.emailError,
                keyboardType: TextInputType.emailAddress,
                onChanged: cubit.updateEmail,
              ),
              SizedBox(height: Resources.verticalDims.$16),
              AppFilledField(
                label: l10n.contactUsMobileLabel,
                controller: mobileController,
                keyboardType: TextInputType.phone,
                onChanged: cubit.updateMobile,
              ),
              SizedBox(height: Resources.verticalDims.$16),
              AppFilledField(
                label: l10n.contactUsDetailsLabel,
                controller: detailsController,
                hint: l10n.contactUsDetailsHint,
                error: state.detailsError,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                onChanged: cubit.updateDetails,
              ),
              SizedBox(height: Resources.verticalDims.$24),
              AppPrimaryButton(
                label: l10n.contactUsSubmit,
                isLoading: state.isSubmitting,
                onPressed: () => cubit.submit(
                  resolve: (code) => _resolve(context, code),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _resolve(BuildContext context, ContactUsFieldError code) {
    final l10n = context.localization;
    return switch (code) {
      ContactUsFieldError.emailInvalid => l10n.contactUsEmailInvalid,
      ContactUsFieldError.detailsRequired => l10n.contactUsDetailsRequired,
    };
  }
}
