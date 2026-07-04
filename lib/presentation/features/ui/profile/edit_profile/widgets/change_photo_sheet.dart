import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/sheets/app_sheet_handle.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

enum ChangePhotoAction { camera, library, remove }

/// Bottom sheet for choosing a profile-photo source.
class ChangePhotoSheet extends StatelessWidget {
  const ChangePhotoSheet({super.key});

  /// Shows the sheet and resolves to the chosen [ChangePhotoAction] (or null).
  static Future<ChangePhotoAction?> show(BuildContext context) {
    return showModalBottomSheet<ChangePhotoAction>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Resources.colors.luxuryInk.withValues(alpha: 0.6),
      builder: (_) => const ChangePhotoSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Resources.radius.$r12),
        ),
        boxShadow: AppShadows.sheet,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppSheetHandle(),
            SizedBox(height: Resources.verticalDims.$8),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Resources.horizontalDims.$24,
              ),
              child: Column(
                children: [
                  _ActionRow(
                    icon: Icons.photo_camera_outlined,
                    label: l10n.changePhotoTake,
                    onTap: () =>
                        Navigator.of(context).pop(ChangePhotoAction.camera),
                  ),
                  SizedBox(height: Resources.verticalDims.$8),
                  _ActionRow(
                    icon: Icons.photo_library_outlined,
                    label: l10n.changePhotoLibrary,
                    onTap: () =>
                        Navigator.of(context).pop(ChangePhotoAction.library),
                  ),
                  SizedBox(height: Resources.verticalDims.$16),
                  _ActionRow(
                    icon: Icons.delete_outline,
                    label: l10n.changePhotoRemove,
                    destructive: true,
                    onTap: () =>
                        Navigator.of(context).pop(ChangePhotoAction.remove),
                  ),
                ],
              ),
            ),

            SizedBox(height: Resources.verticalDims.$32),
          ],
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final accent = destructive
        ? Resources.colors.luxuryError
        : Resources.colors.luxuryGold;
    final bg = destructive
        ? Resources.colors.luxuryError.withValues(alpha: 0.06)
        : Resources.colors.luxuryBackground;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(Resources.radius.$r2),
      child: InkWell(
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$16,
            vertical: Resources.verticalDims.$16,
          ),
          child: Row(
            children: [
              Icon(icon, color: accent, size: Resources.iconSizes.$22),
              SizedBox(width: Resources.horizontalDims.$16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: Resources.fonts.manrope,
                    fontSize: Resources.fontSizes.$16,
                    fontWeight: Resources.fontWeights.medium,
                    color: destructive
                        ? Resources.colors.luxuryError
                        : Resources.colors.luxuryNavy,
                  ),
                ),
              ),
              if (!destructive)
                Icon(
                  Icons.chevron_right,
                  color: Resources.colors.luxuryPlaceholder,
                  size: Resources.iconSizes.$20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
