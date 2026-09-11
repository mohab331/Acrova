import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/cards/app_card.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    required this.title,
    required this.items,
    super.key,
  });

  final String title;
  final List<ProfileMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Resources.fontSizes.$10,
            fontWeight: Resources.fontWeights.bold,
            letterSpacing: Resources.letterSpacing.$1_0,
            color: Resources.colors.luxuryBody,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$8),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isLast = index == items.length - 1;
              return Column(
                children: [
                  GestureDetector(
                    onTap: item.onTap,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Resources.horizontalDims.$16,
                        vertical: Resources.verticalDims.$16,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: Resources.iconSizes.$20,
                            color: Resources.colors.luxuryNavy,
                          ),
                          SizedBox(width: Resources.horizontalDims.$12),
                          Expanded(
                            child: Text(
                              item.label,
                              style: TextStyle(
                                fontSize: Resources.fontSizes.$14,
                                color: Resources.colors.luxuryInk,
                              ),
                            ),
                          ),
                          if (item.trailing != null) ...[
                            SizedBox(width: Resources.horizontalDims.$12),
                            item.trailing!,
                          ] else
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: Resources.iconSizes.$14,
                              color: Resources.colors.luxuryBorder,
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      color: Resources.colors.luxuryBorder,
                      indent: Resources.horizontalDims.$16,
                      endIndent: Resources.horizontalDims.$16,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
