import 'dart:io';

import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/constants/app_constants.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/logging/app_logger.dart';
import '../../../cubit/localization/localization_cubit.dart';
import 'cubit/splash_cubit.dart';
import 'cubit/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.colors.primary,
      body: BlocListener<SplashCubit, SplashState>(
        listener: _handleSplashStateListener,
        child: const SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center),
        ),
      ),
    );
  }

  void _handleSplashStateListener(
    BuildContext context,
    SplashState state,
  ) async {
    if (state.isLoading) return;
    if (state.hasError) _onError(context, state);
    await Future.delayed(const Duration(seconds: 1));
    if (!context.mounted) return;
    _settingAppLanguage(state, context);

    if (state.forceUpdateRequired) {
      await _showForceUpdateDialog(context);
      return;
    }

    if (!context.mounted) return;
    if ((state.userToken?.isNotEmpty ?? false)) {
      context.goTo(AppRouteEnum.homePage.name);
    } else {
      context.goTo(AppRouteEnum.welcomePage.name);
    }
  }

  Future<void> _showForceUpdateDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final localization = context.localization;
        final textTheme = Theme.of(context).textTheme;

        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$24,
          ),
          backgroundColor: Colors.transparent,
          child: SizedBox(),
        );
      },
    );
  }

  Future<void> _onUpdatePressed(BuildContext context) async {
    final storeUrl = Platform.isIOS
        ? AppConstants.iosStoreUrl
        : AppConstants.androidStoreUrl;
    try {
      final uri = Uri.tryParse(storeUrl);
      if (uri == null || !(await canLaunchUrl(uri))) {
        if (!context.mounted) return;
        _showUpdateLaunchError(context);
        return;
      }
      final launchedExternal = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (launchedExternal) return;

      final launchedFallback = await launchUrl(uri);
      if (launchedFallback) return;
    } catch (error, stackTrace) {
      AppLogger.instance.logError(
        'Failed to open store url: $storeUrl',
        error: error,
        stackTrace: stackTrace,
      );
    }
    if (!context.mounted) return;
    _showUpdateLaunchError(context);
  }

  void _showUpdateLaunchError(BuildContext context) {
    final localization = context.localization;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(localization.forceUpdateOpenStoreFailed),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _settingAppLanguage(SplashState state, BuildContext context) {
    if (state.language?.isNotEmpty ?? false) {
      context.read<LocalizationCubit>().updateLocale(Locale(state.language!));
    }
  }

  void _onError(BuildContext context, SplashState state) {
    AppLogger.instance.logError(
      state.error?.message ?? 'Unknown Error',
      error: state.error,
    );
  }
}
