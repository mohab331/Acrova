import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/api_error_l10n_x.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class UiHelper {
  static double getLineHeight({
    required double fontSize,
    required double height,
  }) => height / fontSize;
}

class CustomToastification {
  final BuildContext context;
  final String? message;

  final AppErrorModel? errorModel;
  final Duration duration;
  final Color? shadowColor;
  final bool? hasShadow;

  CustomToastification.success({
    required this.context,
    required this.message,
    this.hasShadow,
    this.shadowColor,
    this.duration = const Duration(seconds: 2),
  }) : errorModel = null,
       _isError = false;

  CustomToastification.error({
    required this.context,
    required this.errorModel,
    this.hasShadow,
    this.shadowColor,
    this.duration = const Duration(seconds: 2),
  }) : message = null,
       _isError = true;

  final bool _isError;

  /// Show the toast with overlay
  Future<void> showToast() async {
    final overlayEntry = _showOverlay();

    _showToast();

    await Future.delayed(duration);
    overlayEntry.remove();
  }

  /// Creates and inserts the dimmed overlay
  OverlayEntry _showOverlay() {
    final overlayEntry = OverlayEntry(
      builder: (_) => GestureDetector(
        child: Container(color: Resources.colors.black.withValues(alpha: 0.4)),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    return overlayEntry;
  }

  /// Shows the actual toast
  void _showToast() {
    final toastification = Toastification();
    toastification.dismissAll();
    toastification.show(
      context: context,
      autoCloseDuration: duration,
      direction: context.isRtl ? TextDirection.rtl : TextDirection.ltr,
      alignment: AlignmentGeometry.topCenter,
      title: Text(
        _isError
            ? (errorModel?.message ??
                  errorModel?.code.messageOf(context) ??
                  context.localization.error_message_unknown)
            : (message ?? ''),
      ),
      type: _isError ? ToastificationType.error : ToastificationType.success,
    );
  }
}
