import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

export 'package:acrova/presentation/app/navigation/args/navigation_args.dart'
    show PdfViewerArgs;

class PdfViewerPage extends StatelessWidget {
  const PdfViewerPage({this.args, super.key});

  final PdfViewerArgs? args;

  @override
  Widget build(BuildContext context) {
    final title = args?.title ?? '';
    final urlOrAsset = args?.urlOrAsset ?? '';

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
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.download_rounded,
              color: Resources.colors.luxuryGoldLight,
            ),
            onPressed: () {
              if (urlOrAsset.isNotEmpty) {
                DownloadHelper.downloadAndShare(context, urlOrAsset, '$title');
              }
            },
          ),
        ],
      ),
      body: urlOrAsset.isEmpty
          ? const SizedBox.shrink()
          : (urlOrAsset.startsWith('assets/')
                ? SfPdfViewer.asset(urlOrAsset)
                : SfPdfViewer.network(urlOrAsset)),
    );
  }
}
