import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({required this.amount,super.key});

  final String amount;

  @override
  Widget build(BuildContext context) {
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
          label: 'RETURN TO DASHBOARD',
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$32),
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
                'Payment Submitted',
                style: context.textTheme.titleLarge?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Resources.verticalDims.$16),
              Text(
                'Your payment receipt has been successfully uploaded and is pending verification. You will be notified once it is approved.',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Resources.colors.luxuryBody,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Resources.verticalDims.$16),
              Text(
                'Reference no. #92819182',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Resources.colors.luxuryBody,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
