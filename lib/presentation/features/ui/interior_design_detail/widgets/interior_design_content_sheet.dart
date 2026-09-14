import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/widgets/interior_design_color_palette_preview.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/widgets/interior_design_detail_header.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/widgets/interior_design_moodboard_preview.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/widgets/interior_design_progress_card.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/widgets/interior_design_specs_grid.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/widgets/related_project_card.dart';
import 'package:acrova/presentation/features/ui/project_detail/widgets/project_engineer_card.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class InteriorDesignContentSheet extends StatelessWidget {
  const InteriorDesignContentSheet({required this.item, super.key});

  final InteriorDesignResponseModel? item;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    final notes = item?.customScopeNotes ?? item?.extraNotes;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Resources.radius.$r16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Resources.verticalDims.$12),
          const HandleBar(),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: Resources.horizontalDims.$24,
              top: Resources.verticalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: InteriorDesignDetailHeader(item: item),
          ),
          if (notes != null && notes.isNotEmpty) ...[
            SizedBox(height: Resources.verticalDims.$32),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: Resources.horizontalDims.$24,
                end: Resources.horizontalDims.$24,
              ),
              child: _NotesSection(notes: notes),
            ),
          ],
          SizedBox(height: Resources.verticalDims.$32),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: Text(
              loc.portfolioSpecifications,
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: Resources.fontSizes.$18,
                fontWeight: Resources.fontWeights.semiBold,
                color: Resources.colors.luxuryNavy,
              ),
            ),
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: InteriorDesignSpecsGrid(item: item),
          ),
          SizedBox(height: Resources.verticalDims.$32),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: Resources.horizontalDims.$24,
              end: Resources.horizontalDims.$24,
            ),
            child: InteriorDesignProgressCard(item: item),
          ),

          if ((item?.moodboards.isNotEmpty ?? false)) ...[
            SizedBox(height: Resources.verticalDims.$32),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: Resources.horizontalDims.$24,
                end: Resources.horizontalDims.$24,
              ),
              child: InteriorDesignMoodboardPreview(item: item),
            ),
          ],
          if (item?.colorPalette.isNotEmpty ?? false) ...[
            SizedBox(height: Resources.verticalDims.$32),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: Resources.horizontalDims.$24,
                end: Resources.horizontalDims.$24,
              ),
              child: InteriorDesignColorPalettePreview(item: item),
            ),
          ],
          if (item?.designer != null) ...[
            SizedBox(height: Resources.verticalDims.$32),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: Resources.horizontalDims.$24,
                end: Resources.horizontalDims.$24,
              ),
              child: ProjectEngineerCard(engineer: item?.designer),
            ),
          ],
          if (item?.projectId != null &&
              (item?.projectId?.isNotEmpty ?? false)) ...[
            SizedBox(height: Resources.verticalDims.$32),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: Resources.horizontalDims.$24,
                end: Resources.horizontalDims.$24,
              ),
              child: RelatedProjectCard(
                projectId: item?.projectId,
                projectName: item?.projectName,
                projectThumbnailUrl: item?.projectThumbnailUrl,
              ),
            ),
          ],
          SizedBox(height: Resources.verticalDims.$32),
        ],
      ),
    );
  }
}

class HandleBar extends StatelessWidget {
  const HandleBar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Resources.horizontalDims.$50,
        height: Resources.verticalDims.$4,
        decoration: BoxDecoration(
          color: Resources.colors.luxuryInputBorder,
          borderRadius: BorderRadius.circular(Resources.radius.$r2),
        ),
      ),
    );
  }
}

class _NotesSection extends StatelessWidget {
  const _NotesSection({required this.notes});

  final String notes;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.designPreferencesLabelNotes,
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: Resources.fontSizes.$18,
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$12),
        Text(
          notes,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: Resources.fontSizes.$14,
            color: Resources.colors.luxuryBody,
            height: Resources.lineHeights.$1_6,
          ),
        ),
      ],
    );
  }
}
