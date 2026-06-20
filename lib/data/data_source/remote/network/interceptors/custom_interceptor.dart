import 'package:acrova/core/error/error_codes_enum.dart';
import 'package:acrova/data/data_source/remote/network/error/api_error.dart';
import 'package:dio/dio.dart';
import '../../../../../utils/logging/app_logger.dart';
import 'package:acrova/utils/constants/local_constants.dart';
import '../../../local/local_storage/base_local_storage.dart';
import '../../constants/api_constants.dart';

class CustomInterceptor extends Interceptor {
  const CustomInterceptor({required this.localStorage});

  final BaseLocalStorage localStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiConstants.languageHeader] = _getSavedLanguage();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final jsonResponse = response.data;
    final bool containsValueKey =
        jsonResponse.containsKey('value') &&
        jsonResponse['value'] is Map<String, dynamic>;
    if (jsonResponse == null || !containsValueKey) {
      final dioError = DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        message: response.statusMessage,
        stackTrace: StackTrace.current,
      );
      return handler.reject(dioError);
    } else {
      final responseValueMap = Map<String, dynamic>.from(
        jsonResponse['value'] as Map<String, dynamic>,
      );
      final code = responseValueMap['code'] is int
          ? responseValueMap['code'] as int
          : null;
      if (code != 0) {
        final message = (responseValueMap['message'] as String?);

        final dioError = DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: ApiError(code: ErrorCodesEnum.unknown, message: message),
        );
        return handler.reject(dioError);
      }
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is ApiError) {
      return handler.next(err);
    } else if (err.response?.data != null &&
        err.response?.data['value'] != null) {
      handler.next(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: ApiError.fromJson(err.response?.data),
        ),
      );
    } else {
      handler.next(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: ApiError.fromDioException(err),
        ),
      );
    }
  }

  String _getSavedLanguage() {
    try {
      return localStorage.read(LocalConstants.languageCode)?.toString() ?? 'en';
    } on Exception catch (e) {
      AppLogger.instance.logError(
        'Error Getting Saved Local in Interceptor: $e',
      );
      return 'en';
    }
  }
}
