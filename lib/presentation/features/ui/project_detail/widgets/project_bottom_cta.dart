import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectBottomCta extends StatelessWidget {
  const ProjectBottomCta({required this.project, super.key});

  final ProjectModel project;
  @override
  Widget build(BuildContext context) {
    final bool hideCTA =
        (project.status != ProjectStatus.awaitingPayment ||
        project.status != ProjectStatus.deliverablesReady ||
        project.status == ProjectStatus.revisionInProgress ||
        project.status == ProjectStatus.completed);
    if (hideCTA) {
      return const SizedBox.shrink();
    }
    return Container(
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
  const _CTA({required this.project, super.key});
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    if (project.status == ProjectStatus.awaitingPayment) {
      return AppPrimaryButton(
        label: loc.projectDetailUploadReceipt,
        onPressed: () {
          context.pushNamed(AppRouteEnum.makePaymentPage.name);
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
        onPressed: () {},
      );
    } else if (project.status == ProjectStatus.completed) {
      return AppPrimaryButton(
        label: loc.projectDetailPhaseIIInteriorDesign,
        onPressed: () {
          context.push(AppRouteEnum.interiorDesignPhaseOnePage.path);
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
