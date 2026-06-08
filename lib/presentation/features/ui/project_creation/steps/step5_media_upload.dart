import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Step 5 — Media upload.
///
/// Image picker integration is a native plugin dependency (image_picker).
/// Since the project may not have it yet, we use a mock picker that generates
/// fake path strings for demo purposes. The cubit stores them as strings
/// (paths or asset identifiers). Real integration replaces [_mockPickImage].
class Step5MediaUpload extends StatelessWidget {
  const Step5MediaUpload({super.key});

  static int _mockCounter = 0;

  void _mockPickImage(BuildContext context) {
    _mockCounter++;
    context.read<ProjectCreationCubit>().addMedia(
      'mock://land_photo_$_mockCounter.jpg',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCreationCubit, ProjectCreationState>(
      builder: (context, state) {
        final l10n = context.localization;

        return SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.mediaUploadTitle,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.semiBold,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.mediaUploadSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Resources.colors.luxuryBody,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$32),

              // Upload button
              GestureDetector(
                onTap: () => _mockPickImage(context),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: Resources.verticalDims.$22,
                  ),
                  decoration: BoxDecoration(
                    color: Resources.colors.luxuryInputBg,
                    borderRadius: BorderRadius.circular(Resources.radius.$r8),
                    border: Border.all(
                      color: Resources.colors.luxuryGoldBorder,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 40.sp,
                        color: Resources.colors.luxuryGoldLight,
                      ),
                      SizedBox(height: Resources.verticalDims.$10),
                      Text(
                        l10n.mediaUploadCta.toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: Resources.fontSizes.$12,
                              fontWeight: Resources.fontWeights.bold,
                              color: Resources.colors.luxuryGoldLight,
                            ),
                      ),
                      SizedBox(height: Resources.verticalDims.$4),
                      Text(
                        l10n.mediaUploadFormatNotice,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: Resources.fontSizes.$10,
                              color: Resources.colors.luxuryBodyMuted,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.mediaUploadOptional,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Resources.colors.luxuryWarning,
                ),
              ),

              if (state.mediaPaths.isNotEmpty) ...[
                SizedBox(height: Resources.verticalDims.$20),
                Text(
                  state.mediaPaths.length == 1
                      ? '1 ${l10n.mediaUploadPhotoCountSingular}'
                      : '${state.mediaPaths.length} ${l10n.mediaUploadPhotoCountPlural}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: Resources.fontSizes.$12,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryNavy,
                      ),
                ),
                SizedBox(height: Resources.verticalDims.$12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.mediaPaths.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: Resources.verticalDims.$8),
                  itemBuilder: (_, i) =>
                      _MediaItem(path: state.mediaPaths[i], index: i),
                ),
              ],

              SizedBox(height: Resources.verticalDims.$32),
            ],
          ),
        );
      },
    );
  }
}

class _MediaItem extends StatelessWidget {
  const _MediaItem({required this.path, required this.index});

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
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryNavy.withOpacity(0.08),
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
