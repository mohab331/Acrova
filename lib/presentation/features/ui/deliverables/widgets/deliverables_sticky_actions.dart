import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_secondary_button.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeliverablesStickyActions extends StatelessWidget {
  const DeliverablesStickyActions({this.allFilesZipUrl, super.key});

  final String? allFilesZipUrl;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Resources.colors.luxurySurface,
        padding: EdgeInsets.only(
          left: Resources.horizontalDims.$24,
          right: Resources.horizontalDims.$24,
          top: Resources.verticalDims.$16,
          bottom: MediaQuery.paddingOf(context).bottom + Resources.verticalDims.$24,
        ),
        child: Column(
          children: [
            AppPrimaryButton(
              label: loc.deliverablesDownloadAllFiles,
              onPressed: () {
                final url = allFilesZipUrl;
                if (url != null && url.isNotEmpty) {
                  DownloadHelper.downloadAndShare(url, 'All_Project_Files.zip');
                }
              },
            ),
            SizedBox(height: Resources.verticalDims.$16),
            AppSecondaryButton(
              label: loc.deliverablesRequestRevisionUpper,
              onPressed: () {
                context.push(AppRouteEnum.revisionRequestPage.path);
              },
            ),
          ],
        ),
      ),
    );
  }
}
