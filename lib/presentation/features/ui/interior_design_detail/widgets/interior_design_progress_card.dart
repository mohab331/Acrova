import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/progress/app_icon_stepper.dart';
import 'package:acrova/utils/enums/interior_design_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class InteriorDesignProgressCard extends StatelessWidget {
  const InteriorDesignProgressCard({required this.item, super.key});

  final InteriorDesignResponseModel? item;

  @override
  Widget build(BuildContext context) {
    final status = item?.status ?? InteriorDesignStatus.awaitingPricing;
    final currentStep = InteriorDesignStatus.values.indexOf(status);
    final totalSteps = InteriorDesignStatus.values.length;
    final percentage = status.progressPercentage;

    final icons = const [
      Icons.request_quote_outlined,
      Icons.payments_outlined,
      Icons.pending_actions_outlined,
      Icons.architecture_outlined,
      Icons.palette_outlined,
      Icons.draw_outlined,
      Icons.done_all,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
        border: Border.all(color: Resources.colors.luxuryGoldBorder),
        boxShadow: AppShadows.card,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$16,
        vertical: Resources.verticalDims.$16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProgressCardTopRow(
            percentage: percentage,
            statusLabel: Directionality.of(context) == TextDirection.rtl
                ? status.displayLabelAr
                : status.displayLabel,
          ),
          SizedBox(height: Resources.verticalDims.$20),
          AppIconStepper(
            totalSteps: totalSteps,
            currentStep: currentStep >= 0 ? currentStep : 0,
            icons: icons,
          ),
        ],
      ),
    );
  }
}

class _ProgressCardTopRow extends StatelessWidget {
  const _ProgressCardTopRow({
    required this.percentage,
    required this.statusLabel,
  });

  final int percentage;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.projectProgressTitle,
                style: context.textTheme.labelLarge?.copyWith(
                  fontSize: Resources.fontSizes.$18,
                  fontWeight: Resources.fontWeights.semiBold,
                  color: Resources.colors.luxuryNavy,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$6),
              Text(
                statusLabel,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: Resources.fontSizes.$14,
                  color: Resources.colors.luxuryBody,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$percentage%',
              style: context.textTheme.displayMedium?.copyWith(
                color: Resources.colors.luxuryGoldLight,
                fontSize: Resources.fontSizes.$28,
                fontWeight: Resources.fontWeights.bold,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$4),
            Text(
              loc.projectProgressComplete,
              style: context.textTheme.labelMedium?.copyWith(
                color: Resources.colors.luxuryBodyMuted,
                fontSize: Resources.fontSizes.$10,
                fontWeight: Resources.fontWeights.bold,
                letterSpacing: Resources.letterSpacing.$1_0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
