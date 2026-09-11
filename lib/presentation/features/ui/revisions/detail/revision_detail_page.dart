import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/cubit/revision_detail_cubit.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/cubit/revision_detail_state.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/widgets/revision_comparison.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/widgets/revision_detail_skeleton.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/widgets/revision_engineer_notes.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/widgets/revision_modifications.dart';
import 'package:acrova/presentation/features/ui/revisions/detail/widgets/revision_status_section.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevisionDetailPage extends StatelessWidget {
  const RevisionDetailPage({this.revision, this.revisionId, super.key})
    : assert(
        revision != null || revisionId != null,
        'Provide either revision or revisionId',
      );

  final RevisionModel? revision;
  final String? revisionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = RevisionDetailCubit(
          revisionsRepo: serviceLocatorInstance<BaseRevisionsRepo>(),
          initialRevision: revision,
        );
        if (revision == null && revisionId != null) {
          cubit.fetchRevision(revisionId!);
        }
        return cubit;
      },
      child: const _RevisionDetailView(),
    );
  }
}

class _RevisionDetailView extends StatelessWidget {
  const _RevisionDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevisionDetailCubit, RevisionDetailState>(
      builder: (context, state) {
        final title = state.revision != null
            ? context.localization.revisionDetailTitle(state.revision!.id)
            : context.localization.revisionDetailModifications;

        return CommonScreen(
          bottomPadding: 0,
          appBar: AppAuthBrandHeader(label: title, showBack: true),
          child: const RevisionDetailsContent(),
        );
      },
    );
  }
}

class RevisionDetailsContent extends StatelessWidget {
  const RevisionDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RevisionDetailCubit>().state;

    if (state.isLoading || state.cubitStatus == CubitStatus.initial) {
      return const RevisionDetailSkeleton();
    }
    if (state.isError || state.revision == null) {
      return AppErrorState(
        message:
            state.appErrorModel?.message ??
            context.localization.revisionDetailErrorBody,
        onRetry: () => context.read<RevisionDetailCubit>().refresh(),
      );
    }

    final r = state.revision!;
    return SingleChildScrollView(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevisionStatusSection(revision: r),
          SizedBox(height: Resources.verticalDims.$32),
          RevisionModifications(description: r.description),
          SizedBox(height: Resources.verticalDims.$32),
          const RevisionComparison(),
          if (r.engineerNote != null) ...[
            SizedBox(height: Resources.verticalDims.$32),
            RevisionEngineerNotes(revision: r),
          ],
          SizedBox(height: Resources.verticalDims.$32),
        ],
      ),
    );
  }
}
