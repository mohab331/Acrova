import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/models/billing/payment_model.dart';

class MockBillingDataSource implements BaseBillingDataSource {
  final List<PaymentModel> _payments = [
    PaymentModel(
      id: 'PAY-001',
      projectId: 'ARC-2026-00012',
      projectName: 'Al-Yasmeen Estate',
      amount: 140000,
      currency: 'SAR',
      status: PaymentStatus.success,
      date: DateTime.now().subtract(const Duration(days: 2)),
      transactionId: 'TRN-004-582',
      bankName: 'Al Rajhi Bank',
      iban: 'SA12 8000 0000 0000',
      accountName: 'Arcova Real Estate',
      receiptUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBO6D4aCgL7uutbd62c8gJ63feroaBUiwiIzmPSLd3KJ5RO1BEGoISuBUtitPTzM5ZqAUiHEfEHkhRsVotQh9IkIH6Pe9PjA-s17sjSJWjSJa7DrvBTlgXtY3G-Jv1nJL5q_FI3-t4mM7Mt6Xo_DpcsnYjtUnBE7r9SLGjtAE7cM741WiX-H3LUhjVaT5GbrAka-I-agO42IinP3rTSPW0UN2nEXmapFrLxhjHGeeyw48c9XemgPcwl',
    ),
    PaymentModel(
      id: 'PAY-002',
      projectId: 'ARC-2026-00015',
      projectName: 'Nakheel Commercial',
      amount: 50000,
      currency: 'SAR',
      status: PaymentStatus.rejected,
      date: DateTime.now().subtract(const Duration(days: 5)),
      transactionId: 'TRN-005-123',
      bankName: 'SNB',
      iban: 'SA34 1000 0000 0000',
      accountName: 'Arcova Real Estate',
      receiptUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBO6D4aCgL7uutbd62c8gJ63feroaBUiwiIzmPSLd3KJ5RO1BEGoISuBUtitPTzM5ZqAUiHEfEHkhRsVotQh9IkIH6Pe9PjA-s17sjSJWjSJa7DrvBTlgXtY3G-Jv1nJL5q_FI3-t4mM7Mt6Xo_DpcsnYjtUnBE7r9SLGjtAE7cM741WiX-H3LUhjVaT5GbrAka-I-agO42IinP3rTSPW0UN2nEXmapFrLxhjHGeeyw48c9XemgPcwl',
      rejectionReason: 'The provided reference number does not match our records. Please verify your transfer details and upload a corrected receipt.',
    ),
    PaymentModel(
      id: 'PAY-003',
      projectId: 'ARC-2026-00012',
      projectName: 'Al-Yasmeen Estate',
      amount: 20000,
      currency: 'SAR',
      status: PaymentStatus.pending,
      date: DateTime.now().subtract(const Duration(days: 1)),
      transactionId: 'TRN-006-999',
      bankName: 'Riyad Bank',
      iban: 'SA56 2000 0000 0000',
      accountName: 'Arcova Real Estate',
    ),
    PaymentModel(
      id: 'PAY-004',
      projectId: 'ARC-2025-00042',
      projectName: 'Olaya Tower',
      amount: 300000,
      currency: 'SAR',
      status: PaymentStatus.success,
      date: DateTime.now().subtract(const Duration(days: 30)),
      transactionId: 'TRN-001-111',
      bankName: 'Alinma Bank',
      iban: 'SA78 3000 0000 0000',
      accountName: 'Arcova Real Estate',
      receiptUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBO6D4aCgL7uutbd62c8gJ63feroaBUiwiIzmPSLd3KJ5RO1BEGoISuBUtitPTzM5ZqAUiHEfEHkhRsVotQh9IkIH6Pe9PjA-s17sjSJWjSJa7DrvBTlgXtY3G-Jv1nJL5q_FI3-t4mM7Mt6Xo_DpcsnYjtUnBE7r9SLGjtAE7cM741WiX-H3LUhjVaT5GbrAka-I-agO42IinP3rTSPW0UN2nEXmapFrLxhjHGeeyw48c9XemgPcwl',
    ),
  ];

  @override
  Future<List<PaymentModel>> getPayments() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network latency
    return List.unmodifiable(_payments);
  }

  @override
  Future<PaymentModel> getPaymentDetails(String paymentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final payment = _payments.firstWhere(
      (p) => p.id == paymentId,
      orElse: () => throw Exception('Payment not found'),
    );
    return payment;
  }
}
