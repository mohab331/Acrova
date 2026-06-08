import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Step2LandDetails extends StatefulWidget {
  const Step2LandDetails({super.key});

  @override
  State<Step2LandDetails> createState() => _Step2LandDetailsState();
}

class _Step2LandDetailsState extends State<Step2LandDetails> {
  late final TextEditingController _locationCtrl;
  late final TextEditingController _areaCtrl;
  late final TextEditingController _widthCtrl;
  late final TextEditingController _lengthCtrl;

  @override
  void initState() {
    super.initState();
    final s = context.read<ProjectCreationCubit>().state;
    _locationCtrl = TextEditingController(text: s.location);
    _areaCtrl = TextEditingController(
      text: s.landAreaSqm != null ? s.landAreaSqm!.toStringAsFixed(0) : '',
    );
    _widthCtrl = TextEditingController(
      text: s.landWidthM != null ? s.landWidthM!.toStringAsFixed(0) : '',
    );
    _lengthCtrl = TextEditingController(
      text: s.landLengthM != null ? s.landLengthM!.toStringAsFixed(0) : '',
    );
  }

  @override
  void dispose() {
    _locationCtrl.dispose();
    _areaCtrl.dispose();
    _widthCtrl.dispose();
    _lengthCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCreationCubit, ProjectCreationState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCreationCubit>();
        final l10n = context.localization;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.landDetailsTitle,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.semiBold,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$12),
              Text(
                l10n.landDetailsSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Resources.colors.luxuryBody,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$32),
          
              // Location
              _WizardTextField(
                controller: _locationCtrl,
                label: l10n.landDetailsLabelLocation,
                hint: l10n.landDetailsHintLocation,
                onChanged: cubit.updateLocation,
              ),
              SizedBox(height: Resources.verticalDims.$20),
          
              // Land area
              _WizardTextField(
                controller: _areaCtrl,
                label: l10n.landDetailsLabelArea,
                hint: l10n.landDetailsHintArea,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                onChanged: (v) => cubit.updateLandArea(double.tryParse(v)),
              ),
              SizedBox(height: Resources.verticalDims.$20),
          
              // Width + Length row
              Row(
                children: [
                  Expanded(
                    child: _WizardTextField(
                      controller: _widthCtrl,
                      label: l10n.landDetailsLabelWidth,
                      hint: l10n.landDetailsHintWidth,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                      onChanged: (v) => cubit.updateLandWidth(double.tryParse(v)),
                    ),
                  ),
                  SizedBox(width: Resources.horizontalDims.$12),
                  Expanded(
                    child: _WizardTextField(
                      controller: _lengthCtrl,
                      label: l10n.landDetailsLabelLength,
                      hint: l10n.landDetailsHintLength,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                      onChanged: (v) => cubit.updateLandLength(double.tryParse(v)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$20),
          
              // Number of floors
              _FloorCounter(
                floors: state.floors,
                onDecrement: () => cubit.updateFloors(state.floors - 1),
                onIncrement: () => cubit.updateFloors(state.floors + 1),
              ),
              SizedBox(height: Resources.verticalDims.$24),
          
              // SBC warnings
              if (state.hasSbcWarnings) _SbcWarningCard(state: state),
          
              SizedBox(height: Resources.verticalDims.$16),
            ],
          ),
        );
      },
    );
  }
}

// ─── Wizard Text Field ───────────────────────────────────────────────────────

class _WizardTextField extends StatelessWidget {
  const _WizardTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.onChanged,
    this.keyboardType,
    this.inputFormatters,
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
                  width: 1.5,
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

// ─── Floor Counter ────────────────────────────────────────────────────────────

class _FloorCounter extends StatelessWidget {
  const _FloorCounter({
    required this.floors,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int floors;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.landDetailsLabelFloors.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Resources.colors.luxuryBody,
              ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$16,
            vertical: Resources.verticalDims.$12,
          ),
          decoration: BoxDecoration(
            color: Resources.colors.luxuryInputBg,
            borderRadius: BorderRadius.circular(Resources.radius.$r2),
            border: Border.all(color: Resources.colors.luxuryInputBorder),
          ),
          child: Row(
            children: [
              _CounterBtn(
                icon: Icons.remove,
                onTap: floors > 1 ? onDecrement : null,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$floors ${floors == 1 ? l10n.landDetailsFloorSingular : l10n.landDetailsFloorPlural}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Resources.colors.luxuryInk,
                          fontWeight: Resources.fontWeights.semiBold,
                        ),
                  ),
                ),
              ),
              _CounterBtn(
                icon: Icons.add,
                onTap: floors < 10 ? onIncrement : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CounterBtn extends StatelessWidget {
  const _CounterBtn({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: isEnabled
              ? Resources.colors.luxuryNavy
              : Resources.colors.luxuryProgressTrack,
          borderRadius: BorderRadius.circular(Resources.radius.$r2),
        ),
        child: Icon(
          icon,
          size: Resources.iconSizes.$18,
          color: isEnabled
              ? Resources.colors.luxurySurface
              : Resources.colors.luxuryBodyMuted,
        ),
      ),
    );
  }
}

// ─── SBC Warning Card ─────────────────────────────────────────────────────────

class _SbcWarningCard extends StatelessWidget {
  const _SbcWarningCard({required this.state});

  final ProjectCreationState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$16),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryWarning.withOpacity(0.08),
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(
          color: Resources.colors.luxuryWarning.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: Resources.iconSizes.$18,
                color: Resources.colors.luxuryWarning,
              ),
              SizedBox(width: Resources.horizontalDims.$8),
              Text(
                l10n.landDetailsSbcTitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: Resources.fontWeights.bold,
                      color: Resources.colors.luxuryWarning,
                    ),
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$8),
          if (state.sbcAreaWarning)
            _WarningRow(
              l10n.landDetailsSbcAreaWarning,
            ),
          if (state.sbcFloorWarning)
            _WarningRow(
              l10n.landDetailsSbcFloorWarning,
            ),
          if (state.sbcWidthAdvisory)
            _WarningRow(
              l10n.landDetailsSbcWidthAdvisory,
            ),
          SizedBox(height: Resources.verticalDims.$4),
          Text(
            l10n.landDetailsSbcFooter,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Resources.colors.luxuryWarning.withOpacity(0.8),
                  fontSize: Resources.fontSizes.$10,
                ),
          ),
        ],
      ),
    );
  }
}

class _WarningRow extends StatelessWidget {
  const _WarningRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Resources.verticalDims.$4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: Resources.fontSizes.$12,
              color: Resources.colors.luxuryWarning,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Resources.colors.luxuryWarning,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
