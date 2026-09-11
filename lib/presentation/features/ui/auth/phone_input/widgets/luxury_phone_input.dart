import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/models/country.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/phone_input_cubit.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'country_picker_sheet.dart';

class LuxuryPhoneInput extends StatefulWidget {
  const LuxuryPhoneInput({super.key});

  @override
  State<LuxuryPhoneInput> createState() => _LuxuryPhoneInputState();
}

class _LuxuryPhoneInputState extends State<LuxuryPhoneInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneInputCubit, PhoneInputState>(
      builder: (context, state) {
        final cubit = context.read<PhoneInputCubit>();
        final hasError = state.error != null;

        if (_controller.text != state.phone) {
          _controller.value = TextEditingValue(
            text: state.phone,
            selection:
                TextSelection.collapsed(offset: state.phone.length),
          );
        }

        final borderColor = hasError
            ? Resources.colors.luxuryError
            : Resources.colors.luxuryGoldLight;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => _openCountryPicker(context, cubit),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: Resources.horizontalDims.$12,
                      bottom: Resources.verticalDims.$8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${state.country.flagEmoji} ${state.country.code}',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Resources.colors.luxuryInk,
                            fontWeight: Resources.fontWeights.semiBold,
                          ),
                        ),
                        SizedBox(width: Resources.horizontalDims.$4),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: Resources.iconSizes.$16,
                          color: Resources.colors.luxuryBody,
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[\d\s]')),
                    ],
                    onChanged: cubit.onPhoneChanged,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Resources.colors.luxuryInk,
                      fontWeight: Resources.fontWeights.semiBold,
                      fontSize: Resources.fontSizes.$15,
                    ),
                    decoration: InputDecoration(
                      hintText: context.localization.phoneInputHint,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        bottom: Resources.verticalDims.$8,
                      ),
                      hintStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Resources.colors.luxuryPlaceholder,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(height: Resources.verticalDims.$1_5, color: borderColor),

            if (hasError) ...[
              SizedBox(height: Resources.verticalDims.$6),
              Text(
                state.error!,
                style: context.textTheme.labelSmall?.copyWith(
                  color: Resources.colors.luxuryError,
                  letterSpacing: Resources.letterSpacing.$0,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  void _openCountryPicker(BuildContext context, PhoneInputCubit cubit) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: CountryPickerSheet(
          countries: kSupportedCountries,
          selected: cubit.state.country,
          onSelect: (c) => cubit.onCountryChanged(c),
        ),
      ),
    );
  }
}
