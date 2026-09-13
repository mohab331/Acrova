import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class PaymentHistoryEmptyState extends StatelessWidget {
  const PaymentHistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Resources.squareDims.$96,
            height: Resources.squareDims.$96,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.account_balance_outlined,
              size: Resources.iconSizes.$48,
              color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: Resources.verticalDims.$24),
          Text(
            loc.paymentHistoryEmptyTitle,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Resources.verticalDims.$8),
          Text(
            loc.paymentHistoryEmptySubtitle,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Resources.colors.luxuryBody,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Resources.verticalDims.$32),
          AppPrimaryButton(
            label: loc.paymentHistoryStartNewProject,
            onPressed: () {
              context.push(AppRouteEnum.projectCreationPage.name);
            },
          ),
        ],
      ),
    );
  }
}
