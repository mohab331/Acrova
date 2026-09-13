import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DownloadHelper {
  DownloadHelper._();

  static Future<void> downloadAndShare(
    String urlOrAsset,
    String fileName, {
    Rect? sharePositionOrigin,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();

      final safeFileName = _sanitizeFileName(fileName);
      final tempFile = File('${tempDir.path}/$safeFileName');

      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      if (urlOrAsset.startsWith('assets/')) {
        final byteData = await rootBundle.load(urlOrAsset);

        await tempFile.writeAsBytes(
          byteData.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          ),
          flush: true,
        );
      } else {
        final dio = Dio();

        await dio.download(
          urlOrAsset,
          tempFile.path,
          options: Options(
            followRedirects: true,
            validateStatus: (status) {
              return status != null && status >= 200 && status < 300;
            },
          ),
        );
      }

      if (!await tempFile.exists()) {
        throw Exception('Failed to create downloaded file.');
      }

      await Share.shareXFiles(
        [XFile(tempFile.path, name: safeFileName)],
        sharePositionOrigin: Platform.isIOS
            ? (sharePositionOrigin ?? const Rect.fromLTWH(0, 0, 1, 1))
            : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  static String _sanitizeFileName(String fileName) {
    return fileName
        .split(RegExp(r'[/\\]'))
        .last
        .replaceAll(RegExp(r'[<>:"|?*]'), '_');
  }
}
