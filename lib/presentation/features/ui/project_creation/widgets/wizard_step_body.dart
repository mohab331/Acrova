import 'package:acrova/presentation/features/ui/project_creation/steps/step1_project_type.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step2_land_details.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step3_building_requirements.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step4_design_preferences.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step5_media_upload.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step6_review_submit.dart';
import 'package:flutter/material.dart';

class WizardStepBody extends StatelessWidget {
  const WizardStepBody({required this.currentStep, super.key});

  final int currentStep;

  static const _steps = [
    Step1ProjectType(),
    Step2LandDetails(),
    Step3BuildingRequirements(),
    Step4DesignPreferences(),
    Step5MediaUpload(),
    Step6ReviewSubmit(),
  ];

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(currentStep),
      child: _steps[currentStep],
    );
  }
}
