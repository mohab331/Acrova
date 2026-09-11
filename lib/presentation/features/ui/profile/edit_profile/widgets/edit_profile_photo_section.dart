import 'dart:io';

import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class EditProfilePhotoSection extends StatelessWidget {
  const EditProfilePhotoSection({
    required this.onChangePhoto,
    this.avatarUrl,
    this.avatarPath,
    super.key,
  });

  final VoidCallback onChangePhoto;
  final String? avatarUrl;
  final String? avatarPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onChangePhoto,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: Resources.squareDims.$100,
                height: Resources.squareDims.$100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Resources.colors.luxuryGoldBorder),
                  boxShadow: AppShadows.card,
                ),
                clipBehavior: Clip.antiAlias,
                child: AvatarWidget(
                  avatarPath: avatarPath,
                  avatarUrl: avatarUrl,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(Resources.horizontalDims.$8),
                  decoration: BoxDecoration(
                    color: Resources.colors.luxurySurface,
                    shape: BoxShape.circle,
                    border: Border.all(color: Resources.colors.luxuryBorder),
                    boxShadow: AppShadows.card,
                  ),
                  child: Icon(
                    Icons.photo_camera_outlined,
                    size: Resources.iconSizes.$18,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Resources.verticalDims.$12),
        GestureDetector(
          onTap: onChangePhoto,
          child: Text(
            context.localization.editProfileChangePhoto.toUpperCase(),
            style: TextStyle(
              fontFamily: Resources.fonts.manrope,
              fontSize: Resources.fontSizes.$14,
              fontWeight: Resources.fontWeights.semiBold,
              letterSpacing: Resources.letterSpacing.$0_8,
              color: Resources.colors.luxuryGold,
            ),
          ),
        ),
      ],
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    required this.avatarPath,
    required this.avatarUrl,
    super.key,
  });

  final String? avatarPath;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarPath != null) {
      return Image.file(File(avatarPath!), fit: BoxFit.cover);
    }
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return AppCachedNetworkImage(imageUrl: avatarUrl!);
    }
    return Icon(
      Icons.person_outline,
      size: Resources.iconSizes.$48,
      color: Resources.colors.luxuryPlaceholder,
    );
  }
}
