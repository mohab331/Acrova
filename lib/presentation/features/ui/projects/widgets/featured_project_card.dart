import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/widgets/interior_design_card.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/active_phase_badge.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/project_card_info.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:flutter/material.dart';

class FeaturedProjectCard extends StatelessWidget {
  const FeaturedProjectCard({required this.project, super.key});

  final ProjectModel project;

  bool get _showActiveBadge => !(project.status?.isTerminal ?? false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
        boxShadow: AppShadows.featuredCard,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CardThumbnail(thumbnailUrl: project.thumbnailUrl),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: Resources.verticalDims.$80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Resources.colors.luxuryInk.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),
              ),
              if (_showActiveBadge)
                Positioned(
                  top: Resources.verticalDims.$12,
                  right: Resources.horizontalDims.$12,
                  child: const ActivePhaseBadge(),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$16),
            child: ProjectCardInfo(project: project),
          ),
        ],
      ),
    );
  }
}
