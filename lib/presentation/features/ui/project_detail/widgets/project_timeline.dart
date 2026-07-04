import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectTimeline extends StatelessWidget {
  const ProjectTimeline({
    required this.project,
    super.key,
  });

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    // Mock data based on HTML for now
    final events = const [
      _TimelineEvent(
        date: 'Oct 12, 2025',
        title: 'Project Submitted',
        description: 'Initial design concepts and site survey documents uploaded.',
        isCompleted: true,
        isCurrent: false,
      ),
      _TimelineEvent(
        date: 'Oct 15, 2025',
        title: 'Payment Verified',
        description: 'Phase 1 architectural retainer successfully processed.',
        isCompleted: true,
        isCurrent: false,
      ),
      _TimelineEvent(
        date: 'Today',
        title: 'Engineering Started',
        description: 'Structural analysis and MEP planning now in progress.',
        isCompleted: false,
        isCurrent: true,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activity Timeline',
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
