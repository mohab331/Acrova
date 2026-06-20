import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/presentation/features/cubit/projects/projects_cubit.dart';
import 'package:acrova/presentation/features/ui/project_creation/widgets/project_success_dialog.dart';
import 'package:acrova/presentation/features/ui/project_creation/widgets/wizard_app_bar.dart';
import 'package:acrova/presentation/features/ui/project_creation/widgets/wizard_bottom_bar.dart';
import 'package:acrova/presentation/features/ui/project_creation/widgets/wizard_step_body.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProjectCreationView extends StatelessWidget {
  const ProjectCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCreationCubit, ProjectCreationState>(
      listenWhen: (prev, curr) => prev.cubitStatus != curr.cubitStatus,
      listener: _handleListener,
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
                child: WizardAppBar(state: state),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: Resources.horizontalDims.$20,
                    end: Resources.horizontalDims.$20,
                  ),
                  child: WizardStepBody(currentStep: state.currentStep),
                ),
              ),
              WizardBottomBar(state: state),
            ],
          ),
        );
      },
    );
  }

  void _handleListener(BuildContext context, ProjectCreationState state) {
    if (state.isSubmitSuccess && state.createdProject != null) {
      serviceLocatorInstance<DashboardCubit>().fetchDashboardData();
      serviceLocatorInstance<ProjectsCubit>().fetchProjects();
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => ProjectSuccessDialog(
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
  }
}
