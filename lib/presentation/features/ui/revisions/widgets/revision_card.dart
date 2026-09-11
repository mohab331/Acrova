import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/revisions/widgets/collaborator_avatars.dart';
import 'package:acrova/presentation/features/ui/revisions/widgets/revision_status_chip.dart';
import 'package:acrova/utils/enums/revision_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevisionCard extends StatelessWidget {
  const RevisionCard({required this.revision, required this.onTap, super.key});

  final RevisionModel? revision;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final date = DateFormat('MMM dd, yyyy').format(revision?.createdAt ?? DateTime.now());

    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      padding: EdgeInsets.all(Resources.horizontalDims.$20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    revision?.id ?? '',
                    style: TextStyle(
                      fontFamily: Resources.fonts.manrope,
                      fontSize: Resources.fontSizes.$14,
                      fontWeight: Resources.fontWeights.bold,
                      color: Resources.colors.luxuryNavy,
                    ),
                  ),
                  SizedBox(width: Resources.horizontalDims.$8),
                  RevisionStatusChip(status: revision?.status ?? RevisionStatus.completed),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: Resources.iconSizes.$14,
                    color: Resources.colors.luxuryBodyMuted,
                  ),
                  SizedBox(width: Resources.horizontalDims.$4),
                  Text(
                    date,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: Resources.fontSizes.$12,
                      color: Resources.colors.luxuryBodyMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Text(
            revision?.description ?? '',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: Resources.fontSizes.$14,
              color: Resources.colors.luxuryBody,
              height: Resources.lineHeights.$1_5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Resources.verticalDims.$16),
          Divider(height: 1, color: Resources.colors.luxuryBorder),
          SizedBox(height: Resources.verticalDims.$14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: CollaboratorAvatars(initials: revision?.collaborators ?? [])),
              const Spacer(),
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(
                      l10n.revisionViewDetail,
                      style: TextStyle(
                        fontFamily: Resources.fonts.manrope,
                        fontSize: Resources.fontSizes.$14,
                        fontWeight: Resources.fontWeights.semiBold,
                        color: Resources.colors.luxuryGold,
                      ),
                    ),
                    SizedBox(width: Resources.horizontalDims.$4),
                    Icon(
                      Icons.arrow_forward,
                      size: Resources.iconSizes.$16,
                      color: Resources.colors.luxuryGold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
