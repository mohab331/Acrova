import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/enums/interior_design_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class InteriorDesignCard extends StatelessWidget {
  const InteriorDesignCard({
    required this.item,
    required this.onTap,
    super.key,
  });

  final InteriorDesignResponseModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Resources.colors.luxurySurface,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          border: Border.all(color: Resources.colors.luxuryBorder),
          boxShadow: AppShadows.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardThumbnail(thumbnailUrl: item.thumbnailUrl),
            Padding(
              padding: EdgeInsets.all(Resources.horizontalDims.$16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardHeader(
                    referenceNumber: item.referenceNumber ?? item.id ?? '',
                    status: item.status,
                  ),
                  SizedBox(height: Resources.verticalDims.$8),
                  _CardTitleAndProject(
                    title: item.title ?? item.referenceNumber ?? '',
                    projectName: item.projectName,
                  ),
                  SizedBox(height: Resources.verticalDims.$12),
                  _CardSpecsTags(item: item),
                  SizedBox(height: Resources.verticalDims.$16),
                  Divider(height: 1, color: Resources.colors.luxuryBorder),
                  SizedBox(height: Resources.verticalDims.$12),
                  _CardProgressSection(status: item.status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardThumbnail extends StatelessWidget {
  const _CardThumbnail({this.thumbnailUrl});

  final String? thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Resources.verticalDims.$160,
      width: double.infinity,
      child: AppCachedNetworkImage(
        imageUrl: thumbnailUrl ?? '',
        width: double.infinity,
        height: Resources.verticalDims.$160,
        radius: 0,
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.referenceNumber, this.status});

  final String referenceNumber;
  final InteriorDesignStatus? status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          referenceNumber,
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: Resources.fontSizes.$10,
            fontWeight: Resources.fontWeights.medium,
            color: Resources.colors.luxuryBodyMuted,
            letterSpacing: Resources.letterSpacing.$1_0,
          ),
        ),
        if (status != null) _StatusBadge(status: status!),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final InteriorDesignStatus status;

  @override
  Widget build(BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;
    final label = isArabic ? status.displayLabelAr : status.displayLabel;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$8,
        vertical: Resources.verticalDims.$4,
      ),
      decoration: BoxDecoration(
        color: status.chipBackground,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: Resources.fontSizes.$10,
          fontWeight: Resources.fontWeights.semiBold,
          color: status.chipForeground,
        ),
      ),
    );
  }
}

class _CardTitleAndProject extends StatelessWidget {
  const _CardTitleAndProject({required this.title, this.projectName});

  final String title;
  final String? projectName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: Resources.fontSizes.$16,
            fontWeight: Resources.fontWeights.bold,
            color: Resources.colors.luxuryInk,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (projectName != null && projectName!.isNotEmpty) ...[
          SizedBox(height: Resources.verticalDims.$4),
          Row(
            children: [
              Icon(
                Icons.apartment_outlined,
                size: Resources.fontSizes.$14,
                color: Resources.colors.luxuryGoldLight,
              ),
              SizedBox(width: Resources.horizontalDims.$4),
              Expanded(
                child: Text(
                  projectName!,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: Resources.fontSizes.$12,
                    color: Resources.colors.luxuryBody,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _CardSpecsTags extends StatelessWidget {
  const _CardSpecsTags({required this.item});

  final InteriorDesignResponseModel item;

  @override
  Widget build(BuildContext context) {
    final tags = <String>[];
    if (item.scope != null) {
      tags.add(item.scope!.localizedLabel(context));
    }
    if (item.budgetTier != null) {
      tags.add(item.budgetTier!.localizedLabel(context));
    }
    if (item.timeline != null) {
      tags.add(item.timeline!.localizedLabel(context));
    }

    if (tags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: Resources.horizontalDims.$6,
      runSpacing: Resources.verticalDims.$6,
      children: tags.map((tag) => _SpecTag(label: tag)).toList(),
    );
  }
}

class _SpecTag extends StatelessWidget {
  const _SpecTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$8,
        vertical: Resources.verticalDims.$2,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryInputBg,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: Resources.fontSizes.$10,
          color: Resources.colors.luxuryBody,
          fontWeight: Resources.fontWeights.medium,
        ),
      ),
    );
  }
}

class _CardProgressSection extends StatelessWidget {
  const _CardProgressSection({this.status});

  final InteriorDesignStatus? status;

  @override
  Widget build(BuildContext context) {
    final ratio = status?.progressRatio ?? 0.0;
    final percentage = status?.progressPercentage ?? 0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.localization.projectsCompletion,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: Resources.fontSizes.$10,
                color: Resources.colors.luxuryInk,
              ),
            ),
            Text(
              '$percentage%',
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: Resources.fontSizes.$14,
                fontWeight: Resources.fontWeights.bold,
                color: Resources.colors.luxuryGoldLight,
              ),
            ),
          ],
        ),
        SizedBox(height: Resources.verticalDims.$8),
        ClipRRect(
          borderRadius: BorderRadius.circular(Resources.radius.$r100),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: Resources.verticalDims.$4,
            backgroundColor: Resources.colors.luxuryProgressTrack,
            valueColor: AlwaysStoppedAnimation<Color>(
              Resources.colors.luxuryGoldLight,
            ),
          ),
        ),
      ],
    );
  }
}
