import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectTimeline extends StatelessWidget {
  const ProjectTimeline({
    required this.project,
    super.key,
  });

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final locale = Localizations.localeOf(context).languageCode;
    final submittedDate = DateFormat.yMMMd(locale).format(project.createdAt);
    final paymentDate = DateFormat.yMMMd(locale).format(project.createdAt.add(const Duration(days: 3)));

    final events = [
      _TimelineEvent(
        date: submittedDate,
        title: loc.projectDetailTimelineProjectSubmitted,
        description: loc.projectDetailTimelineProjectSubmittedDesc,
        isCompleted: true,
        isCurrent: false,
      ),
      _TimelineEvent(
        date: paymentDate,
        title: loc.projectDetailTimelinePaymentVerified,
        description: loc.projectDetailTimelinePaymentVerifiedDesc,
        isCompleted: true,
        isCurrent: false,
      ),
      _TimelineEvent(
        date: loc.projectDetailTimelineToday,
        title: loc.projectDetailTimelineEngineeringStarted,
        description: loc.projectDetailTimelineEngineeringStartedDesc,
        isCompleted: false,
        isCurrent: true,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.projectDetailActivityTimeline,
          style: context.textTheme.titleLarge?.copyWith(
            color: Resources.colors.luxuryNavy,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$24),
        ...List.generate(
          events.length,
          (index) => _TimelineItem(
            event: events[index],
            isLast: index == events.length - 1,
          ),
        ),
      ],
    );
  }
}

class _TimelineEvent {
  const _TimelineEvent({
    required this.date,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.isCurrent,
  });

  final String date;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isCurrent;
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.event,
    required this.isLast,
  });

  final _TimelineEvent event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline visual
          SizedBox(
            width: Resources.squareDims.$25,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Vertical Line
                if (!isLast)
                  Positioned(
                    top: Resources.squareDims.$25,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: Resources.colors.luxuryProgressTrack,
                    ),
                  ),
                // Dot
                Container(
                  width: Resources.squareDims.$25,
                  height: Resources.squareDims.$25,
                  decoration: BoxDecoration(
                    color: event.isCurrent
                        ? Resources.colors.luxuryGoldLight
                        : (event.isCompleted
                            ? Resources.colors.luxuryNavy
                            : Resources.colors.luxuryProgressTrack),
                    shape: BoxShape.circle,
                    border: event.isCurrent
                        ? Border.all(
                            color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.3),
                            width: 4,
                          )
                        : null,
                  ),
                  child: Center(
                    child: Icon(
                      event.isCurrent ? Icons.bolt : Icons.check,
                      color: Resources.colors.white,
                      size: Resources.iconSizes.$14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$16),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: Resources.verticalDims.$32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.date.toUpperCase(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Resources.colors.luxuryGoldLight,
                      fontWeight: Resources.fontWeights.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    event.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Resources.colors.luxuryNavy,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    event.description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Resources.colors.luxuryBodyMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
