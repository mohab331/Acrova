import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class EnterAcrovaButton extends StatelessWidget {
  const EnterAcrovaButton({
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Resources.verticalDims.$55,
      decoration: BoxDecoration(
        color: Resources.colors.luxuryNavy,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        boxShadow: AppShadows.cta,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Resources.radius.$r2),
          onTap: isLoading ? null : onPressed,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: Resources.squareDims.$20,
                    height: Resources.squareDims.$20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Resources.colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.localization.profileSetupEnterAcrova,
                        style: TextStyle(
                          fontFamily: Resources.fonts.manrope,
                          fontSize: Resources.fontSizes.$12,
                          fontWeight: Resources.fontWeights.bold,
                          letterSpacing: Resources.letterSpacing.$1_4,
                          color: Resources.colors.white,
                        ),
                      ),
                      SizedBox(width: Resources.horizontalDims.$8),
                      Icon(
                        Icons.arrow_forward,
                        size: Resources.iconSizes.$18,
                        color: Resources.colors.white,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
