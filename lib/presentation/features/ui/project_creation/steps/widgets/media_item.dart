import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaItem extends StatelessWidget {
  const MediaItem({required this.path, required this.index, super.key});

  final String path;
  final int index;

  @override
  Widget build(BuildContext context) {
    final filename = path.split('/').last;
    final l10n = context.localization;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$12,
        vertical: Resources.verticalDims.$12,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            width: Resources.squareDims.$40,
            height: Resources.squareDims.$40,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryNavy.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(Resources.radius.$r4),
            ),
            child: Icon(
              Icons.image_outlined,
              size: Resources.iconSizes.$20,
              color: Resources.colors.luxuryNavy,
            ),
          ),
          SizedBox(width: Resources.horizontalDims.$12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filename,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: Resources.fontSizes.$12,
                        fontWeight: Resources.fontWeights.semiBold,
                        color: Resources.colors.luxuryInk,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${l10n.mediaUploadPhotoLabel} ${index + 1}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: Resources.fontSizes.$10,
                        color: Resources.colors.luxuryBodyMuted,
                      ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.read<ProjectCreationCubit>().removeMedia(path),
            child: Icon(
              Icons.close,
              size: Resources.iconSizes.$18,
              color: Resources.colors.luxuryBodyMuted,
            ),
          ),
        ],
      ),
    );
  }
}
