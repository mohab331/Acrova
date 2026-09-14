import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/interior_design_list/widgets/interior_design_card.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_meta_dot.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class InteriorDesignDetailHeader extends StatelessWidget {
  const InteriorDesignDetailHeader({required this.item, super.key});

  final InteriorDesignResponseModel? item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardHeader(
          referenceNumber: item?.referenceNumber ?? item?.id ?? '',
          status: item?.status,
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Text(
          item?.title ?? item?.referenceNumber ?? '',
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: Resources.fontSizes.$18,
            fontWeight: Resources.fontWeights.semiBold,
            color: Resources.colors.luxuryNavy,
            height: Resources.lineHeights.$1_25,
          ),
        ),
        if (item?.projectName != null &&
            (item?.projectName?.isNotEmpty ?? false)) ...[
          SizedBox(height: Resources.verticalDims.$8),
          _ProjectSubtitle(projectName: item?.projectName),
        ],
        if (item?.amountDue != null && ((item?.amountDue ?? 0) > 0)) ...[
          SizedBox(height: Resources.verticalDims.$12),
          _PriceBadge(amountDue: item?.amountDue),
        ],
      ],
    );
  }
}

class _ProjectSubtitle extends StatelessWidget {
  const _ProjectSubtitle({required this.projectName});

  final String? projectName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.apartment,
          size: Resources.fontSizes.$16,
          color: Resources.colors.luxuryBodyMuted,
        ),
        SizedBox(width: Resources.horizontalDims.$6),
        DetailMetaDot(text: '${projectName?.toUpperCase()}'),
      ],
    );
  }
}

class _PriceBadge extends StatelessWidget {
  const _PriceBadge({required this.amountDue});

  final double? amountDue;

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
        border: Border.all(color: Resources.colors.luxuryGold),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${amountDue?.toStringAsFixed(2)} ${loc.sar}',
            style: TextStyle(
              fontSize: Resources.fontSizes.$12,
              fontWeight: Resources.fontWeights.bold,
              color: Resources.colors.luxuryInk,
            ),
          ),
        ],
      ),
    );
  }
}
