import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/auth/profile_setup/widgets/language_option.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Row(
      children: [
        Expanded(
          child: LanguageOption(
            label: l10n.profileSetupLanguageEn,
            value: 'en',
            selected: selected,
            onTap: onChanged,
          ),
        ),
        SizedBox(width: Resources.horizontalDims.$12),
        Expanded(
          child: LanguageOption(
            label: l10n.profileSetupLanguageAr,
            value: 'ar',
            selected: selected,
            onTap: onChanged,
          ),
        ),
      ],
    );
  }
}
