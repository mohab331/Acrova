import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

/// Labeled filled input with a 2px bottom border (gold on focus) and 2px radius.
///
/// Style: input-bg fill, 2px bottom border (gold on focus), 2px radius.
/// Supports multiline (textarea) and an inline error message.
class AppFilledField extends StatelessWidget {
  const AppFilledField({
    required this.label,
    required this.controller,
    required this.onChanged,
    this.hint,
    this.error,
    this.keyboardType,
    this.maxLines = 1,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? hint;
  final String? error;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final hasError = error != null;
    final borderColor =
        hasError ? Resources.colors.luxuryError : Resources.colors.luxuryBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$10,
            fontWeight: Resources.fontWeights.bold,
            letterSpacing: Resources.letterSpacing.$0_8,
            color: Resources.colors.luxuryBodyMuted,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$4),
        TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$16,
            color: Resources.colors.luxuryInk,
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Resources.colors.luxuryInputBg,
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$16,
              color: Resources.colors.luxuryPlaceholder,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Resources.horizontalDims.$8,
              vertical: Resources.verticalDims.$18,
            ),
            border: _border(borderColor),
            enabledBorder: _border(borderColor),
            focusedBorder: _border(
              hasError
                  ? Resources.colors.luxuryError
                  : Resources.colors.luxuryGoldLight,
            ),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: Resources.verticalDims.$4),
          Text(
            error!,
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$10,
              fontWeight: Resources.fontWeights.bold,
              letterSpacing: Resources.letterSpacing.$0_8,
              color: Resources.colors.luxuryError,
            ),
          ),
        ],
      ],
    );
  }

  UnderlineInputBorder _border(Color color) => UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: AppBorderWidths.$2),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Resources.radius.$r2),
        ),
      );
}
