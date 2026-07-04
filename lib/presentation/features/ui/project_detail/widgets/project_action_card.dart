import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_secondary_button.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectActionCard extends StatelessWidget {
  const ProjectActionCard({
    required this.project,
    super.key,
  });

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    // Determine action text based on status.
    // In a real app, this would be computed from the project data or a localized map.
    final String title;
    final String description;
    final IconData icon;
    Widget? ctaWidget;

    switch (project.status) {
      case ProjectStatus.awaitingPricing:
      case ProjectStatus.awaitingEngineeringAssignment:
        title = 'Application Under Review';
        description = 'Our administrative team is verifying your site documents and municipal permit application.';
        icon = Icons.description_outlined;
        break;
      case ProjectStatus.paymentUnderReview:
        title = 'Payment Under Review';
        description = 'Our financial team is verifying your payment documents.';
        icon = Icons.payments_outlined;
        ctaWidget = AppPrimaryButton(label: 'VIEW DELIVERABLES',onPressed: () {
          context.push(AppRouteEnum.deliverablesPage.path);
        }, );
        break;
      case ProjectStatus.awaitingPayment:
        title = 'Payment Required';
        description = 'Please upload your bank transfer receipt to proceed with the next phase.';
        icon = Icons.payments_outlined;
        ctaWidget = AppPrimaryButton(label: 'UPLOAD RECEIPT', onPressed: () {});
        break;
      case ProjectStatus.deliverablesReady:
        title = 'Deliverables Ready';
        description = 'Your project deliverables are ready for review and download.';
        icon = Icons.check_circle_outline;
        ctaWidget = AppPrimaryButton(label: 'VIEW DELIVERABLES', onPressed: () {
          context.push(AppRouteEnum.deliverablesPage.path);
        });
        break;
      case ProjectStatus.revisionInProgress:
        title = 'Revision In Progress';
        description = 'Our team is actively working on your requested revisions.';
        icon = Icons.draw_outlined;
        ctaWidget = AppPrimaryButton(label: 'VIEW REVISION', onPressed: () {});
        break;
      case ProjectStatus.completed:
        title = 'Project Completed';
        description = 'This project has been successfully completed and delivered.';
        icon = Icons.done_all;
        ctaWidget = AppPrimaryButton(label: 'START NEW PROJECT', onPressed: () {});
        break;
      default:
        title = 'Engineering Review';
        description = 'Our lead engineer is currently finalizing your structural schematics. No action is required from you at this moment.';
        icon = Icons.architecture_outlined;
    }

    return Container(
      padding: EdgeInsets.all(Resources.squareDims.$25),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.05),
        border: Border.all(
          color: Resources.colors.luxuryGoldBorder,
        ),
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Resources.squareDims.$56,
            height: Resources.squareDims.$56,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryGoldLight,
              borderRadius: BorderRadius.circular(Resources.radius.$r8),
              boxShadow: [
                BoxShadow(
                  color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Resources.colors.white,
              size: Resources.iconSizes.$24,
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$4),
                Text(
                  description,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Resources.colors.luxuryBodyMuted,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
