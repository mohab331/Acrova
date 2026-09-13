import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/core/error/error_codes_enum.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/helpers/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class AppViewerHelper {
  /// Opens full-screen zoomable image viewer
  static void openImage(
    BuildContext context, {
    required String urlOrAsset,
    String? title,
  }) {
    final trimmed = urlOrAsset.trim();
    if (trimmed.isEmpty) return;

    context.push(
      AppRouteEnum.imageViewerPage.path,
      extra: ImageViewerArgs(
        title: title ?? '',
        urlOrAsset: trimmed,
      ),
    );
  }

  /// Opens the PDF viewer page
  static void openPdf(
    BuildContext context, {
    required String urlOrAsset,
    String? title,
  }) {
    final trimmed = urlOrAsset.trim();
    if (trimmed.isEmpty) return;

    context.push(
      AppRouteEnum.pdfViewerPage.path,
      extra: PdfViewerArgs(
        title: title ?? '',
        urlOrAsset: trimmed,
      ),
    );
  }

  /// Opens the in-app WebView page
  static void openWeb(
    BuildContext context, {
    required String url,
    String? title,
  }) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return;

    context.push(
      AppRouteEnum.webViewPage.path,
      extra: WebViewArgs(
        title: title ?? '',
        url: trimmed,
      ),
    );
  }

  /// Automatically discriminates between PDF and Web URLs and opens the appropriate viewer.
  /// Safely handles null or empty URLs.
  static void openDocumentOrUrl(
    BuildContext context, {
    required String? urlOrAsset,
    String? title,
  }) {
    final trimmed = urlOrAsset?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      CustomToastification.error(
        context: context,
        errorModel: AppErrorModel(
          code: ErrorCodesEnum.inAppErrorCode,
          title: context.localization.errorGenericTitle,
          message: context.localization.error_message_unknown,
        ),
      ).showToast();
      return;
    }

    if (isPdf(trimmed)) {
      openPdf(context, urlOrAsset: trimmed, title: title);
    } else {
      openWeb(context, url: trimmed, title: title);
    }
  }

  /// Determines whether the given URL or asset path points to a PDF document.
  static bool isPdf(String urlOrAsset) {
    final clean = urlOrAsset.split('?').first.split('#').first.toLowerCase();
    return clean.endsWith('.pdf');
  }

  /// Determines whether the given URL or asset path points to an image.
  static bool isImage(String urlOrAsset) {
    final clean = urlOrAsset.split('?').first.split('#').first.toLowerCase();
    return clean.endsWith('.png') ||
        clean.endsWith('.jpg') ||
        clean.endsWith('.jpeg') ||
        clean.endsWith('.webp') ||
        clean.endsWith('.gif') ||
        clean.endsWith('.bmp');
  }
}

