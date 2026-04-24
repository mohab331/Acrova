import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(final BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      debugPrint('onCreate -- ${bloc.runtimeType}');
    }
  }

  @override
  void onChange(final BlocBase bloc, final Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      debugPrint('onChange -- ${bloc.runtimeType}, $change');
    }
  }

  @override
  void onError(final BlocBase bloc, final Object error, final StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      debugPrint('onError -- ${bloc.runtimeType}, $error');
    }
  }

  @override
  void onClose(final BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      debugPrint('onClose -- ${bloc.runtimeType}');
    }
  }
}
