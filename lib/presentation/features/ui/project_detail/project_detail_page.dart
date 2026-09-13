import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_shimmer_loading.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/ui/project_detail/cubit/project_detail_cubit.dart';
import 'package:acrova/presentation/features/ui/project_detail/cubit/project_detail_state.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_bottom_cta.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_content_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({
    required this.projectId,
    required this.projectTitle,
    super.key,
  });

  final String projectId;
  final String? projectTitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<ProjectDetailCubit>()..fetchProject(projectId),
      child: CommonScreen(
        padding: EdgeInsets.zero,
        appBar: AppAuthBrandHeader(label: projectTitle ?? '', showBack: true),
        backGroundColor: Resources.colors.white,
        child: const _ProjectDetailView(),
      ),
    );
  }
}

class _ProjectDetailView extends StatelessWidget {
  const _ProjectDetailView();

  @override
  Widget build(BuildContext context) {
    final heroHeight = MediaQuery.of(context).size.height * 0.4;
    var projectDetailCubit = context.read<ProjectDetailCubit>();
    return BlocBuilder<ProjectDetailCubit, ProjectDetailState>(
      builder: (context, state) {
        if (state.isLoading || (state.project == null && !state.isError)) {
          return const CommonShimmerLoading(isDetail: true);
        }
        if (state.isError) {
          return CommonErrorWidget(
            error: state.appErrorModel,
            onRetry: () => projectDetailCubit.fetchProject(),
          );
        }

        final project = state.project!;
        return RefreshIndicator(
          onRefresh: () {
            return projectDetailCubit.fetchProject();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: heroHeight,
                        child: AppCachedNetworkImage(
                          imageUrl: project.thumbnailUrl ?? '',
                          width: double.infinity,
                          radius: 0,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -Resources.verticalDims.$24),
                        child: ProjectContentSheet(project: project),
                      ),
                    ],
                  ),
                ),
              ),
              ProjectBottomCta(project: project),
            ],
          ),
        );
      },
    );
  }
}
