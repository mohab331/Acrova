import 'dart:async';

import 'package:acrova/data/models/request/fcm_notification/fcm_notification_request_model.dart';
import 'package:acrova/domain/repository/notifications/base_fcm_token_repo.dart';
import 'package:acrova/utils/constants/secure_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../utils/helpers/result.dart';
import '../../../utils/helpers/safe_async_call.dart';
import '../../../utils/logging/app_logger.dart';
import '../../data_source/base/base_auth_data_source.dart';
import '../../data_source/local/secure_storage/base_secure_storage.dart';
import '../../data_source/remote/network/models/network_response.dart';

class FcmTokenRepoImpl implements BaseFCMTokenRepo {
  FcmTokenRepoImpl({
    required BaseSecureStorage secureStorage,
    required BaseAuthDataSource authDataSource,
  }) : _fm = FirebaseMessaging.instance,
       _authDataSource = authDataSource,
       _secureStorage = secureStorage;

  final FirebaseMessaging _fm;
  final BaseSecureStorage _secureStorage;
  final BaseAuthDataSource _authDataSource;
  StreamSubscription<String>? _refreshSub;

  @override
  Future<Result<void>> init() => safeAsyncCall(() async {
    await requestPermission();
    await sendCurrentTokenIfNeeded();
    await _refreshSub?.cancel();
    _refreshSub = _fm.onTokenRefresh.listen((newToken) async {
      AppLogger.instance.logInfo('FCM Token: $newToken');
      final authToken = await _secureStorage.read(SecureConstants.accessToken);
      if ((authToken?.isEmpty ?? true)) return;
      await _sendTokenIfChanged(newToken);
    });
  });

  @override
  Future<void> dispose() async {
    await _refreshSub?.cancel();
  }

  @override
  Future<Result<void>> sendCurrentTokenIfNeeded() => safeAsyncCall(() async {
    final auth = await _secureStorage.read(SecureConstants.accessToken);
    if (auth?.isEmpty ?? true) return;
    final fcmToken = await _fm.getToken();
    if (fcmToken?.isEmpty ?? true) return;
    await _sendTokenIfChanged(fcmToken!);
  });

  Future<Result<void>> _sendTokenIfChanged(String token) =>
      safeAsyncCall(() async {
        final last = await _secureStorage.read(SecureConstants.fcmToken);
        if (last == token) return;
        await updateToken(fcmRequestModel: FCMRequestModel(fcmToken: token));
        await _secureStorage.write(SecureConstants.fcmToken, token);
      });

  @override
  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      
    );
  }

  @override
  Future<Result<NetworkResponse<void>>> updateToken({
    required FCMRequestModel fcmRequestModel,
  }) async {
    return const Success(NetworkResponse(isSuccess: true, data: null));
  }

  @override
  Future<Result<String?>> getFCMToken() => safeAsyncCall(() async {
    final fcmToken = await _fm.getToken();
    await _secureStorage.write(SecureConstants.fcmToken, fcmToken);
    return fcmToken;
  });
}
