import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class LuxuryIconTextField extends StatefulWidget {
  const LuxuryIconTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.focusNode,
    this.nextFocus,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.error,
    this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final String? error;
  final ValueChanged<String>? onChanged;

  @override
  State<LuxuryIconTextField> createState() => _LuxuryIconTextFieldState();
}

class _LuxuryIconTextFieldState extends State<LuxuryIconTextField> {
  late final FocusNode _effectiveFocus;

  @override
  void initState() {
    super.initState();
    _effectiveFocus = widget.focusNode ?? FocusNode();
    _effectiveFocus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _effectiveFocus.removeListener(_onFocusChange);
    if (widget.focusNode == null) _effectiveFocus.dispose();
    super.dispose();
  }

  UnderlineInputBorder _border(Color color) => UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Resources.radius.$r2),
          topRight: Radius.circular(Resources.radius.$r2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          focusNode: _effectiveFocus,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.nextFocus != null
              ? TextInputAction.next
              : TextInputAction.done,
          onChanged: widget.onChanged,
          onSubmitted: (_) => widget.nextFocus?.requestFocus(),
          style: TextStyle(
            fontFamily: Resources.fonts.manrope,
            fontSize: Resources.fontSizes.$16,
            color: Resources.colors.luxuryInk,
            fontWeight: Resources.fontWeights.regular,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Resources.colors.luxuryPlaceholder),
            filled: true,
            fillColor: hasError
                ? Resources.colors.luxuryError.withValues(alpha: 0.04)
                : Resources.colors.luxuryProgressTrack,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Resources.horizontalDims.$12,
              ),
              child: Icon(
                widget.icon,
                size: Resources.iconSizes.$18,
                color: hasError
                    ? Resources.colors.luxuryError
                    : Resources.colors.luxuryBody,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(),
            contentPadding: EdgeInsets.symmetric(
              vertical: Resources.verticalDims.$14,
              horizontal: Resources.horizontalDims.$4,
            ),
            enabledBorder: _border(
              hasError ? Resources.colors.luxuryError : Colors.transparent,
            ),
            focusedBorder: _border(
              hasError
                  ? Resources.colors.luxuryError
                  : Resources.colors.luxuryGoldLight,
            ),
            disabledBorder: _border(Colors.transparent),
            errorBorder: _border(Resources.colors.luxuryError),
            focusedErrorBorder: _border(Resources.colors.luxuryError),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: Resources.verticalDims.$4),
          Text(
            widget.error!,
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$12,
              color: Resources.colors.luxuryError,
            ),
          ),
        ],
      ],
    );
  }
}
