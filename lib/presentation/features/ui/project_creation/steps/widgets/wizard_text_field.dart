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
    this.keyboardType,
    this.inputFormatters,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Resources.colors.luxuryBody,
              ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Container(
          decoration: BoxDecoration(
            color: Resources.colors.luxuryInputBg,
            borderRadius: BorderRadius.circular(Resources.radius.$r2),
            border: Border.all(color: Resources.colors.luxuryInputBorder),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
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
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Resources.radius.$r2),
                borderSide: BorderSide(
                  color: Resources.colors.luxuryGoldLight,
                  width: AppBorderWidths.$1_5,
                ),
              ),
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
