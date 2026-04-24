class ApiConstants {
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 35);
  static final Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static const String endpointRequiresToken =
      'endpoint_requires_authentication';
  static const String authHeader = 'Authorization';

  static const String languageHeader = 'Accept-language';

  static const String retryAfterRefreshHeader = 'retrying_after_refresh_token';
}
