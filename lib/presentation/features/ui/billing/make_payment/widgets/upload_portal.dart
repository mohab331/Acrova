import 'dart:io';

import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/cubit/make_payment_cubit.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/cubit/make_payment_state.dart';
import 'package:acrova/presentation/features/ui/profile/edit_profile/widgets/change_photo_sheet.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadPortal extends StatelessWidget {
  const UploadPortal({req, required this.state});

  final MakePaymentState state;

  Future<void> _pickImage(
    BuildContext context, {
    required ImageSource source,
  }) async {
    final file = await context.read<MakePaymentCubit>().pickImage(source);
    if (file != null && context.mounted) {
      context.read<MakePaymentCubit>().setReceiptImage(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    if (state.receiptImage != null) {
      return Container(
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          boxShadow: AppShadows.card,
        ),
        padding: EdgeInsets.all(Resources.horizontalDims.$16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Resources.radius.$r4),
              child: Image.file(
                File(state.receiptImage!.path),
                width: Resources.squareDims.$80,
                height: Resources.squareDims.$80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.receiptImage!.name,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Resources.colors.luxuryNavy,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  FutureBuilder<int>(
                    future: state.receiptImage!.length(),
                    builder: (context, snapshot) {
                      final sizeStr = snapshot.hasData
                          ? '${(snapshot.data! / (1024 * 1024)).toStringAsFixed(1)} MB'
                          : '...';
                      return Text(
                        sizeStr,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Resources.colors.luxuryBody,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () =>
                  context.read<MakePaymentCubit>().removeReceiptImage(),
              style: IconButton.styleFrom(
                backgroundColor: Resources.colors.luxuryError.withValues(
                  alpha: 0.1,
                ),
                foregroundColor: Resources.colors.luxuryError,
              ),
              icon: Icon(Icons.close, size: Resources.iconSizes.$18),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () async {
        final result = await PickFromSheet.show(context, showRemove: false);
        _pickImage(
          context,
          source: result == ChangePhotoAction.camera
              ? ImageSource.camera
              : ImageSource.gallery,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Resources.colors.luxuryBorder),
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Resources.radius.$r8),
          boxShadow: AppShadows.card,
        ),
        padding: EdgeInsets.all(Resources.horizontalDims.$24),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$24),
          child: Column(
            children: [
              Container(
                width: Resources.squareDims.$64,
                height: Resources.squareDims.$64,
                decoration: BoxDecoration(
                  color: Resources.colors.luxurySurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.upload_rounded,
                  size: Resources.iconSizes.$32,
                  color: Resources.colors.luxuryNavy.withValues(alpha: 0.4),
                ),
              ),
              SizedBox(height: Resources.verticalDims.$16),
              Text(
                loc.makePaymentTapToUploadReceipt,
                style: context.textTheme.labelMedium?.copyWith(
                  color: Resources.colors.luxuryGoldLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
