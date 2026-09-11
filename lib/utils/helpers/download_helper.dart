import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DownloadHelper {
  DownloadHelper._();

  /// Downloads a file from a URL (or loads an asset) and presents the native share sheet.
  /// 
  /// The [urlOrAsset] can be a network URL or a local asset path (e.g. 'assets/images/img1.jpg').
  /// The [fileName] is the suggested name of the file when saving.
  static Future<void> downloadAndShare(String urlOrAsset, String fileName) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final File tempFile = File('${tempDir.path}/$fileName');

      if (urlOrAsset.startsWith('assets/')) {
        // Handle mock asset files
        final byteData = await rootBundle.load(urlOrAsset);
        await tempFile.writeAsBytes(byteData.buffer.asUint8List());
      } else {
        // Handle network files
        final dio = Dio();
        await dio.download(urlOrAsset, tempFile.path);
      }

      // Present the share sheet
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(tempFile.path)],
          text: 'Sharing $fileName',
        ),
      );
    } catch (e) {
      // In a production app, we would log this to Crashlytics and show a Toastification error.
      rethrow;
    }
  }
}
