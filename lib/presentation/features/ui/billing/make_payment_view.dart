import 'dart:io';

import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';

import 'package:acrova/presentation/features/cubit/billing/make_payment_cubit.dart';
import 'package:acrova/presentation/features/cubit/billing/make_payment_state.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/navigation/app_route_enum.dart';

class MakePaymentView extends StatelessWidget {
  const MakePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MakePaymentCubit(),
      child: const _MakePaymentContent(),
    );
  }
}

class _MakePaymentContent extends StatelessWidget {
  const _MakePaymentContent();

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null && context.mounted) {
      context.read<MakePaymentCubit>().setReceiptImage(file);
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MakePaymentCubit, MakePaymentState>(
      listener: (context, state) {
        if (state.status == MakePaymentStatus.success) {
        }
      },
      builder: (context, state) {
        return CommonScreen(
          bottomPadding: 0,
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(
              top: Resources.verticalDims.$16,
              left: Resources.horizontalDims.$24,
              right: Resources.horizontalDims.$24,
              bottom: Resources.verticalDims.$32,
            ),
            decoration: BoxDecoration(
              color: Resources.colors.luxurySurface,
              boxShadow: [
                BoxShadow(
                  color: Resources.colors.luxuryInk.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: AppPrimaryButton(label: 'Upload & Pay', onPressed: () {
              context.go(AppRouteEnum.paymentSuccessPage.path);
            }),
          ),
          appBar: const AppAuthBrandHeader(showBack: true, label: 'Payment'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildAmountDueCard(context),
                      const SizedBox(height: 32),
                      _buildBankDetailsCard(context),
                      const SizedBox(height: 32),
                      _buildUploadPortal(context, state),
                      const SizedBox(height: 32),
                      Text(
                        'Our financial team will manually review and verify your bank transfer within 24 to 48 hours.',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Resources.colors.luxuryBody.withValues(
                            alpha: 0.8,
                          ),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmountDueCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Resources.colors.luxuryBorder),
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppShadows.card,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AMOUNT DUE',
            style: context.textTheme.labelSmall?.copyWith(
              color: Resources.colors.luxuryBody,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'SAR 14,000',
            style: context.textTheme.headlineLarge?.copyWith(
              color: Resources.colors.luxuryNavy,
              fontWeight: Resources.fontWeights.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildBreakdownRow(
            context,
            'Base Fee',
            'SAR 10,000',
            isOdd: true,
            isFirst: true,
          ),
          _buildBreakdownRow(context, 'Vat(12%)', 'SAR 1200', isOdd: false),
          _buildBreakdownRow(
            context,
            'Total',
            'SAR 11200',
            isOdd: true,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(
    BuildContext context,
    String title,
    String amount, {
    required bool isOdd,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isOdd
            ? Resources.colors.luxurySurface
            : context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(4) : Radius.zero,
          bottom: isLast ? const Radius.circular(4) : Radius.zero,
        ),
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Resources.colors.luxuryBorder)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Resources.colors.luxuryBody,
              fontWeight: Resources.fontWeights.semiBold,
            ),
          ),
          Text(
            amount,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Resources.colors.luxuryNavy,
              fontWeight: Resources.fontWeights.semiBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailsCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Resources.colors.luxuryBorder),

        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Transfer Details',
            style: context.textTheme.headlineSmall?.copyWith(
              color: Resources.colors.luxuryNavy,
            ),
          ),
          const SizedBox(height: 16),
          _buildBankInfoItem(
            context,
            'BANK NAME',
            'Saudi National Bank',
            hasCopy: false,
          ),
          const SizedBox(height: 16),
          _buildBankInfoItem(context, 'IBAN', 'SA00 1000 0000 0000 0000 0000'),
          const SizedBox(height: 16),
          _buildBankInfoItem(context, 'ACCOUNT NAME', 'Arcova Real Estate'),
        ],
      ),
    );
  }

  Widget _buildBankInfoItem(
    BuildContext context,
    String label,
    String value, {
    bool hasCopy = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: Resources.colors.luxuryGoldLight,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.semiBold,
                  letterSpacing: label == 'IBAN' ? -0.5 : null,
                ),
              ),
            ],
          ),
        ),
        if (hasCopy)
          GestureDetector(
            onTap: () => _copyToClipboard(context, value),
            child: Text(
              'COPY',
              style: context.textTheme.labelMedium?.copyWith(
                color: Resources.colors.luxuryGoldLight,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUploadPortal(BuildContext context, MakePaymentState state) {
    if (state.receiptImage != null) {
      return Container(
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.file(
                File(state.receiptImage!.path),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 4),
                  FutureBuilder<int>(
                    future: state.receiptImage!.length(),
                    builder: (context, snapshot) {
                      final sizeStr = snapshot.hasData
                          ? '${(snapshot.data! / (1024 * 1024)).toStringAsFixed(1)} MB'
                          : 'Loading...';
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
              icon: const Icon(Icons.close, size: 18),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Resources.colors.luxuryBorder),
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Resources.colors.luxurySurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.upload_rounded,
                  size: 32,
                  color: Resources.colors.luxuryNavy.withValues(alpha: 0.4),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'TAP TO UPLOAD RECEIPT',
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
