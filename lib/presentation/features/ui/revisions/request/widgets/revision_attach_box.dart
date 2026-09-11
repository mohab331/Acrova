import 'dart:io';

import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class RevisionAttachBox extends StatelessWidget {
  const RevisionAttachBox({
    required this.attachmentPaths,
    required this.onAdd,
    required this.onRemove,
    super.key,
  });

  final List<String> attachmentPaths;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onAdd,
          child: DottedBorderBox(
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: Resources.iconSizes.$28,
                  color: Resources.colors.luxuryBodyMuted,
                ),
                SizedBox(height: Resources.verticalDims.$8),
                Text(
                  l10n.revisionAttachUpload,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: Resources.fontSizes.$14,
                    fontWeight: Resources.fontWeights.medium,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$4),
                Text(
                  l10n.revisionAttachHint,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: Resources.fontSizes.$12,
                    color: Resources.colors.luxuryBodyMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        if (attachmentPaths.isNotEmpty) ...[
          SizedBox(height: Resources.verticalDims.$12),
          Wrap(
            spacing: Resources.horizontalDims.$8,
            runSpacing: Resources.verticalDims.$8,
            children: attachmentPaths
                .map((p) => _Thumb(path: p, onRemove: () => onRemove(p)))
                .toList(),
          ),
        ],
      ],
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.path, required this.onRemove});

  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Resources.radius.$r4),
          child: Image.file(
            File(path),
            width: Resources.squareDims.$64,
            height: Resources.squareDims.$64,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: -Resources.verticalDims.$4,
          right: -Resources.horizontalDims.$4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.all(Resources.horizontalDims.$2),
              decoration: BoxDecoration(
                color: Resources.colors.luxuryError,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: Resources.iconSizes.$12,
                color: Resources.colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Dashed-border container used for the upload drop zone.
class DottedBorderBox extends StatelessWidget {
  const DottedBorderBox({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Resources.colors.luxuryBackground,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        border: Border.all(
          color: Resources.colors.luxuryInputBorder,
          width: AppBorderWidths.$1_5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Resources.verticalDims.$32,
          horizontal: Resources.horizontalDims.$16,
        ),
        child: Center(child: child),
      ),
    );
  }
}
