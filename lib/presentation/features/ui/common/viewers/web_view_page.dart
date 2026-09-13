import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

export 'package:acrova/presentation/app/navigation/args/navigation_args.dart'
    show WebViewArgs;

class WebViewPage extends StatefulWidget {
  const WebViewPage({this.args, super.key});

  final WebViewArgs? args;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  int _loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    final url = widget.args?.url.trim() ?? '';
    if (url.isEmpty) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = null;
      });
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null || (!uri.isScheme('http') && !uri.isScheme('https'))) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = null;
      });
      return;
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) {
              setState(() {
                _loadingProgress = progress;
              });
            }
          },
          onPageStarted: (url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _hasError = false;
              });
            }
          },
          onPageFinished: (url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (error) {
            // Main frame errors
            if (error.isForMainFrame ?? true) {
              if (mounted) {
                setState(() {
                  _hasError = true;
                  _isLoading = false;
                  _errorMessage = error.description;
                });
              }
            }
          },
        ),
      )
      ..loadRequest(uri);
  }

  void _retry() {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = null;
      _loadingProgress = 0;
    });
    if (_controller != null) {
      _controller!.reload();
    } else {
      _initController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.args?.title ?? '';

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
          if (_controller != null)
            IconButton(
              icon: Icon(
                Icons.refresh_rounded,
                color: Resources.colors.luxuryGoldLight,
              ),
              onPressed: _retry,
            ),
        ],
        bottom: _isLoading && !_hasError
            ? PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: LinearProgressIndicator(
                  value: _loadingProgress > 0 ? _loadingProgress / 100 : null,
                  backgroundColor: Resources.colors.luxuryProgressTrack,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Resources.colors.luxuryGoldLight,
                  ),
                  minHeight: 2,
                ),
              )
            : null,
      ),
      body: _WebViewBody(
        hasError: _hasError,
        errorMessage: _errorMessage,
        controller: _controller,
        onRetry: _retry,
      ),
    );
  }
}

class _WebViewBody extends StatelessWidget {
  const _WebViewBody({
    required this.hasError,
    required this.errorMessage,
    required this.controller,
    required this.onRetry,
  });

  final bool hasError;
  final String? errorMessage;
  final WebViewController? controller;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (hasError || controller == null) {
      return CommonErrorWidget(
        title: context.localization.errorGenericTitle,
        message: errorMessage ?? context.localization.error_message_unknown,
        retryLabel: context.localization.errorRetryLabel,
        onRetry: onRetry,
      );
    }

    return WebViewWidget(controller: controller!);
  }
}
