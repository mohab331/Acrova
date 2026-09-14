import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

class ProjectBottomCta extends StatelessWidget {
  const ProjectBottomCta({required this.project, super.key});

  final ProjectModel project;
  @override
  Widget build(BuildContext context) {
    final bool showCTA = {
      ProjectStatus.awaitingPayment,
      ProjectStatus.deliverablesReady,
      ProjectStatus.revisionInProgress,
      ProjectStatus.completed,
    }.contains(project.status);

    if (!showCTA) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsetsDirectional.only(
        top: Resources.verticalDims.$16,
        start: Resources.horizontalDims.$24,
        end: Resources.horizontalDims.$24,
        bottom: Resources.verticalDims.$32,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        boxShadow: [
          BoxShadow(
            color: Resources.colors.luxuryInk.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: _CTA(project: project),
    );
  }
}

class _CTA extends StatelessWidget {
  const _CTA({required this.project});
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    if (project.status == ProjectStatus.awaitingPayment) {
      return AppPrimaryButton(
        label: loc.projectDetailUploadReceipt,
        onPressed: () {
          context.push(
            AppRouteEnum.makePaymentPage.name,
            extra: MakePaymentArgs(projectId: project.id),
          );
        },
      );
    } else if (project.status == ProjectStatus.deliverablesReady) {
      return AppPrimaryButton(
        label: loc.projectDetailViewDeliverables,
        onPressed: () {
          context.push(AppRouteEnum.deliverablesPage.path);
        },
      );
    } else if (project.status == ProjectStatus.revisionInProgress) {
      return AppPrimaryButton(
        label: loc.projectDetailViewRevision,
        onPressed: () {
          context.push(
            AppRouteEnum.revisionDetailPage.name,
            extra: RevisionDetailArgs(revisionId: project.revisionID),
          );
        },
      );
    } else if (project.status == ProjectStatus.completed) {
      if (project.interiorDesignId != null &&
          project.interiorDesignId!.isNotEmpty) {
        return AppPrimaryButton(
          label: loc.viewInteriorDesign,
          onPressed: () {
            context.push(
              AppRouteEnum.interiorDesignDetailPage.name,
              extra: InteriorDesignDetailArgs(id: project.interiorDesignId),
            );
          },
        );
      }

      return AppPrimaryButton(
        label: loc.projectDetailPhaseIIInteriorDesign,
        onPressed: () {
          context.push(
            AppRouteEnum.interiorDesignPhaseOnePage.name,
            extra: InteriorDesignArgs(projectId: project.id),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
