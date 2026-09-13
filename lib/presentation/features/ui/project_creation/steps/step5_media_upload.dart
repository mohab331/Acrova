import 'dart:async';

import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/project_creation/cubit/project_creation_cubit.dart';
import 'package:acrova/presentation/features/ui/project_creation/cubit/project_creation_state.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/media_item.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step5MediaUpload extends StatelessWidget {
  const Step5MediaUpload({super.key});

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
              GestureDetector(
                onTap: () => unawaited(
                  context.read<ProjectCreationCubit>().addMediaFromGallery(),
                ),
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
                      width: AppBorderWidths.$1_5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: Resources.iconSizes.$40,
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
                  l10n.mediaUploadPhotoCount(state.mediaPaths.length),
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
                      MediaItem(path: state.mediaPaths[i], index: i),
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
