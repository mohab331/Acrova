import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/enums/project_status_enum.dart';

class ProjectBottomCta extends StatelessWidget {
  const ProjectBottomCta({
    required this.project,
    super.key,
  });

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final cta = getCTA(context);
    if(cta == null) return const SizedBox.shrink();
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
      child: getCTA(context),
    );
  }

  Widget? getCTA(BuildContext context){
    switch (project.status) {
      case ProjectStatus.awaitingPayment:
        return AppPrimaryButton(label: 'UPLOAD RECEIPT', onPressed: () {});
      case ProjectStatus.deliverablesReady:

        return  AppPrimaryButton(label: 'VIEW DELIVERABLES', onPressed: () {
          context.push(AppRouteEnum.deliverablesPage.path);
        });
      case ProjectStatus.revisionInProgress:
        return AppPrimaryButton(label: 'VIEW REVISION', onPressed: () {});
      case ProjectStatus.completed:
        return AppPrimaryButton(label: 'Phase II: Interior Design', onPressed: () {
          context.push(AppRouteEnum.interiorDesignPhaseOnePage.path);
        });
      default:
        return null;
    }
  }
}
