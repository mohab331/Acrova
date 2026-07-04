import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/progress/app_icon_stepper.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectProgressCard extends StatelessWidget {
  const ProjectProgressCard({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    // Determine current step index based on status.
    // Acrova ProjectStatus has 8 stages.
    final int currentStep = ProjectStatus.values.indexOf(project.status);
    final int totalSteps = ProjectStatus.values.length;

    // Use icons for the stepper
    final icons = const [
      Icons.request_quote_outlined,
      Icons.payments_outlined,
      Icons.pending_actions_outlined,
      Icons.assignment_ind_outlined,
      Icons.engineering_outlined,
      Icons.check_circle_outline,
      Icons.draw_outlined,
      Icons.done_all,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
        border: Border.all(color: Resources.colors.luxuryGoldBorder),
        boxShadow: AppShadows.card,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$16,
        vertical: Resources.verticalDims.$16,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Progress',
                      style: context.textTheme.labelLarge?.copyWith(
                        fontSize: Resources.fontSizes.$18,
                        fontWeight: Resources.fontWeights.semiBold,
                        color: Resources.colors.luxuryNavy,
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$6),
                    Text(
                      'Real-time construction\nmilestones',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: Resources.fontSizes.$14,
                        color: Resources.colors.luxuryBody,
                        height: Resources.lineHeights.$1_2,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    project.progressLabel,
                    style: context.textTheme.displayMedium?.copyWith(
                      color: Resources.colors.luxuryGoldLight,
                      fontSize: Resources.fontSizes.$28,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    'COMPLETE',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Resources.colors.luxuryBodyMuted,
                      fontSize: Resources.fontSizes.$10,
                      fontWeight: Resources.fontWeights.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$32),

          // Pipeline Stepper
          AppIconStepper(
            totalSteps: totalSteps,
            currentStep: currentStep,
            icons: icons,
          ),

          SizedBox(height: Resources.verticalDims.$32),

          // Estimated Time Footer
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Resources.horizontalDims.$16,
              vertical: Resources.verticalDims.$12,
            ),
            decoration: BoxDecoration(
              color: Resources.colors.luxuryInputBg,
              borderRadius: BorderRadius.circular(Resources.radius.$r8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Resources.colors.luxuryGoldLight,
                  size: Resources.iconSizes.$20,
                ),
                SizedBox(width: Resources.horizontalDims.$8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Resources.colors.luxuryNavy,
                      ),
                      children: [
                        const TextSpan(text: 'Estimated: '),
                        TextSpan(
                          text:
                              '12 Days', // Mock data for now, not provided in ProjectModel
                          style: TextStyle(
                            fontWeight: Resources.fontWeights.bold,
                          ),
                        ),
                        const TextSpan(text: ' until next milestone.'),
                      ],
                    ),
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
