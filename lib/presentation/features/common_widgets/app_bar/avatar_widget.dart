import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    required this.userName,
    this.avatarUrl,
    super.key,
  });

  final String? avatarUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: avatarUrl != null
          ? ClipOval(
              child: AppCachedNetworkImage(
                imageUrl: avatarUrl!,
                fit: BoxFit.cover,
              ),
            )
          : Center(
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'A',
                style: TextStyle(
                  fontFamily: Resources.fonts.manrope,
                  fontSize: Resources.fontSizes.$16,
                  fontWeight: Resources.fontWeights.bold,
                  color: Resources.colors.luxuryGoldLight,
                ),
              ),
            ),
    );
  }
}
