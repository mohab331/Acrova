import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
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
    this.title,
    this.retryLabel,
    this.onRetry,
    super.key,
  });

  final String? title;
  final String message;
  final String? retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: Resources.iconSizes.$48,
            color: Resources.colors.luxuryError,
          ),
          SizedBox(height: Resources.verticalDims.$24),
          Text(
            title ?? l10n.errorGenericTitle,
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
            AppPrimaryButton(
              label: retryLabel ?? l10n.errorRetryLabel,
              onPressed: onRetry,
            ),
          ],
        ],
      ),
    );
  }
}
