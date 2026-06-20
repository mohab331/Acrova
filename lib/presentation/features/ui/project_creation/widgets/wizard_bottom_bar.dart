import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WizardBottomBar extends StatelessWidget {
  const WizardBottomBar({required this.state, super.key});

  final ProjectCreationState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProjectCreationCubit>();
    final isLastStep = state.currentStep == kWizardStepCount - 1;
    final canProceed = state.currentStepValid;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$16,
        vertical: Resources.verticalDims.$24,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        border: Border(top: BorderSide(color: Resources.colors.luxuryBorder)),
        boxShadow: AppShadows.float,
      ),
      child: Row(
        children: [
          Expanded(
            child: isLastStep
                ? AppPrimaryButton(
                    label: context.localization.projectCreationSubmit,
                    onPressed: canProceed && !state.isSubmitting
                        ? cubit.submit
                        : null,
                    isLoading: state.isSubmitting,
                  )
                : AppPrimaryButton(
                    label: state.currentStep == 4
                        ? context.localization.projectCreationContinue
                        : context.localization.projectCreationNextStep,
                    onPressed: canProceed ? cubit.nextStep : null,
                  ),
          ),
        ],
      ),
    );
  }
}
