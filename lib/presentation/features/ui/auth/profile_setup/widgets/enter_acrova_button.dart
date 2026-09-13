import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class EnterAcrovaButton extends StatelessWidget {
  const EnterAcrovaButton({
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      label: context.localization.submit,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }
}
