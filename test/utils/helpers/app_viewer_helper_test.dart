import 'package:acrova/utils/helpers/app_viewer_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppViewerHelper Tests', () {
    test('isPdf detects pdf files correctly', () {
      expect(AppViewerHelper.isPdf('https://example.com/document.pdf'), isTrue);
      expect(AppViewerHelper.isPdf('assets/documents/terms.PDF'), isTrue);
      expect(AppViewerHelper.isPdf('https://example.com/file.pdf?version=1'), isTrue);
      expect(AppViewerHelper.isPdf('https://example.com/terms.html'), isFalse);
      expect(AppViewerHelper.isPdf('https://example.com/terms'), isFalse);
      expect(AppViewerHelper.isPdf(''), isFalse);
    });

    test('isImage detects image extensions correctly', () {
      expect(AppViewerHelper.isImage('https://example.com/photo.png'), isTrue);
      expect(AppViewerHelper.isImage('https://example.com/photo.jpg'), isTrue);
      expect(AppViewerHelper.isImage('https://example.com/photo.jpeg'), isTrue);
      expect(AppViewerHelper.isImage('https://example.com/photo.webp'), isTrue);
      expect(AppViewerHelper.isImage('https://example.com/doc.pdf'), isFalse);
    });
  });
}
