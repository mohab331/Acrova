import 'package:acrova/core/di/injectors/injector_holder.dart';
import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/remote/constants/api_constants.dart';
import 'package:acrova/data/data_source/remote/network/api_client.dart';
import 'package:acrova/data/data_source/remote/network/interceptors/auth_interceptor.dart';
import 'package:acrova/data/data_source/remote/network/interceptors/custom_interceptor.dart';
import 'package:acrova/data/data_source/remote/network/network_info/network_info.dart';
import 'package:acrova/domain/repository/auth/base_auth_repo.dart';
import 'package:acrova/presentation/app/navigation/nav_keys.dart';
import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final GetIt serviceLocatorInstance = GetIt.instance;

class DependencyInjector {
  DependencyInjector() : super();

  Future<void> injectModules() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (!serviceLocatorInstance.isRegistered<Dio>()) {
      serviceLocatorInstance.registerLazySingleton<Dio>(_dioFactory);
    }

    if (!serviceLocatorInstance.isRegistered<NetworkInfo>()) {
      serviceLocatorInstance.registerLazySingleton<NetworkInfo>(
        NetworkInfoImpl.new,
      );
    }

    if (!serviceLocatorInstance.isRegistered<ApiClient>()) {
      serviceLocatorInstance.registerLazySingleton<ApiClient>(
        () => ApiClient(
          serviceLocatorInstance<Dio>(),
          networkInfo: serviceLocatorInstance<NetworkInfo>(),
        ),
      );
    }

    if (!serviceLocatorInstance.isRegistered<FirebaseDatabase>()) {
      serviceLocatorInstance.registerLazySingleton<FirebaseDatabase>(
        () => FirebaseDatabase.instance,
      );
    }

    if (!serviceLocatorInstance.isRegistered<Alice>()) {
      serviceLocatorInstance.registerLazySingleton<Alice>(
        () => Alice(
          configuration: AliceConfiguration(
            showNotification: false,
            directionality: TextDirection.ltr,
            navigatorKey: rootNavigatorKey,
          ),
        ),
      );
    }

    /// Injects all modules in app
    InjectorHolder.injectAllApplicationModules();

    /// Ensure all async regs are done before use
    await serviceLocatorInstance.allReady();

    final interceptors = serviceLocatorInstance<Dio>().interceptors;
    final hasCustomInterceptor = interceptors.any(
      (e) => e is CustomInterceptor,
    );
    if (!hasCustomInterceptor) {
      interceptors.addAll([
        AuthenticationInterceptor(
          serviceLocatorInstance<Dio>(),
          authRepo: serviceLocatorInstance<BaseAuthRepo>(),
        ),
        CustomInterceptor(
          localStorage: serviceLocatorInstance<BaseLocalStorage>(),
        ),
        _getAliceInterceptor(),
        if (kDebugMode) PrettyDioLogger(),
      ]);
    }
  }

  AliceDioAdapter _getAliceInterceptor() {
    final alice = serviceLocatorInstance<Alice>();
    final adapter = AliceDioAdapter();
    alice.addAdapter(adapter);
    return adapter;
  }

  Dio _dioFactory() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? '',
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: ApiConstants.defaultHeaders,
      ),
    );

    return dio;
  }
}
