import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/utils/helpers/ui_helper.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherService {
  Future<void> callNumber(BuildContext context, String phoneNumber) async {
    await _launch(
      context,
      action: 'callNumber',
      uri: Uri(scheme: 'tel', path: _normalizePhoneNumber(phoneNumber)),
    );
  }

  Future<void> openWhatsApp(BuildContext context, String phoneNumber) async {
    final normalizedNumber = _normalizePhoneNumber(phoneNumber);

    await _launch(
      context,
      action: 'openWhatsApp',
      uri: Uri.parse('https://wa.me/$normalizedNumber'),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> sendEmail(
    BuildContext context,
    String emailAddress, {
    String? subject,
    String? body,
  }) async {
    await _launch(
      context,
      action: 'sendEmail',
      uri: Uri(
        scheme: 'mailto',
        path: emailAddress.trim(),
        queryParameters: {
          if (subject != null && subject.trim().isNotEmpty) 'subject': subject,
          if (body != null && body.trim().isNotEmpty) 'body': body,
        },
      ),
    );
  }

  Future<void> _launch(
    BuildContext context, {
    required String action,
    required Uri uri,
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      final canLaunch = await canLaunchUrl(uri);

      if (!canLaunch) {
        throw Exception('No application available to handle: $uri');
      }

      final launched = await launchUrl(uri, mode: mode);

      if (!launched) {
        throw Exception('Failed to launch: $uri');
      }
    } catch (e, s) {
      AppLogger.instance.logError('[$action]', error: e, stackTrace: s);

      CustomToastification.error(
        context: context,
        errorModel: AppErrorModel.fromException(e, stackTrace: s),
      ).showToast();
    }
  }

  String _normalizePhoneNumber(String phoneNumber) {
    return phoneNumber.trim().replaceAll(RegExp(r'[\s\-()]'), '');
  }
}
