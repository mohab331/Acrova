import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({
    this.args,
    super.key,
  });

  final PaymentSuccessArgs? args;

  String get amount => args?.amount ?? '';
  String? get referenceNumber => args?.referenceNumber;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return CommonScreen(
      bottomPadding: 0,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          top: Resources.verticalDims.$16,
          left: Resources.horizontalDims.$24,
          right: Resources.horizontalDims.$24,
          bottom: Resources.verticalDims.$32,
        ),
        decoration: BoxDecoration(
          color: Resources.colors.luxurySurface,
          boxShadow: [
            BoxShadow(
              color: Resources.colors.luxuryInk.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: AppPrimaryButton(
          onPressed: () {
            // Return to home dashboard
            context.go(AppRouteEnum.homePage.path);
          },
          label: loc.paymentSuccessReturnToDashboard,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Resources.verticalDims.$80,
                height: Resources.verticalDims.$80,
                decoration: BoxDecoration(
                  color: Resources.colors.luxurySuccess.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.check_circle_outline,
                    size: Resources.verticalDims.$40,
                    color: Resources.colors.luxurySuccess,
                  ),
                ),
              ),
              SizedBox(height: Resources.verticalDims.$24),
              Text(
                loc.paymentSuccessSubmitted,
                style: context.textTheme.titleLarge?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Resources.verticalDims.$16),
              Text(
                loc.paymentSuccessDescription,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Resources.colors.luxuryBody,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              if (referenceNumber != null && referenceNumber!.isNotEmpty) ...[
                SizedBox(height: Resources.verticalDims.$16),
                Text(
                  loc.paymentSuccessReference(referenceNumber!),
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Resources.colors.luxuryBody,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
