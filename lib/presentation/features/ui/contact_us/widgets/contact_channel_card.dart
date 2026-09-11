import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

/// Tappable alternative-contact card (call / email).
class ContactChannelCard extends StatelessWidget {
  const ContactChannelCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Resources.colors.luxurySurface,
      borderRadius: BorderRadius.circular(Resources.radius.$r8),
      child: InkWell(
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(Resources.horizontalDims.$20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Resources.radius.$r8),
            border: Border.all(color: Resources.colors.luxuryBorder),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: Resources.iconSizes.$28,
                color: Resources.colors.luxuryNavy,
              ),
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontSize: Resources.fontSizes.$16,
                  fontWeight: Resources.fontWeights.bold,
                  color: Resources.colors.luxuryNavy,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Resources.verticalDims.$2),
              Text(
                subtitle,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: Resources.fontSizes.$13,
                  color: Resources.colors.luxuryBodyMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
