import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/models/country.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Bottom sheet for selecting a calling-code country.
class CountryPickerSheet extends StatefulWidget {
  const CountryPickerSheet({
    required this.countries,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final List<Country> countries;
  final Country selected;
  final ValueChanged<Country> onSelect;

  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
  late List<Country> _filtered;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.countries;
    _search.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _search.text.toLowerCase();
    setState(() {
      _filtered = widget.countries.where((c) {
        return c.name.toLowerCase().contains(q) ||
            c.code.contains(q) ||
            c.iso2.toLowerCase().contains(q);
      }).toList();
    });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: Resources.colors.luxurySurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(Resources.radius.$r25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Padding(
              padding: EdgeInsets.only(top: Resources.verticalDims.$12),
              child: Container(
                width: Resources.horizontalDims.$40,
                height: Resources.verticalDims.$4,
                decoration: BoxDecoration(
                  color: Resources.colors.luxuryBorder,
                  borderRadius: BorderRadius.circular(Resources.radius.$r2),
                ),
              ),
            ),

            SizedBox(height: Resources.verticalDims.$16),

            // Title
            Text(
              context.localization.selectCountry,
              style: context.textTheme.titleMedium?.copyWith(
                color: Resources.colors.luxuryNavy,
              ),
            ),

            SizedBox(height: Resources.verticalDims.$16),

            // Search field
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Resources.horizontalDims.$24,
              ),
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: context.localization.searchCountry,
                  hintStyle: TextStyle(
                    color: Resources.colors.luxuryPlaceholder,
                    fontSize: Resources.fontSizes.$14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Resources.colors.luxuryBody,
                    size: Resources.iconSizes.$20,
                  ),
                  filled: true,
                  fillColor: Resources.colors.luxuryInputBg,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Resources.radius.$r8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$12),
                ),
              ),
            ),

            SizedBox(height: Resources.verticalDims.$8),

            // Country list
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: Resources.horizontalDims.$24,
                  vertical: Resources.verticalDims.$8,
                ),
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: Resources.colors.luxuryBorder,
                ),
                itemBuilder: (context, i) {
                  final country = _filtered[i];
                  final isSelected = country.iso2 == widget.selected.iso2;

                  return InkWell(
                    onTap: () {
                      widget.onSelect(country);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Resources.verticalDims.$14,
                      ),
                      child: Row(
                        children: [
                          Text(
                            country.flagEmoji,
                            style: TextStyle(fontSize: Resources.fontSizes.$20),
                          ),
                          SizedBox(width: Resources.horizontalDims.$12),
                          Expanded(
                            child: Text(
                              country.name,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Resources.colors.luxuryInk,
                              ),
                            ),
                          ),
                          Text(
                            country.code,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Resources.colors.luxuryBodyMuted,
                            ),
                          ),
                          SizedBox(width: Resources.horizontalDims.$8),
                          if (isSelected)
                            Icon(
                              Icons.check_rounded,
                              size: Resources.iconSizes.$18,
                              color: Resources.colors.luxuryGoldLight,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
