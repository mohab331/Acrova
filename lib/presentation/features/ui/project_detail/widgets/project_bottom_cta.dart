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

  Widget? _buildCta(BuildContext context) {
    final loc = context.localization;
    switch (project.status) {
      case ProjectStatus.awaitingPayment:
        return AppPrimaryButton(
          label: loc.projectDetailUploadReceipt,
          onPressed: () {},
        );
      case ProjectStatus.deliverablesReady:
        return AppPrimaryButton(
          label: loc.projectDetailViewDeliverables,
          onPressed: () {
            context.push(AppRouteEnum.deliverablesPage.path);
          },
        );
      case ProjectStatus.revisionInProgress:
        return AppPrimaryButton(
          label: loc.projectDetailViewRevision,
          onPressed: () {},
        );
      case ProjectStatus.completed:
        return AppPrimaryButton(
          label: loc.projectDetailPhaseIIInteriorDesign,
          onPressed: () {
            context.push(AppRouteEnum.interiorDesignPhaseOnePage.path);
          },
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cta = _buildCta(context);
    if (cta == null) return const SizedBox.shrink();
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
      child: cta,
    );
  }
}
