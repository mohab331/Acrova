import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/sheets/app_sheet_handle.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

/// Bottom sheet for selecting the app language.
///
/// Resolves to the chosen language code ('en' | 'ar') on Confirm, or null.
class ChangeLanguageSheet extends StatefulWidget {
  const ChangeLanguageSheet({required this.currentCode, super.key});

  final String currentCode;

  static Future<String?> show(BuildContext context, String currentCode) {
    return showModalBottomSheet<String>(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      barrierColor: Resources.colors.luxuryInk.withValues(alpha: 0.4),
      isScrollControlled: true,
      builder: (_) => ChangeLanguageSheet(currentCode: currentCode),
    );
  }

  @override
  State<ChangeLanguageSheet> createState() => _ChangeLanguageSheetState();
}

class _ChangeLanguageSheetState extends State<ChangeLanguageSheet> {
  late String _selected = widget.currentCode;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Resources.radius.$r8),
        ),
        boxShadow: AppShadows.sheet,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppSheetHandle(),
            SizedBox(height: Resources.verticalDims.$8),
            _LanguageOptionRow(
              label: l10n.languageEnglish,
              fontFamily: Resources.fonts.manrope,
              selected: _selected == 'en',
              onTap: () => setState(() => _selected = 'en'),
            ),
            Divider(height: 1, color: Resources.colors.luxuryBorder),
            _LanguageOptionRow(
              label: l10n.languageArabic,
              fontFamily: Resources.fonts.ibmPlexArabic,
              selected: _selected == 'ar',
              onTap: () => setState(() => _selected = 'ar'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                Resources.horizontalDims.$24,
                Resources.verticalDims.$28,
                Resources.horizontalDims.$24,
                Resources.verticalDims.$12,
              ),
              child: AppPrimaryButton(
                label: l10n.commonConfirm,
                onPressed: () => Navigator.of(context).pop(_selected),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOptionRow extends StatelessWidget {
  const _LanguageOptionRow({
    required this.label,
    required this.fontFamily,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String fontFamily;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$24,
          vertical: Resources.verticalDims.$18,
        ),
        child: Row(
          children: [
            Icon(
              Icons.language,
              size: Resources.iconSizes.$18,
              color: selected
                  ? Resources.colors.luxuryGold
                  : Resources.colors.luxuryBody,
            ),
            SizedBox(width: Resources.horizontalDims.$6),
            Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: Resources.fontSizes.$16,
                fontWeight: selected
                    ? Resources.fontWeights.semiBold
                    : Resources.fontWeights.regular,
                color: Resources.colors.luxuryNavy,
              ),
            ),
            if (selected) ...[
              const Spacer(),
              Icon(
                Icons.check,
                color: Resources.colors.luxuryGold,
                size: Resources.iconSizes.$24,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
