import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:flutter/material.dart';

/// Generic error state — centered error icon + message + retry button.
///
/// Design tokens:
/// - Icon: luxuryError (#C0392B), 48px
/// - Title: NotoSerif 700, 20px (titleLarge), luxuryNavy
/// - Message: Manrope 400, 14px (bodySmall), luxuryBodyMuted
/// - Retry CTA: [AppPrimaryButton]
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    required this.message,
    this.title = 'Something went wrong',
    this.retryLabel = 'TRY AGAIN',
    this.onRetry,
    super.key,
  });

  final String title;
  final String message;
  final String retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: Resources.colors.luxuryError,
          ),
          SizedBox(height: Resources.verticalDims.$24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Resources.colors.luxuryNavy,
                ),
          ),
          SizedBox(height: Resources.verticalDims.$8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Resources.colors.luxuryBodyMuted,
                ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: Resources.verticalDims.$32),
            AppPrimaryButton(label: retryLabel, onPressed: onRetry),
          ],
        ],
      ),
    );
  }
}
