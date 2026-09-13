import 'dart:io';

import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/helpers/ui_helper.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DownloadHelper {
  DownloadHelper._();

  static Future<void> downloadAndShare(
    BuildContext context,
    String urlOrAsset,
    String fileName, {
    Rect? sharePositionOrigin,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();

      final isAsset = urlOrAsset.startsWith('assets/');

      String? detectedExtension;
      String? serverFileName;

      if (isAsset) {
        detectedExtension = _getExtensionFromPath(urlOrAsset);
      } else {
        // First try to get information from the URL itself.
        detectedExtension = _getExtensionFromUrl(urlOrAsset);
      }

      if (!isAsset && detectedExtension == null) {
        // We need the response headers when the URL has no extension.
        final dio = Dio();

        final response = await dio.get<List<int>>(
          urlOrAsset,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            validateStatus: (status) {
              return status != null && status >= 200 && status < 300;
            },
          ),
        );

        serverFileName = _getFileNameFromContentDisposition(
          response.headers.value('content-disposition'),
        );

        detectedExtension ??= _getExtensionFromPath(serverFileName);

        detectedExtension ??= _extensionFromContentType(
          response.headers.value('content-type'),
        );

        final finalFileName = _buildFileName(
          fileName: fileName,
          serverFileName: serverFileName,
          extension: detectedExtension,
        );

        final safeFileName = _sanitizeFileName(finalFileName);
        final tempFile = File(p.join(tempDir.path, safeFileName));

        if (await tempFile.exists()) {
          await tempFile.delete();
        }

        await tempFile.writeAsBytes(response.data ?? <int>[], flush: true);

        await _shareDownloadedFile(
          context: context,
          file: tempFile,
          fileName: safeFileName,
          sharePositionOrigin: sharePositionOrigin,
        );

        return;
      }

      // Asset or URL already has a detectable extension.
      final finalFileName = _buildFileName(
        fileName: fileName,
        extension: detectedExtension,
      );

      final safeFileName = _sanitizeFileName(finalFileName);
      final tempFile = File(p.join(tempDir.path, safeFileName));

      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      if (isAsset) {
        final byteData = await rootBundle.load(urlOrAsset);

        await tempFile.writeAsBytes(
          byteData.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          ),
          flush: true,
        );
      } else {
        await Dio().download(
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

      await _shareDownloadedFile(
        context: context,
        file: tempFile,
        fileName: safeFileName,
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (e, s) {
      AppLogger.instance.logError(
        '[DownloadAndShare Error]',
        error: e,
        stackTrace: s,
      );

      CustomToastification.error(
        context: context,
        errorModel: AppErrorModel.fromException(e, stackTrace: s),
      ).showToast();
    }
  }

  static Future<void> _shareDownloadedFile({
    required BuildContext context,
    required File file,
    required String fileName,
    Rect? sharePositionOrigin,
  }) async {
    await CustomToastification.success(
      context: context,
      message: 'Downloaded Successfully',
    ).showToast();

    await Share.shareXFiles(
      [XFile(file.path, name: fileName)],
      sharePositionOrigin: Platform.isIOS
          ? (sharePositionOrigin ?? const Rect.fromLTWH(0, 0, 1, 1))
          : null,
    );
  }

  static String _buildFileName({
    required String fileName,
    String? serverFileName,
    String? extension,
  }) {
    // Prefer the user-provided filename.
    var result = fileName.trim();

    // If no filename was provided, use the server filename.
    if (result.isEmpty && serverFileName != null) {
      result = serverFileName;
    }

    // Last fallback.
    if (result.isEmpty) {
      result = 'download';
    }

    // If the supplied filename already has an extension,
    // don't add another one.
    if (p.extension(result).isNotEmpty) {
      return result;
    }

    if (extension != null && extension.isNotEmpty) {
      final normalizedExtension = extension.startsWith('.')
          ? extension
          : '.$extension';

      return '$result$normalizedExtension';
    }

    return result;
  }

  static String? _getExtensionFromUrl(String url) {
    try {
      final uri = Uri.parse(url);

      // Uri.path excludes query parameters.
      final extension = p.extension(uri.path);

      if (extension.isEmpty) {
        return null;
      }

      return extension.toLowerCase();
    } catch (_) {
      return null;
    }
  }

  static String? _getExtensionFromPath(String? path) {
    if (path == null || path.isEmpty) {
      return null;
    }

    final extension = p.extension(path);

    if (extension.isEmpty) {
      return null;
    }

    return extension.toLowerCase();
  }

  static String? _getFileNameFromContentDisposition(
    String? contentDisposition,
  ) {
    if (contentDisposition == null || contentDisposition.isEmpty) {
      return null;
    }

    // Handles:
    // attachment; filename="report.pdf"
    // attachment; filename=report.pdf
    // attachment; filename*=UTF-8''report%20final.pdf

    final encodedMatch = RegExp(
      r'''filename\*\s*=\s*(?:UTF-8'')?([^;]+)''',
      caseSensitive: false,
    ).firstMatch(contentDisposition);

    if (encodedMatch != null) {
      final value = encodedMatch.group(1)?.trim();

      if (value != null && value.isNotEmpty) {
        return Uri.decodeComponent(value.replaceAll('"', ''));
      }
    }

    final normalMatch = RegExp(
      r'''filename\s*=\s*"?([^";]+)"?''',
      caseSensitive: false,
    ).firstMatch(contentDisposition);

    if (normalMatch != null) {
      return normalMatch.group(1)?.trim();
    }

    return null;
  }

  static String? _extensionFromContentType(String? contentType) {
    if (contentType == null || contentType.isEmpty) {
      return null;
    }

    final mimeType = contentType.split(';').first.trim().toLowerCase();

    const mimeToExtension = <String, String>{
      // Documents
      'application/pdf': '.pdf',
      'application/rtf': '.rtf',
      'application/msword': '.doc',
      'application/vnd.ms-word': '.doc',
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
          '.docx',

      // Spreadsheets
      'application/vnd.ms-excel': '.xls',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
          '.xlsx',

      // Presentations
      'application/vnd.ms-powerpoint': '.ppt',
      'application/vnd.openxmlformats-officedocument.presentationml.presentation':
          '.pptx',

      // Archives
      'application/zip': '.zip',
      'application/x-rar-compressed': '.rar',
      'application/x-7z-compressed': '.7z',
      'application/gzip': '.gz',
      'application/x-tar': '.tar',

      // Data
      'application/json': '.json',
      'application/xml': '.xml',
      'text/xml': '.xml',
      'text/csv': '.csv',
      'text/plain': '.txt',

      // Images
      'image/jpeg': '.jpg',
      'image/jpg': '.jpg',
      'image/png': '.png',
      'image/gif': '.gif',
      'image/webp': '.webp',
      'image/svg+xml': '.svg',
      'image/bmp': '.bmp',
      'image/tiff': '.tiff',

      // Audio
      'audio/mpeg': '.mp3',
      'audio/wav': '.wav',
      'audio/ogg': '.ogg',
      'audio/mp4': '.m4a',

      // Video
      'video/mp4': '.mp4',
      'video/mpeg': '.mpeg',
      'video/webm': '.webm',
      'video/quicktime': '.mov',
    };

    return mimeToExtension[mimeType];
  }

  static String _sanitizeFileName(String fileName) {
    return fileName
        .split(RegExp(r'[/\\]'))
        .last
        .replaceAll(RegExp(r'[<>:"|?*]'), '_');
  }
}
