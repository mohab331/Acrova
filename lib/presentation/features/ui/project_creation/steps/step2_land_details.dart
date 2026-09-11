import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/floor_counter.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/sbc_warning_card.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/wizard_text_field.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late final TextEditingController _employeeCtrl;

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
    _employeeCtrl = TextEditingController(
      text: s.employeeCount > 0 ? s.employeeCount.toString() : '',
    );
  }

  @override
  void dispose() {
    _locationCtrl.dispose();
    _areaCtrl.dispose();
    _widthCtrl.dispose();
    _lengthCtrl.dispose();
    _employeeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCreationCubit, ProjectCreationState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCreationCubit>();
        final l10n = context.localization;

        final isCommercial = state.selectedType == ProjectType.commercial;

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
              WizardTextField(
                controller: _locationCtrl,
                label: l10n.landDetailsLabelLocation,
                hint: l10n.landDetailsHintLocation,
                onChanged: cubit.updateLocation,
              ),
              SizedBox(height: Resources.verticalDims.$20),
              WizardTextField(
                controller: _areaCtrl,
                label: l10n.landDetailsLabelArea,
                hint: l10n.landDetailsHintArea,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                onChanged: (v) => cubit.updateLandArea(double.tryParse(v)),
              ),
              SizedBox(height: Resources.verticalDims.$20),
              if (isCommercial) ...[
                WizardTextField(
                  controller: _employeeCtrl,
                  label: l10n.landDetailsLabelEmployeeCount,
                  hint: l10n.landDetailsHintEmployeeCount,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (v) => cubit.updateEmployeeCount(int.tryParse(v) ?? 0),
                ),
                SizedBox(height: Resources.verticalDims.$20),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: WizardTextField(
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
                      child: WizardTextField(
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
              ],
              FloorCounter(
                floors: state.floors,
                onDecrement: () => cubit.updateFloors(state.floors - 1),
                onIncrement: () => cubit.updateFloors(state.floors + 1),
              ),
              SizedBox(height: Resources.verticalDims.$24),
              if (state.hasSbcWarnings) SbcWarningCard(state: state),
              SizedBox(height: Resources.verticalDims.$16),
            ],
          ),
        );
      },
    );
  }
}
