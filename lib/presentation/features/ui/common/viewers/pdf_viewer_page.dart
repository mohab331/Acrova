import 'dart:io';

import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

export 'package:acrova/presentation/app/navigation/args/navigation_args.dart'
    show PdfViewerArgs;

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({this.args, super.key});

  final PdfViewerArgs? args;

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  bool _hasError = false;
  String? _errorMessage;
  int _retryKey = 0;

  void _retry() {
    setState(() {
      _hasError = false;
      _errorMessage = null;
      _retryKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.args?.title ?? '';
    final urlOrAsset = widget.args?.urlOrAsset.trim() ?? '';

    return Scaffold(
      backgroundColor: Resources.colors.luxurySurface,
      appBar: AppBar(
        backgroundColor: Resources.colors.luxurySurface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Resources.colors.luxuryNavy),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            color: Resources.colors.luxuryNavy,
            fontWeight: Resources.fontWeights.semiBold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (urlOrAsset.isNotEmpty && !_hasError)
            IconButton(
              icon: Icon(
                Icons.download_rounded,
                color: Resources.colors.luxuryGoldLight,
              ),
              onPressed: () {
                DownloadHelper.downloadAndShare(context, urlOrAsset, title);
              },
            ),
        ],
      ),
      body: _PdfViewerBody(
        urlOrAsset: urlOrAsset,
        hasError: _hasError,
        errorMessage: _errorMessage,
        retryKey: _retryKey,
        onRetry: _retry,
        onError: (message) {
          if (mounted) {
            setState(() {
              _hasError = true;
              _errorMessage = message;
            });
          }
        },
      ),
    );
  }
}

class _PdfViewerBody extends StatelessWidget {
  const _PdfViewerBody({
    required this.urlOrAsset,
    required this.hasError,
    required this.errorMessage,
    required this.retryKey,
    required this.onRetry,
    required this.onError,
  });
  final String urlOrAsset;
  final bool hasError;
  final String? errorMessage;
  final int retryKey;
  final VoidCallback onRetry;
  final ValueChanged<String?> onError;
  @override
  Widget build(BuildContext context) {
    final loc = context.localization;
    if (urlOrAsset.isEmpty || hasError) {
      return CommonErrorWidget(
        title: loc.errorGenericTitle,
        message: errorMessage ?? loc.error_message_unknown,
        retryLabel: loc.errorRetryLabel,
        onRetry: onRetry,
      );
    }
    final key = ValueKey('pdf_viewer_${urlOrAsset}_$retryKey');
    void handleDocumentLoadFailed(details) {
      onError(details.description);
    }

    if (urlOrAsset.startsWith('assets/')) {
      return SfPdfViewer.asset(
        urlOrAsset,
        key: key,
        onDocumentLoadFailed: handleDocumentLoadFailed,
      );
    }
    if (urlOrAsset.startsWith('http://') || urlOrAsset.startsWith('https://')) {
      return SfPdfViewer.network(
        urlOrAsset,
        key: key,
        onDocumentLoadFailed: handleDocumentLoadFailed,
      );
    }
    return SfPdfViewer.file(
      File(urlOrAsset),
      key: key,
      onDocumentLoadFailed: handleDocumentLoadFailed,
    );
  }
}
