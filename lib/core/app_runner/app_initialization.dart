import 'package:acrova/data/data_source/local/local_storage/base_local_storage.dart';
import 'package:acrova/data/data_source/local/secure_storage/base_secure_storage.dart';
import 'package:acrova/utils/constants/local_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../utils/helpers/system_ui_helper.dart';
import '../../utils/logging/app_logger.dart';
import '../../utils/observers/app_bloc_observer.dart';
import '../di/dependency_injector.dart';

class AppInitialization {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await dotenv.load();
      await Future.wait([
        DependencyInjector().injectModules(),
        _setPreferredOrientation(),
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky),
      ]);

      await Firebase.initializeApp();
      await _checkAndClearSecureStorage();
      Bloc.observer = AppBlocObserver();
      SystemUIHelper.configureSystemUIOverlayStyle();
    } catch (error) {
      AppLogger.instance.logError(
        'Failed To Initialize Firebase',
        error: error,
      );
    }
    FlutterError.onError = AppInitialization._handleFlutterError;
  }

  static Future<void> _setPreferredOrientation() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  static Future<void> _checkAndClearSecureStorage() async {
    try {
      final secureStorage = serviceLocatorInstance.get<BaseSecureStorage>();
      final localStorage = serviceLocatorInstance.get<BaseLocalStorage>();

      final bool isFirstRun =
          bool.tryParse(
            localStorage.read(LocalConstants.isFirstRun).toString(),
          ) ??
          true;

      if (!isFirstRun) {
        AppLogger.instance.logDebug(
          'Not first run, proceeding normally without clearing data...',
        );
        return;
      }

      AppLogger.instance.logDebug(
        'First run detected! Clearing FlutterSecureStorage...',
      );

      await Future.wait([secureStorage.clear(), localStorage.clear()]);

      await localStorage.write(LocalConstants.isFirstRun, false);

      AppLogger.instance.logDebug(
        'Secure storage cleared and flag set to false.',
      );
    } catch (e, s) {
      AppLogger.instance.logError(
        'Failed to check and clear secure storage',
        error: e,
        stackTrace: s,
      );
    }
  }

  static void _handleFlutterError(final FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
      logInitializationError(
        details.exception,
        details.stack ?? StackTrace.current,
      );
    }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  static void logInitializationError(final Object e, final StackTrace s) {
    AppLogger.instance.logError('App error failed', error: e, stackTrace: s);
  }
}
