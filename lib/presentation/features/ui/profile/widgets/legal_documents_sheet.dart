import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/domain/repository/config/base_app_config_repo.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/sheets/app_sheet_handle.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/app_viewer_helper.dart';
import 'package:flutter/material.dart';

class LegalDocumentsSheet extends StatelessWidget {
  const LegalDocumentsSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      barrierColor: Resources.colors.luxuryInk.withValues(alpha: 0.4),
      isScrollControlled: true,
      builder: (_) => const LegalDocumentsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final config = serviceLocatorInstance<BaseAppConfigRepo>().cachedConfig;
    final termsUrl = config?.termsAndConditionsUrl;
    final privacyUrl = config?.privacyPolicyUrl;
    final cookieUrl = config?.cookiePolicyUrl;

    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Resources.radius.$r16),
        ),
        boxShadow: AppShadows.sheet,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSheetHandle(),
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.termsAndPrivacy,
                style: context.textTheme.titleMedium?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.bold,
                  fontSize: Resources.fontSizes.$18,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$16),
              _DocumentRow(
                title: l10n.termsOfService,
                url: termsUrl,
                icon: Icons.description_outlined,
                onTap: () {
                  Navigator.pop(context);
                  AppViewerHelper.openDocumentOrUrl(
                    context,
                    urlOrAsset: termsUrl,
                    title: l10n.termsOfService,
                  );
                },
              ),
              Divider(height: 1, color: Resources.colors.luxuryBorder),
              _DocumentRow(
                title: l10n.privacyPolicy,
                url: privacyUrl,
                icon: Icons.privacy_tip_outlined,
                onTap: () {
                  Navigator.pop(context);
                  AppViewerHelper.openDocumentOrUrl(
                    context,
                    urlOrAsset: privacyUrl,
                    title: l10n.privacyPolicy,
                  );
                },
              ),
              if (cookieUrl != null && cookieUrl.isNotEmpty) ...[
                Divider(height: 1, color: Resources.colors.luxuryBorder),
                _DocumentRow(
                  title: 'Cookie Policy',
                  url: cookieUrl,
                  icon: Icons.cookie_outlined,
                  onTap: () {
                    Navigator.pop(context);
                    AppViewerHelper.openDocumentOrUrl(
                      context,
                      urlOrAsset: cookieUrl,
                      title: 'Cookie Policy',
                    );
                  },
                ),
              ],
              SizedBox(height: Resources.verticalDims.$24),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({
    required this.title,
    required this.url,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String? url;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isAvailable = url != null && url!.trim().isNotEmpty;
    final badgeText = isAvailable
        ? (AppViewerHelper.isPdf(url!) ? 'PDF' : 'WEB')
        : null;

    return InkWell(
      onTap: isAvailable ? onTap : null,
      borderRadius: BorderRadius.circular(Resources.radius.$r8),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Resources.verticalDims.$16,
          horizontal: Resources.horizontalDims.$8,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: Resources.iconSizes.$22,
              color: isAvailable
                  ? Resources.colors.luxuryNavy
                  : Resources.colors.luxuryBodyMuted,
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: isAvailable
                      ? Resources.colors.luxuryNavy
                      : Resources.colors.luxuryBodyMuted,
                  fontWeight: Resources.fontWeights.medium,
                ),
              ),
            ),
            if (badgeText != null) ...[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Resources.horizontalDims.$8,
                  vertical: Resources.verticalDims.$2,
                ),
                decoration: BoxDecoration(
                  color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Resources.radius.$r4),
                  border: Border.all(
                    color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  badgeText,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Resources.colors.luxuryGold,
                    fontSize: Resources.fontSizes.$10,
                    fontWeight: Resources.fontWeights.bold,
                  ),
                ),
              ),
              SizedBox(width: Resources.horizontalDims.$8),
            ],
            Icon(
              Icons.chevron_right,
              size: Resources.iconSizes.$20,
              color: isAvailable
                  ? Resources.colors.luxuryBodyMuted
                  : Resources.colors.luxuryInputBorder,
            ),
          ],
        ),
      ),
    );
  }
}
