import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/widgets/interior_design_card.dart';
import 'package:acrova/presentation/features/ui/projects/widgets/project_card_info.dart';
import 'package:flutter/material.dart';

class StandardProjectCard extends StatelessWidget {
  const StandardProjectCard({required this.project, super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardThumbnail(thumbnailUrl: project.thumbnailUrl),
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$16),
            child: ProjectCardInfo(project: project),
          ),
        ],
      ),
    );
  }
}
