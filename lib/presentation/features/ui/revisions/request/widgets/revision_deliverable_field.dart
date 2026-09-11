import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class RevisionDeliverableField extends StatelessWidget {
  const RevisionDeliverableField({
    required this.label,
    required this.hint,
    required this.options,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String hint;
  final List<String> options;
  final String? selected;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$14,
            fontWeight: Resources.fontWeights.medium,
            color: Resources.colors.luxuryNavy,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        DropdownButtonFormField<String>(
          initialValue: selected,
          isExpanded: true,
          icon: Icon(
            Icons.expand_more,
            color: Resources.colors.luxuryBodyMuted,
            size: Resources.iconSizes.$24,
          ),
          hint: Text(
            hint,
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$16,
              color: Resources.colors.luxuryPlaceholder,
            ),
          ),
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$16,
            color: Resources.colors.luxuryInk,
          ),
          dropdownColor: Resources.colors.luxurySurface,
          decoration: InputDecoration(
            filled: true,
            fillColor: Resources.colors.luxuryInputBg,
            contentPadding: EdgeInsets.symmetric(
              horizontal: Resources.horizontalDims.$16,
              vertical: Resources.verticalDims.$12,
            ),
            border: _border(Resources.colors.luxuryBorder),
            enabledBorder: _border(Resources.colors.luxuryBorder),
            focusedBorder: _border(Resources.colors.luxuryGoldLight),
          ),
          items: options
              .map((o) => DropdownMenuItem(value: o, child: Text(o)))
              .toList(),
          onChanged: onChanged,
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
