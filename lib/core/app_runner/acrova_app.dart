import 'package:acrova/presentation/app/navigation/app_router.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/localization/localization_cubit.dart';
import 'package:acrova/presentation/features/ui/splash/splash/cubit/splash_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../../core/di/dependency_injector.dart';
import '../../utils/constants/app_constants.dart';

class AcrovaApp extends StatelessWidget {
  const AcrovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocatorInstance<LocalizationCubit>(),
        ),
        BlocProvider(create: (context) => serviceLocatorInstance<AuthCubit>()),
        BlocProvider(
          create: (context) =>
              serviceLocatorInstance<SplashCubit>()
                ..init(defaultLocale: LocalizationCubit.initialLocale),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(
          Resources.dimens.designWidth,
          Resources.dimens.designHeight,
        ),
        minTextAdapt: true,
        builder: (final context, final child) {
          return ToastificationWrapper(
            child: MaterialApp.router(
              routerConfig: AppRouter.router,
              title: AppConstants.appName,
              locale: context.watch<LocalizationCubit>().state,
              localizationsDelegates: context
                  .read<LocalizationCubit>()
                  .localizationDelegates,
              supportedLocales: context
                  .read<LocalizationCubit>()
                  .supportedLocales,
              builder: (final context, final child) {
                final locale = Localizations.localeOf(context);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                    boldText: false,
                  ),
                  child: SafeArea(
                    child: Theme(
                      data: Resources.theme.lightTheme(locale),
                      child: child ?? const SizedBox.shrink(),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
