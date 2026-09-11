import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/inputs/app_filled_field.dart';
import 'package:acrova/presentation/features/ui/revisions/request/cubit/revision_request_cubit.dart';
import 'package:acrova/presentation/features/ui/revisions/request/cubit/revision_request_state.dart';
import 'package:acrova/presentation/features/ui/revisions/request/widgets/revision_attach_box.dart';
import 'package:acrova/presentation/features/ui/revisions/request/widgets/revision_quota_card.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevisionRequestForm extends StatelessWidget {
  const RevisionRequestForm({
    required this.state,
    required this.detailsController,
    required this.deliverables,
    super.key,
  });

  final RevisionRequestState state;
  final TextEditingController detailsController;
  final List<String> deliverables;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;
    final cubit = context.read<RevisionRequestCubit>();
    final isPaid = !state.quota!.hasFreeRemaining;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$20,vertical: Resources.verticalDims.$16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.revisionRequestSubtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: Resources.fontSizes.$15,
                    color: Resources.colors.luxuryBodyMuted,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$24),
                RevisionQuotaCard(quota: state.quota!),

                SizedBox(height: Resources.verticalDims.$28),
                AppFilledField(
                  label: l10n.revisionDetailsLabel,
                  controller: detailsController,
                  hint: l10n.revisionDetailsHint,
                  error: state.detailsError,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  onChanged: cubit.updateDetails,
                ),
                SizedBox(height: Resources.verticalDims.$28),
                RevisionFieldLabel(text: l10n.revisionAttachLabel),
                SizedBox(height: Resources.verticalDims.$12),
                RevisionAttachBox(
                  attachmentPaths: state.attachmentPaths,
                  onAdd: cubit.addAttachment,
                  onRemove: cubit.removeAttachment,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$16,
            vertical: Resources.verticalDims.$24,
          ),
          decoration: BoxDecoration(
            color: Resources.colors.luxurySurface,
            border: Border(
              top: BorderSide(color: Resources.colors.luxuryBorder),
            ),
          ),
          child: SafeArea(
            top: false,
            child: AppPrimaryButton(
              label: isPaid ? l10n.revisionSubmitPaid : l10n.revisionSubmit,
              isLoading: state.isSubmitting,
              icon: Icon(
                isPaid ? Icons.payments_outlined : Icons.send_outlined,
                size: Resources.iconSizes.$18,
                color: Resources.colors.white,
              ),
              onPressed: () => cubit.submit(
                resolve: (code) => resolveRevisionRequestError(context, code),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String resolveRevisionRequestError(
  BuildContext context,
  RevisionRequestFieldError code,
) {
  final l10n = context.localization;
  return switch (code) {
    RevisionRequestFieldError.categoryRequired => l10n.revisionCategoryRequired,
    RevisionRequestFieldError.detailsRequired => l10n.revisionDetailsRequired,
  };
}

class RevisionFieldLabel extends StatelessWidget {
  const RevisionFieldLabel({
    required this.text,
    this.required = false,
    super.key,
  });

  final String text;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: Resources.fonts.manrope,
          fontSize: Resources.fontSizes.$14,
          fontWeight: Resources.fontWeights.medium,
          color: Resources.colors.luxuryNavy,
        ),
        children: [
          if (required)
            TextSpan(
              text: ' *',
              style: TextStyle(color: Resources.colors.luxuryGold),
            ),
        ],
      ),
    );
  }
}
