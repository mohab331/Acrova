import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerArgs {
  final String title;
  final String urlOrAsset;

  const PdfViewerArgs({
    required this.title,
    required this.urlOrAsset,
  });
}

class PdfViewerPage extends StatelessWidget {
  const PdfViewerPage({
    required this.args,
    super.key,
  });

  final PdfViewerArgs args;

  @override
  Widget build(BuildContext context) {
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
          args.title,
          style: context.textTheme.titleMedium?.copyWith(
            color: Resources.colors.luxuryNavy,
            fontWeight: Resources.fontWeights.semiBold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download_rounded, color: Resources.colors.luxuryGoldLight),
            onPressed: () {
              DownloadHelper.downloadAndShare(args.urlOrAsset, '${args.title}.pdf');
            },
          ),
        ],
      ),
      body: args.urlOrAsset.startsWith('assets/')
          ? SfPdfViewer.asset(args.urlOrAsset)
          : SfPdfViewer.network(args.urlOrAsset),
    );
  }
}
