import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/deliverables/deliverables_state.dart';
import 'package:acrova/presentation/features/ui/common/viewers/pdf_viewer_page.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlueprintsSection extends StatelessWidget {
  const BlueprintsSection({
    required this.blueprints,
    super.key,
  });

  final List<BlueprintModel> blueprints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Construction Blueprints',
              style: context.textTheme.headlineSmall?.copyWith(
                color: Resources.colors.luxuryNavy,
              ),
            ),
          ],
        ),
        SizedBox(height: Resources.verticalDims.$20),
        ...blueprints.map((blueprint) => Padding(
          padding: EdgeInsets.only(bottom: Resources.verticalDims.$12),
          child: Container(
            padding: EdgeInsets.all(Resources.squareDims.$16),
            decoration: BoxDecoration(
              color: Resources.colors.luxurySurface,
              borderRadius: BorderRadius.circular(Resources.radius.$r12),
              boxShadow: AppShadows.card,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: Resources.squareDims.$40,
                      height: Resources.squareDims.$40,
                      decoration: BoxDecoration(
                        color: Resources.colors.luxuryError.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(Resources.radius.$r4),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.picture_as_pdf,
                          color: Resources.colors.luxuryError,
                        ),
                      ),
                    ),
                    SizedBox(width: Resources.horizontalDims.$16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blueprint.title,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: Resources.colors.luxuryNavy,
                            fontWeight: Resources.fontWeights.semiBold,
                          ),
                        ),
                        Text(
                          '${blueprint.size} • ${blueprint.format}',
                          style: context.textTheme.labelMedium?.copyWith(
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.push(
                          AppRouteEnum.pdfViewerPage.path,
                          extra: PdfViewerArgs(
                            title: blueprint.title,
                            urlOrAsset: blueprint.urlOrAsset,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.visibility_outlined,
                        color: Resources.colors.luxuryGoldLight,
                      ),
                      style: IconButton.styleFrom(
                        hoverColor: Resources.colors.luxuryGoldLight.withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Resources.radius.$r4),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        DownloadHelper.downloadAndShare(
                          blueprint.urlOrAsset,
                          '${blueprint.title}.pdf',
                        );
                      },
                      icon: Icon(
                        Icons.download_outlined,
                        color: Resources.colors.luxuryGoldLight,
                      ),
                      style: IconButton.styleFrom(
                        hoverColor: Resources.colors.luxuryGoldLight.withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Resources.radius.$r4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
