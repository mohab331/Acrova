import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectActionCard extends StatelessWidget {
  const ProjectActionCard({
    required this.project,
    super.key,
  });

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final String title;
    final String description;
    final IconData icon;

    switch (project.status) {
      case ProjectStatus.awaitingPricing:
      case ProjectStatus.awaitingEngineeringAssignment:
        title = loc.projectActionReviewTitle;
        description = loc.projectActionReviewDesc;
        icon = Icons.description_outlined;
        break;
      case ProjectStatus.paymentUnderReview:
        title = loc.projectActionPaymentReviewTitle;
        description = loc.projectActionPaymentReviewDesc;
        icon = Icons.payments_outlined;
        break;
      case ProjectStatus.awaitingPayment:
        title = loc.projectActionPaymentRequiredTitle;
        description = loc.projectActionPaymentRequiredDesc;
        icon = Icons.payments_outlined;
        break;
      case ProjectStatus.deliverablesReady:
        title = loc.projectActionDeliverablesTitle;
        description = loc.projectActionDeliverablesDesc;
        icon = Icons.check_circle_outline;
        break;
      case ProjectStatus.revisionInProgress:
        title = loc.projectActionRevisionTitle;
        description = loc.projectActionRevisionDesc;
        icon = Icons.draw_outlined;
        break;
      case ProjectStatus.completed:
        title = loc.projectActionCompletedTitle;
        description = loc.projectActionCompletedDesc;
        icon = Icons.done_all;
        break;
      default:
        title = loc.projectActionEngineeringTitle;
        description = loc.projectActionEngineeringDesc;
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
