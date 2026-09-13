import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    this.userName,
    this.avatarUrl,
    required this.onRetry,
    required this.isError,
    super.key,
  });

  final String? avatarUrl;
  final String? userName;

  final VoidCallback onRetry;

  final bool isError;

  @override
  Widget build(BuildContext context) {
    final displayName = userName?.trim() ?? '';
    return GestureDetector(
      onTap: isError ? onRetry : null,
      child: Container(
        width: Resources.squareDims.$42,
        height: Resources.squareDims.$42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Resources.colors.luxuryNavy,
          border: Border.all(
            color: Resources.colors.luxuryGoldBorder,
            width: AppBorderWidths.$1_5,
          ),
        ),
        child: isError
            ? const Icon(Icons.refresh_outlined, color: Colors.white)
            : (avatarUrl != null
                  ? ClipOval(child: AppCachedNetworkImage(imageUrl: avatarUrl!))
                  : Center(
                      child: displayName.isEmpty
                          ? Icon(
                              Icons.person_outline,
                              color: Resources.colors.luxuryGoldLight,
                              size: Resources.iconSizes.$20,
                            )
                          : Text(
                              displayName[0].toUpperCase(),
                              style: TextStyle(
                                fontFamily: Resources.fonts.manrope,
                                fontSize: Resources.fontSizes.$16,
                                fontWeight: Resources.fontWeights.bold,
                                color: Resources.colors.luxuryGoldLight,
                              ),
                            ),
                    )),
      ),
    );
  }
}
