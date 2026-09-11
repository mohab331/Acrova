import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/extensions/api_error_l10n_x.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

/// Globally reusable error widget with retry mechanism.
class CommonErrorWidget extends StatelessWidget {
  const CommonErrorWidget({
    this.error,
    this.onRetry,
    this.title,
    this.message,
    this.retryLabel,
    super.key,
  });

  final AppErrorModel? error;
  final VoidCallback? onRetry;
  final String? title;
  final String? message;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final resolvedMessage =
        message ??
        error?.message ??
        error?.code.messageOf(context) ??
        l10n.error_message_unknown;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Resources.verticalDims.$80,
              height: Resources.verticalDims.$80,
              decoration: BoxDecoration(
                color: Resources.colors.luxuryError.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: Resources.iconSizes.$40,
                color: Resources.colors.luxuryError,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$24),
            Text(
              title ?? error?.title ?? l10n.errorGenericTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Resources.colors.luxuryNavy,
                fontWeight: Resources.fontWeights.semiBold,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$8),
            Text(
              resolvedMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Resources.colors.luxuryBodyMuted,
                height: 1.5,
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
      ),
    );
  }
}
