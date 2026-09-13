import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/deliverables/cubit/deliverables_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/app_viewer_helper.dart';
import 'package:flutter/material.dart';

class RendersSection extends StatelessWidget {
  const RendersSection({required this.renders, super.key});

  final List<RenderModel> renders;

  @override
  Widget build(BuildContext context) {
    if (renders.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.localization.deliverables3dRender,
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: Resources.fontSizes.$18,
                fontWeight: Resources.fontWeights.semiBold,
                color: Resources.colors.luxuryNavy,
              ),
            ),
            Text(
              context.localization.deliverablesItemsCount(renders.length),
              style: context.textTheme.labelMedium?.copyWith(
                color: Resources.colors.luxuryGoldLight,
                fontWeight: Resources.fontWeights.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: Resources.verticalDims.$16),
        // Custom asymmetrical grid
        Row(
          children: [
            if (renders.isNotEmpty)
              Expanded(flex: 2, child: _RenderCard(render: renders[0])),
            if (renders.length > 1) ...[
              SizedBox(width: Resources.horizontalDims.$8),
              Expanded(
                child: Column(
                  children: [
                    _RenderCard(render: renders[1]),
                    if (renders.length > 2) ...[
                      SizedBox(height: Resources.verticalDims.$8),
                      _RenderCard(render: renders[2]),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _RenderCard extends StatelessWidget {
  const _RenderCard({required this.render});

  final RenderModel render;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio:
          1, // square items in the small column, the main column will stretch based on flex but for now aspect ratio 1 is a good base
      child: GestureDetector(
        onTap: () {
          AppViewerHelper.openImage(
            context,
            urlOrAsset: render.imageAsset ?? '',
            title: context.localization.deliverables3dRender,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Resources.radius.$r4),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(render.imageAsset ?? '', fit: BoxFit.cover),
              Positioned(
                top: Resources.verticalDims.$6,
                left: Resources.horizontalDims.$6,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Resources.horizontalDims.$6,
                    vertical: Resources.verticalDims.$2,
                  ),
                  decoration: BoxDecoration(
                    color: Resources.colors.luxuryNavy.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(Resources.radius.$r4),
                  ),
                  child: Text(
                    render.resolution ?? '',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: Resources.fontWeights.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
