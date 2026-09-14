import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Centralized guard utility for gating actions that require a complete profile.
abstract final class ProfileCompletionGuard {
  /// Checks if the current user has a fully completed profile.
  static bool isComplete(BuildContext context) {
    return context.read<AuthCubit>().state.isProfileCompleted;
  }

  /// Ensures the user has a completed profile before proceeding with an action.
  ///
  /// If the user is fully authenticated, returns `true` immediately.
  /// If the user is a visitor, pushes the Profile Setup page on top of the
  /// current navigation stack (preserving underlying state, such as form inputs)
  /// and waits for completion.
  ///
  /// Returns `true` if the profile was successfully completed, `false` otherwise.
  static Future<bool> ensureComplete(BuildContext context) async {
    final authState = context.read<AuthCubit>().state;
    if (authState.isProfileCompleted) {
      return true;
    }

    if (authState.isGuest) {
      final authenticated = await context.push<bool>(
        AppRouteEnum.phonePage.name,
        extra: const AuthFlowArgs(returnToCaller: true),
      );
      if (!context.mounted) return false;
      if (authenticated == true &&
          context.read<AuthCubit>().state.isProfileCompleted) {
        return true;
      }
    }

    final result = await context.push<bool>(
      AppRouteEnum.editProfilePage.name,
      extra: EditProfileArgs(
        title: context.localization.completeProfile,
        profile: authState.userModel,
      ),
    );

    if (!context.mounted) return false;

    // Check if the profile is now complete (either returned true or state updated)
    return result == true ||
        context.read<AuthCubit>().state.isProfileCompleted;
  }
}
