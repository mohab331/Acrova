import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WizardTextField extends StatelessWidget {
  const WizardTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.onChanged,
    this.error,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;
  final String? error;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    final borderColor = hasError
        ? Resources.colors.luxuryError
        : Resources.colors.luxuryInputBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: Resources.colors.luxuryBody),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Container(
          decoration: BoxDecoration(
            color: hasError
                ? Resources.colors.luxuryError.withValues(alpha: 0.05)
                : Resources.colors.luxuryInputBg,
            borderRadius: BorderRadius.circular(Resources.radius.$r2),
            border: Border.all(color: borderColor),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization,
            onChanged: onChanged,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Resources.colors.luxuryInk,
              fontSize: Resources.fontSizes.$15,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Resources.colors.luxuryPlaceholder,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Resources.horizontalDims.$8,
                vertical: Resources.verticalDims.$12,
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Resources.radius.$r2),
                borderSide: BorderSide(
                  color: hasError
                      ? Resources.colors.luxuryError
                      : Resources.colors.luxuryGoldLight,
                  width: AppBorderWidths.$1_5,
                ),
              ),
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: Resources.verticalDims.$4),
          Text(
            error!,
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$11,
              fontWeight: Resources.fontWeights.medium,
              color: Resources.colors.luxuryError,
            ),
          ),
        ],
      ],
    );
  }
}
