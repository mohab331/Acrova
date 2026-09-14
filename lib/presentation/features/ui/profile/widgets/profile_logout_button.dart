import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _logout(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: Resources.colors.luxuryError,
          side: BorderSide(color: Resources.colors.luxuryError),
          padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Resources.radius.$r2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_outlined, size: Resources.iconSizes.$16),
            SizedBox(width: Resources.horizontalDims.$8),
            Text(
              context.localization.logout,
              style: TextStyle(
                fontSize: Resources.fontSizes.$14,
                fontWeight: Resources.fontWeights.semiBold,
                letterSpacing: Resources.letterSpacing.$0_4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    context.goTo(AppRouteEnum.welcomePage.name);
    await context.read<AuthCubit>().clearAuthData();
    await Future.delayed(const Duration(milliseconds: 500));
    if (!context.mounted) return;
    context.read<AuthCubit>().resetToInitial();
  }
}
