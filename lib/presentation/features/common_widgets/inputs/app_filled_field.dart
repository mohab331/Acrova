import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Labeled filled input with a 2px bottom border (gold on focus) and 2px radius.
///
/// Style: input-bg fill, 2px bottom border (gold on focus), 2px radius.
/// Supports multiline (textarea) and an inline error message.
class AppFilledField extends StatelessWidget {
  const AppFilledField({
    required this.label,
    required this.controller,
    this.onChanged,
    this.readOnly = false,
    this.hint,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.inputFormatters,
    this.errorText,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
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
        TextFormField(
          readOnly: readOnly,
          enabled: !readOnly,
          inputFormatters: inputFormatters,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          errorBuilder: (context, errorText) => Text(
            errorText,
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$10,
              fontWeight: Resources.fontWeights.bold,
              letterSpacing: Resources.letterSpacing.$0_8,
              color: Resources.colors.luxuryError,
            ),
          ),
          controller: controller,
          onChanged: readOnly ? null : onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$16,
            color: Resources.colors.luxuryInk,
          ),
          decoration: InputDecoration(
            errorText: errorText,
            isDense: true,
            isCollapsed: true,
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
            border: _border(Resources.colors.luxuryBorder),
            enabledBorder: _border(Resources.colors.luxuryBorder),
            disabledBorder: _border(
              Resources.colors.luxuryBorder.withValues(alpha: 0.5),
            ),
            focusedBorder: _border(Resources.colors.luxuryGoldLight),
            errorBorder: _border(Resources.colors.luxuryError),
          ),
        ),
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
