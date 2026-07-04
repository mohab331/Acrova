import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_back_button.dart';
import 'package:acrova/presentation/features/common_widgets/progress/app_icon_stepper.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WizardAppBar extends StatelessWidget {
  const WizardAppBar({required this.state, super.key});

  final ProjectCreationState state;

  static List<String> stepTitles(BuildContext context) {
    final l10n = context.localization;
    return [
      l10n.stepProjectType,
      l10n.stepLandDetails,
      l10n.stepRequirements,
      l10n.stepDesign,
      l10n.stepMedia,
      l10n.stepReview,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Resources.colors.luxuryBackground,
      padding: EdgeInsets.only(bottom: Resources.verticalDims.$20),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox.square(
                dimension: Resources.squareDims.$40,
                child: CustomBackButton(
                  onBack: () {
                    if (state.currentStep > 0) {
                      context.read<ProjectCreationCubit>().prevStep();
                    } else {
                      context.pop();
                    }
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      context.localization.projectCreationStepOfTotal(
                        (state.currentStep + 1).toString(),
                        kWizardStepCount.toString(),
                      ),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Resources.colors.luxuryGoldLight,
                          ),
                    ),
                    SizedBox(height: Resources.verticalDims.$2),
                    Text(
                      stepTitles(context)[state.currentStep],
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Resources.colors.luxuryNavy,
                            fontWeight: Resources.fontWeights.semiBold,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: Resources.squareDims.$36),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$20),
          AppIconStepper(
            totalSteps: kWizardStepCount,
            currentStep: state.currentStep,
            labels: stepTitles(context),
          ),
        ],
      ),
    );
  }
}
