import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_shimmer_loading.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_cubit.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_state.dart';
import 'package:acrova/presentation/features/ui/interior_design/widgets/interior_design_form.dart';
import 'package:acrova/presentation/features/ui/interior_design/widgets/interior_design_header.dart';
import 'package:acrova/presentation/features/ui/project_detail/cubit/project_detail_cubit.dart';
import 'package:acrova/presentation/features/ui/project_detail/cubit/project_detail_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InteriorDesignView extends StatelessWidget {
  const InteriorDesignView({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return BlocProvider(
      create: (_) =>
          serviceLocatorInstance<ProjectDetailCubit>()..fetchProject(projectId),
      child: BlocConsumer<InteriorDesignCubit, InteriorDesignState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.isSuccess) {
            context.go(AppRouteEnum.projectsPage.path);
          } else if (state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error?.message ?? 'An error occurred'),
                backgroundColor: Resources.colors.luxuryError,
              ),
            );
          }
        },
        builder: (context, state) {
          return CommonScreen(
            appBar: AppAuthBrandHeader(
              label: loc.projectDetailPhaseIIInteriorDesign,
              showBack: true,
            ),
            padding: EdgeInsets.zero,
            child: BlocBuilder<ProjectDetailCubit, ProjectDetailState>(
              builder: (context, projectState) {
                if (projectState.isLoading || projectState.project == null) {
                  return const CommonShimmerLoading(isDetail: true);
                }
                if (projectState.isError) {
                  return CommonErrorWidget(
                    error: projectState.appErrorModel,
                    onRetry: () => context
                        .read<ProjectDetailCubit>()
                        .fetchProject(projectId),
                  );
                }

                final project = projectState.project!;

                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: Resources.horizontalDims.$20,
                        right: Resources.horizontalDims.$20,
                        top: Resources.verticalDims.$16,
                        bottom: Resources.verticalDims.$100,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InteriorDesignHeader(project: project),
                          SizedBox(height: Resources.verticalDims.$24),
                          const InteriorDesignForm(),
                          SizedBox(height: Resources.verticalDims.$32),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Resources.verticalDims.$16,
                          left: Resources.horizontalDims.$24,
                          right: Resources.horizontalDims.$24,
                          bottom: Resources.verticalDims.$32,
                        ),
                        decoration: BoxDecoration(
                          color: Resources.colors.luxurySurface,
                          boxShadow: [
                            BoxShadow(
                              color: Resources.colors.luxuryInk.withValues(
                                alpha: 0.05,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: AppPrimaryButton(
                          label: loc.interiorDesignSubmit,
                          isLoading: state.isLoading,
                          enabled: state.isValid,
                          onPressed: () {
                            context.read<InteriorDesignCubit>().submit();
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
