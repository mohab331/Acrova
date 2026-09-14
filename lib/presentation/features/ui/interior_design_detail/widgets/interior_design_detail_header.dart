import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/interior_design_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class InteriorDesignDetailHeader extends StatelessWidget {
  const InteriorDesignDetailHeader({required this.item, super.key});

  final InteriorDesignResponseModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeaderTopRow(
          referenceNumber: item.referenceNumber ?? item.id ?? '',
          status: item.status,
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Text(
          item.title ?? item.referenceNumber ?? '',
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: Resources.fontSizes.$20,
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
            height: Resources.lineHeights.$1_25,
          ),
        ),
        if (item.projectName != null && item.projectName!.isNotEmpty) ...[
          SizedBox(height: Resources.verticalDims.$8),
          _ProjectSubtitle(projectName: item.projectName!),
        ],
        if (item.amountDue != null && item.amountDue! > 0) ...[
          SizedBox(height: Resources.verticalDims.$12),
          _PriceBadge(amountDue: item.amountDue!),
        ],
      ],
    );
  }
}

class _HeaderTopRow extends StatelessWidget {
  const _HeaderTopRow({required this.referenceNumber, this.status});

  final String referenceNumber;
  final InteriorDesignStatus? status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          referenceNumber.toUpperCase(),
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: Resources.fontSizes.$12,
            fontWeight: Resources.fontWeights.extraBold,
            color: Resources.colors.luxuryGoldLight,
            letterSpacing: Resources.letterSpacing.$1_2,
          ),
        ),
        if (status != null) _DetailStatusChip(status: status!),
      ],
    );
  }
}

class _DetailStatusChip extends StatelessWidget {
  const _DetailStatusChip({required this.status});

  final InteriorDesignStatus status;

  @override
  Widget build(BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;
    final label = isArabic ? status.displayLabelAr : status.displayLabel;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$10,
        vertical: Resources.verticalDims.$4,
      ),
      decoration: BoxDecoration(
        color: status.chipBackground,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: Resources.fontSizes.$12,
          fontWeight: Resources.fontWeights.semiBold,
          color: status.chipForeground,
        ),
      ),
    );
  }
}

class _ProjectSubtitle extends StatelessWidget {
  const _ProjectSubtitle({required this.projectName});

  final String projectName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.apartment_outlined,
          size: Resources.fontSizes.$16,
          color: Resources.colors.luxuryGoldLight,
        ),
        SizedBox(width: Resources.horizontalDims.$6),
        Text(
          projectName,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: Resources.fontSizes.$14,
            color: Resources.colors.luxuryBodyMuted,
            fontWeight: Resources.fontWeights.medium,
          ),
        ),
      ],
    );
  }
}

class _PriceBadge extends StatelessWidget {
  const _PriceBadge({required this.amountDue});

  final double amountDue;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$12,
        vertical: Resources.verticalDims.$6,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryInputBg,
        borderRadius: BorderRadius.circular(Resources.radius.$r4),
        border: Border.all(color: Resources.colors.luxuryGoldBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${amountDue.toStringAsFixed(0)} ${loc.sar}',
            style: TextStyle(
              fontSize: Resources.fontSizes.$16,
              fontWeight: Resources.fontWeights.bold,
              color: Resources.colors.luxuryGoldLight,
            ),
          ),
        ],
      ),
    );
  }
}
