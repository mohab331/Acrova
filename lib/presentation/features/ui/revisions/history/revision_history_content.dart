import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_empty_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/ui/revisions/cubit/revisions/revisions_cubit.dart';
import 'package:acrova/presentation/features/ui/revisions/widgets/revision_card.dart';
import 'package:acrova/presentation/features/ui/revisions/widgets/revision_history_skeleton.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevisionHistoryContent extends StatelessWidget {
  const RevisionHistoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RevisionsCubit>();
    final state = context.watch<RevisionsCubit>().state;

    final l10n = context.localization;

    if (state.isLoading || state.cubitStatus == CubitStatus.initial) {
      return const RevisionHistorySkeleton();
    }
    if (state.isError) {
      return AppErrorState(
        title: l10n.revisionHistoryErrorTitle,
        message: l10n.revisionHistoryErrorBody,
        onRetry: cubit.fetchRevisions,
      );
    }
    if (state.isEmpty) {
      return AppEmptyState(
        icon: Icons.history_edu_outlined,
        title: l10n.revisionHistoryEmptyTitle,
        subtitle: l10n.revisionHistoryEmptySubtitle,
        ctaLabel: l10n.revisionHistoryNewRequest,
        onCtaTap:()=> _openRequest(context),
      );
    }

    return RefreshIndicator(
      color: Resources.colors.luxuryGoldLight,
      onRefresh: cubit.fetchRevisions,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.revisions?.length ?? 0,
        itemBuilder: (_, i) {
          final entry = state.revisions?[i];
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RevisionCard(revision: entry, onTap: () => _openDetail(context, revision: entry)),
              SizedBox(height: Resources.verticalDims.$16),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openRequest(BuildContext context) async {
    final created = await context.push<RevisionModel>(
      AppRouteEnum.revisionRequestPage.name,
    );
    if (created != null) context.read<RevisionsCubit>().fetchRevisions();
  }

  void _openDetail(BuildContext context, {required RevisionModel? revision}) {
    context.push(AppRouteEnum.revisionDetailPage.name, extra: revision);
  }
}

