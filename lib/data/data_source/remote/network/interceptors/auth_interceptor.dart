import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/nav_keys.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/helpers/result.dart';
import '../../constants/api_constants.dart';

/// A Dio interceptor for handling authentication with refresh tokens.
///
/// This interceptor automatically refreshes the access token when a 401 error is received
/// and handles cases where multiple requests fail at once using a queue.
/// If the refresh token itself becomes invalid, it clears the tokens
/// and navigates the user to the login screen.
class AuthenticationInterceptor extends Interceptor {
  /// Creates an [AuthenticationInterceptor].
  ///
  /// The [_dio] instance is used for retrying requests and making the refresh
  /// token call. [authRepo] and [userRepo] are injected for handling
  /// token management and user data, respectively.

  AuthenticationInterceptor(this._dio, {required BaseAuthRepo authRepo})
    : _authRepo = authRepo;
  final BaseAuthRepo _authRepo;

  final Dio _dio;

  /// A flag to prevent multiple token refresh requests simultaneously.
  bool _isRefreshing = false;

  /// A queue to hold requests that receive a 401 while a refresh is in progress.
  final _requestsToRetry =
      <({RequestOptions options, ErrorInterceptorHandler handler})>[];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    bool endpointRequiresAuthentication = false;
    if (options.extra.containsKey(ApiConstants.endpointRequiresToken)) {
      endpointRequiresAuthentication =
          options.extra[ApiConstants.endpointRequiresToken] ?? false;
    }

    if (endpointRequiresAuthentication) {
      final tokenResult = await _authRepo.getAccessToken();
      tokenResult.when(
        success: (data) => options.headers[ApiConstants.authHeader] = '$data',
        failure: (error) {
          handler.reject(DioException(requestOptions: options));
        },
      );
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final bool endpointRequiresAuthentication =
        err.response?.requestOptions.extra[ApiConstants
            .endpointRequiresToken] ??
        false;
    final bool retryingAfterRefreshToken =
        err.response?.requestOptions.extra[ApiConstants
            .retryAfterRefreshHeader] ??
        false;

    // Handle non-401 errors, or a 401 on an un-authenticated endpoint, or a retry request's failure.
    if ((err.response?.statusCode != 401) ||
        !endpointRequiresAuthentication ||
        retryingAfterRefreshToken) {
      return super.onError(err, handler);
    }

    // If a refresh is already in progress, queue this request and return.
    if (_isRefreshing) {
      _requestsToRetry.add((options: err.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;

    String? refreshToken;
    // Read the refresh token and attempt to get new tokens.
    final refreshTokenResult = await _getRefreshToken();
    refreshTokenResult.when(
      success: (data) => refreshToken = data,
      failure: (error) => refreshToken = null,
    );

    if (refreshToken?.isEmpty ?? true) {
      _isRefreshing = false;
      await _logoutAndRedirect();
      return super.onError(err, handler);
    }

    (String?, String?)? newTokens;
    try {
      newTokens = await _refreshToken(refreshToken ?? '');
    } on DioException {
      // Refresh token request itself failed (e.g., server down)
      _isRefreshing = false;
      await _logoutAndRedirect();
      return super.onError(err, handler);
    }

    if (newTokens.$1 == null || newTokens.$2 == null) {
      // Refresh token gave a 401, indicating it's invalid.
      _isRefreshing = false;
      await _logoutAndRedirect();
      return super.onError(err, handler);
    }
    // Save the new tokens.
    await _saveTokens(newTokens as (String, String));
    // Retry the original request that triggered the 401.
    try {
      final Response retryResponse = await _retryRequest(err.response!);
      handler.resolve(retryResponse);
    } on DioException catch (dioException) {
      super.onError(dioException, handler);
    } catch (e) {
      super.onError(err, handler);
    }

    for (var request in _requestsToRetry) {
      try {
        final Response retryResponse = await _dio.fetch(request.options);
        request.handler.resolve(retryResponse);
      } on DioException catch (dioException) {
        request.handler.next(dioException);
      } catch (e) {
        request.handler.next(
          DioException(requestOptions: request.options, error: e),
        );
      }
    }
    _requestsToRetry.clear();
    _isRefreshing = false;
  }

  // Reads the refresh token from secure storage.
  Future<Result<String?>> _getRefreshToken() => _authRepo.getRefreshToken();

  // Saves new access and refresh tokens to secure storage.
  Future<void> _saveTokens((String, String) newTokens) async {
    /// TODO: to be implemented
  }

  // Clears tokens and navigates to the login screen.
  Future<void> _logoutAndRedirect() async {
    await _authRepo.clearUserData();

    // Check if the router is currently on the login screen.
    final goRouterState = GoRouter.of(rootNavigatorKey.currentContext!).state;
    final isCurrentlyOnLoginPage =
        goRouterState.matchedLocation == AppRouteEnum.authPage.path;

    // Only navigate if we're not already on the login page.
    if (!isCurrentlyOnLoginPage) {
      // Navigate to the login page and remove all other routes.
      // Use goNamed() for named routes.
      GoRouter.of(
        rootNavigatorKey.currentContext!,
      ).goNamed(AppRouteEnum.authPage.name);
    }
  }

  // Makes a request to refresh the token.
  Future<(String?, String?)> _refreshToken(String refreshToken) async {
    /// TODO: to be implemented
    /* try {
      final refreshTokenResponse = await _authRepo.reAuth(
        reAuthRequestModel: ReAuthRequestModel(refreshToken: refreshToken),
      );
      return refreshTokenResponse.when(
        success: (data) {
          if (data.data?.token?.isEmpty ?? true) {
            return (null, null);
          }
          return (data.data?.token, data.data?.refreshToken);
        },
        failure: (error) {
          return (null, null);
        },
      );
    } catch (e) {
      return (null, null);
    }*/
    return (null, null);
  }

  // Retries a failed request with the new access token.
  Future<Response<dynamic>> _retryRequest(Response<dynamic> response) {
    return _dio.request(
      response.requestOptions.path,
      queryParameters: response.requestOptions.queryParameters,
      options: Options(
        headers: response.requestOptions.headers..remove('content-length'),
        extra: response.requestOptions.extra
          ..addAll({ApiConstants.retryAfterRefreshHeader: true}),
        contentType: Headers.jsonContentType,
        method: response.requestOptions.method,
      ),
      data: response.requestOptions.data,
    );
  }
}
