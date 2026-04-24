import '../../../data/data_source/remote/network/models/network_response.dart';
import '../../../data/models/request/fcm_notification/fcm_notification_request_model.dart';
import '../../../utils/helpers/result.dart';

/// Base contract for managing FCM token registration/lifecycle.
///
/// Responsibilities:
/// - Request push permissions when applicable.
/// - Send the current FCM token to backend if user is authenticated.
/// - Listen to token refresh and update backend accordingly.
/// - Avoid duplicate uploads (persist last-synced token).
/// - Provide lifecycle hooks (init/dispose).
abstract class BaseFCMTokenRepo {
  /// Initializes permission + token sync + token refresh listener.
  /// - Requests permission (iOS/Android 13+).
  /// - Sends current token if user is authenticated.
  /// - Subscribes to token refresh and updates backend on change.
  Future<Result<void>> init();

  /// Releases resources (e.g., cancels onTokenRefresh subscription).
  Future<void> dispose();

  /// Requests notification permission. Safe to call on all platforms;
  /// it will no-op where not needed.
  Future<void> requestPermission();

  /// Sends the current token once if:
  /// - the user is authenticated, and
  /// - a token exists, and
  /// - it's different from the last synced token.
  Future<Result<void>> sendCurrentTokenIfNeeded();

  Future<Result<String?>> getFCMToken();
}
