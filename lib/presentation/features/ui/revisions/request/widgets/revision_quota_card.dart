import 'package:acrova/data/models/revision/revision_quota_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class RevisionQuotaCard extends StatelessWidget {
  const RevisionQuotaCard({required this.quota, super.key});

  final RevisionQuotaModel quota;

  @override
  Widget build(BuildContext context) {
    return quota.hasFreeRemaining ? _free(context) : _paid(context);
  }

  Widget _free(BuildContext context) {
    final l10n = context.localization;
    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$20),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        border: Border(
          left: BorderSide(
            color: Resources.colors.luxuryGoldLight,
            width: AppBorderWidths.$2,
          ),
          top: BorderSide(color: Resources.colors.luxuryBorder),
          right: BorderSide(color: Resources.colors.luxuryBorder),
          bottom: BorderSide(color: Resources.colors.luxuryBorder),
        ),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${quota.remaining}',
                  style: TextStyle(
                    fontFamily: Resources.fonts.notoSerif,
                    fontSize: Resources.fontSizes.$48,
                    fontWeight: Resources.fontWeights.bold,
                    color: Resources.colors.luxuryNavy,
                    height: 1,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$4),
                Text(
                  l10n.revisionQuotaAvailable.toUpperCase(),
                  style: TextStyle(
                    fontFamily: Resources.fonts.manrope,
                    fontSize: Resources.fontSizes.$10,
                    fontWeight: Resources.fontWeights.semiBold,
                    letterSpacing: Resources.letterSpacing.$0_8,
                    color: Resources.colors.luxuryGold,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Text(
              l10n.revisionQuotaIncluded(quota.total),
              textAlign: TextAlign.end,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: Resources.fontSizes.$13,
                color: Resources.colors.luxuryBodyMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paid(BuildContext context) {
    final l10n = context.localization;
    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$20),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryWarning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        border: Border.all(
          color: Resources.colors.luxuryWarning.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Resources.colors.luxuryWarning,
                size: Resources.iconSizes.$24,
              ),
              SizedBox(width: Resources.horizontalDims.$12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.revisionQuotaNoneTitle,
                      style: TextStyle(
                        fontFamily: Resources.fonts.notoSerif,
                        fontSize: Resources.fontSizes.$16,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryWarning,
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$4),
                    Text(
                      l10n.revisionQuotaNoneBody,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: Resources.fontSizes.$13,
                        color: Resources.colors.luxuryBody,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Divider(color: Resources.colors.luxuryWarning.withValues(alpha: 0.2)),
          SizedBox(height: Resources.verticalDims.$12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.revisionQuotaPaidLabel.toUpperCase(),
                style: TextStyle(
                  fontFamily: Resources.fonts.manrope,
                  fontSize: Resources.fontSizes.$10,
                  fontWeight: Resources.fontWeights.semiBold,
                  letterSpacing: Resources.letterSpacing.$0_8,
                  color: Resources.colors.luxuryBodyMuted,
                ),
              ),
              Text(
                '${quota.currency} ${quota.paidCost.toStringAsFixed(0)}',
                style: TextStyle(
                  fontFamily: Resources.fonts.notoSerif,
                  fontSize: Resources.fontSizes.$20,
                  fontWeight: Resources.fontWeights.bold,
                  color: Resources.colors.luxuryNavy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
