import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_secondary_button.dart';
import 'package:acrova/utils/helpers/download_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeliverablesStickyActions extends StatelessWidget {
  const DeliverablesStickyActions({super.key});

  @override
  Widget build(BuildContext context) {
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
              label: 'DOWNLOAD ALL FILES',
              onPressed: () {
                DownloadHelper.downloadAndShare(
                  'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', 
                  'All_Project_Files.zip'
                );
              },
            ),
            SizedBox(height: Resources.verticalDims.$16),
            AppSecondaryButton(
              label: 'REQUEST REVISION',
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
