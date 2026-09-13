import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/extensions/api_error_l10n_x.dart';
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
    this.message,
    this.errorModel,
    this.title,
    this.retryLabel,
    this.onRetry,
    super.key,
  }) : _isSection = false;

  const AppErrorState.section({
    this.message,
    this.errorModel,
    this.title,
    this.retryLabel,
    this.onRetry,
    super.key,
  }) : _isSection = true;

  final bool _isSection;
  final String? title;
  final String? message;
  final AppErrorModel? errorModel;
  final String? retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _isSection ? 0 : Resources.horizontalDims.$32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: _isSection
                ? Resources.iconSizes.$24
                : Resources.iconSizes.$48,
            color: Resources.colors.luxuryError,
          ),
          SizedBox(
            height: _isSection
                ? Resources.verticalDims.$10
                : Resources.verticalDims.$24,
          ),
          Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title ?? '${l10n.errorGenericTitle}.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontSize: _isSection ? Resources.fontSizes.$12 : null,
                ),
              ),
              if (onRetry != null && _isSection)
                GestureDetector(
                  onTap: onRetry,
                  child: Icon(
                    Icons.refresh_outlined,
                    size: Resources.iconSizes.$18,
                  ),
                ),
            ],
          ),
          if (onRetry != null && !_isSection) ...[
            SizedBox(
              height: _isSection
                  ? Resources.verticalDims.$4
                  : Resources.verticalDims.$8,
            ),
            Text(
              message ??
                  errorModel?.message ??
                  errorModel?.code.messageOf(context) ??
                  '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Resources.colors.luxuryBodyMuted,
              ),
            ),
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
