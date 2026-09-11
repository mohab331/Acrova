import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Floating-label "ghost border" text field used across profile forms.
///
/// - Default: `luxuryProgressTrack` fill, gold ghost border.
/// - Error:   error-tinted fill + error border + inline error message.
/// The uppercase gold label sits inside the box, above the input.
class AppGhostField extends StatelessWidget {
  const AppGhostField({
    required this.controller,
    required this.label,
    required this.onChanged,
    this.hint,
    this.error,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final ValueChanged<String> onChanged;
  final String? hint;
  final String? error;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final hasError = error != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: hasError
                ? Resources.colors.luxuryError.withValues(alpha: 0.08)
                : Resources.colors.luxuryProgressTrack,
            borderRadius: BorderRadius.circular(Resources.radius.$r2),
            border: Border.all(
              color: hasError
                  ? Resources.colors.luxuryError
                  : Resources.colors.luxuryGoldBorder,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$16,
            vertical: Resources.verticalDims.$8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: Resources.fonts.manrope,
                  fontSize: Resources.fontSizes.$10,
                  fontWeight: Resources.fontWeights.bold,
                  letterSpacing: Resources.letterSpacing.$1_0,
                  color: Resources.colors.luxuryGold,
                ),
              ),
              TextField(
                controller: controller,
                onChanged: onChanged,
                keyboardType: keyboardType,
                textCapitalization: textCapitalization,
                inputFormatters: inputFormatters,
                style: TextStyle(
                  fontFamily: Resources.fonts.manrope,
                  fontSize: Resources.fontSizes.$16,
                  color: Resources.colors.luxuryInk,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.only(top: Resources.verticalDims.$4),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(
                    fontFamily: Resources.fonts.manrope,
                    fontSize: Resources.fontSizes.$16,
                    color: Resources.colors.luxuryPlaceholder,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasError) ...[
          SizedBox(height: Resources.verticalDims.$4),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Resources.horizontalDims.$16,
            ),
            child: Text(
              error!,
              style: TextStyle(
                fontFamily: Resources.fonts.manrope,
                fontSize: Resources.fontSizes.$10,
                fontWeight: Resources.fontWeights.bold,
                letterSpacing: Resources.letterSpacing.$1_0,
                color: Resources.colors.luxuryError,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
