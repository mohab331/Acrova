import 'dart:async';

import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/welcome/welcome_page.dart';
import 'package:acrova/presentation/features/ui/splash/splash/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/dependency_injector.dart';
import 'app_route_enum.dart';
import 'nav_keys.dart';

class AppRouter {
  AppRouter._();

  static final _authRefresh = _GoRouterRefreshStream(
    serviceLocatorInstance<AuthCubit>().stream,
  );

  static final router = GoRouter(
    initialLocation: AppRouteEnum.splashPage.path,
    navigatorKey: rootNavigatorKey,
    errorBuilder: (context, state) => const SplashPage(),
    refreshListenable: Listenable.merge([_authRefresh]),
    routes: [
      GoRoute(
        path: AppRouteEnum.splashPage.path,
        name: AppRouteEnum.splashPage.name,
        builder: (_, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRouteEnum.welcomePage.path,
        name: AppRouteEnum.welcomePage.name,
        builder: (_, state) => const WelcomePage(),
      ),
    ],
  );
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _routesStreamer = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _routesStreamer;

  @override
  void dispose() {
    _routesStreamer.cancel();
    super.dispose();
  }
}
