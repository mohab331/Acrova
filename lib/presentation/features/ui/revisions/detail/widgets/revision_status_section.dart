import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/enums/revision_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevisionStatusSection extends StatelessWidget {
  const RevisionStatusSection({required this.revision, super.key});

  final RevisionModel revision;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final date = DateFormat('MMM dd, yyyy').format(revision.createdAt);
    final label = context.isRtl
        ? revision.status.displayLabelAr
        : revision.status.displayLabel;

    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$24),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        boxShadow: AppShadows.card,
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.revisionDetailStatusLabel.toUpperCase(),
                      style: TextStyle(
                        fontFamily: Resources.fonts.manrope,
                        fontSize: Resources.fontSizes.$10,
                        fontWeight: Resources.fontWeights.bold,
                        letterSpacing: Resources.letterSpacing.$1_0,
                        color: Resources.colors.luxuryGold,
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$8),
                    Text(
                      label.toUpperCase(),
                      style: context.textTheme.titleLarge?.copyWith(
                        color: Resources.colors.luxuryNavy,
                        fontWeight: Resources.fontWeights.semiBold
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(Resources.horizontalDims.$12),
                decoration: BoxDecoration(
                  color:  Resources.colors.luxuryBackground,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.card,
                ),
                child: Icon(
                  revision.status.isInProgress
                      ? Icons.hourglass_top_rounded
                      : Icons.check_circle,
                  color: Resources.colors.luxuryGold,
                  size: Resources.iconSizes.$24,
                ),
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Divider(height: 1, color: Resources.colors.luxuryBorder),
          SizedBox(height: Resources.verticalDims.$16),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: Resources.iconSizes.$14,
                color: Resources.colors.luxuryBodyMuted,
              ),
              SizedBox(width: Resources.horizontalDims.$8),
              Text(
                date,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: Resources.fontSizes.$14,
                  color: Resources.colors.luxuryBody,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
