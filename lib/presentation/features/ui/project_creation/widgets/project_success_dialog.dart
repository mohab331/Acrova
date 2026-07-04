import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class ProjectSuccessDialog extends StatelessWidget {
  const ProjectSuccessDialog({
    required this.projectId,
    required this.onDone,
    super.key,
  });

  final String projectId;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Resources.radius.$r16),
      ),
      child: Padding(
        padding: EdgeInsets.all(Resources.horizontalDims.$24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: Resources.verticalDims.$8),
            Container(
              width: Resources.squareDims.$64,
              height: Resources.squareDims.$64,
              decoration: BoxDecoration(
                color: Resources.colors.luxurySuccess.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: Resources.iconSizes.$36,
                color: Resources.colors.luxurySuccess,
              ),
            ),
            SizedBox(height: Resources.verticalDims.$20),
            Text(
              context.localization.projectCreationSuccessTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Resources.colors.luxuryNavy,
                    fontWeight: Resources.fontWeights.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Resources.verticalDims.$8),
            Text(
              context.localization.projectCreationSuccessSubtitle(projectId),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Resources.colors.luxuryBody,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Resources.verticalDims.$28),
            AppPrimaryButton(
              label: context.localization.projectCreationSuccessCta,
              onPressed: onDone,
            ),
            SizedBox(height: Resources.verticalDims.$8),
          ],
        ),
      ),
    );
  }
}
