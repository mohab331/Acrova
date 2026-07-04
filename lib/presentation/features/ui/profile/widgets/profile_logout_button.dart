import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({required this.onLogout, super.key});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onLogout,
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
}
