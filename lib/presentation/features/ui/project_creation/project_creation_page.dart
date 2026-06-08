import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_secondary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/progress/app_progress_stepper.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/presentation/features/cubit/projects/projects_cubit.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step1_project_type.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step2_land_details.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step3_building_requirements.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step4_design_preferences.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step5_media_upload.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/step6_review_submit.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Full-screen project creation wizard (not inside the shell).
///
/// Provides its own [ProjectCreationCubit] via [BlocProvider].
class ProjectCreationPage extends StatelessWidget {
  const ProjectCreationPage({super.key});

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
    return BlocProvider(
      create: (_) => ProjectCreationCubit(
        projectRepo: serviceLocatorInstance<BaseProjectRepo>(),
      ),
      child: const _ProjectCreationView(),
    );
  }
}

class _ProjectCreationView extends StatelessWidget {
  const _ProjectCreationView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCreationCubit, ProjectCreationState>(
      listenWhen: (prev, curr) => prev.cubitStatus != curr.cubitStatus,
      listener: (context, state) {
        if (state.isSubmitSuccess && state.createdProject != null) {
          // Refresh both dashboard and projects after creating a new project
          serviceLocatorInstance<DashboardCubit>().fetchDashboardData();
          serviceLocatorInstance<ProjectsCubit>().fetchProjects();

          // Show success dialog — navigates to projects tab on dismiss
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) => _SuccessDialog(
              projectId: state.createdProject!.id,
              onDone: () {
                Navigator.of(context).pop();
                context.go(AppRouteEnum.projectsPage.path);
              },
            ),
          );
        }
        if (state.isSubmitError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.appErrorModel?.message ??
                    context.localization.projectCreationSubmitError,
              ),
              backgroundColor: Resources.colors.luxuryError,
            ),
          );
          context.read<ProjectCreationCubit>().resetError();
        }
      },
      builder: (context, state) {
        return CommonScreen(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: Resources.horizontalDims.$20,
                  end: Resources.horizontalDims.$20,
                  top: Resources.verticalDims.$16,
                ),
                child: _WizardAppBar(state: state),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: Resources.horizontalDims.$20,
                    end: Resources.horizontalDims.$20,
                  ),
                  child: _StepBody(currentStep: state.currentStep),
                ),
              ),
              _WizardBottomBar(state: state),
            ],
          ),
        );
      },
    );
  }
}

// ─── App Bar ─────────────────────────────────────────────────────────────────

class _WizardAppBar extends StatelessWidget {
  const _WizardAppBar({required this.state});

  final ProjectCreationState state;

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
                dimension: 40.r,
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
                      ProjectCreationPage.stepTitles(
                        context,
                      )[state.currentStep],
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Resources.colors.luxuryNavy,
                        fontWeight: Resources.fontWeights.semiBold,
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer to balance back button
              SizedBox(width: 36.r),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$20),
          AppProgressStepper(
            totalSteps: kWizardStepCount,
            currentStep: state.currentStep,
          ),
        ],
      ),
    );
  }
}

// ─── Step Body ───────────────────────────────────────────────────────────────

class _StepBody extends StatelessWidget {
  const _StepBody({required this.currentStep});

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

// ─── Bottom Bar ───────────────────────────────────────────────────────────────

class _WizardBottomBar extends StatelessWidget {
  const _WizardBottomBar({required this.state});

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

// ─── Success Dialog ───────────────────────────────────────────────────────────

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({required this.projectId, required this.onDone});

  final String projectId;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Resources.radius.$r16),
      ),
      child: Padding(
        padding: EdgeInsets.all(Resources.horizontalDims.$24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: Resources.verticalDims.$8),
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                color: Resources.colors.luxurySuccess.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 36.sp,
                color: Resources.colors.luxurySuccess,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$20),
            Text(
              context.localization.projectCreationSuccessTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Resources.colors.luxuryNavy,
                fontWeight: Resources.fontWeights.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Resources.verticalDims.$8),
            Text(
              context.localization.projectCreationSuccessSubtitle(projectId),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Resources.colors.luxuryBody,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Resources.verticalDims.$28),
            AppPrimaryButton(
              label: context.localization.projectCreationSuccessCta,
              onPressed: onDone,
            ),
            SizedBox(height: Resources.verticalDims.$8),
          ],
        ),
      ),
    );
  }
}
