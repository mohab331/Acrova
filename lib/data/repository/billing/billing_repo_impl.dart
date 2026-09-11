import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';

class BillingRepoImpl implements BaseBillingRepo {
  const BillingRepoImpl({required BaseBillingDataSource dataSource})
      : _dataSource = dataSource;

  final BaseBillingDataSource _dataSource;

  @override
  Future<Result<List<PaymentModel>>> getPayments() =>
      safeAsyncCall(_dataSource.getPayments);

  @override
  Future<Result<PaymentModel>> getPaymentDetails(String paymentId) =>
      safeAsyncCall(() => _dataSource.getPaymentDetails(paymentId));

  @override
  Future<Result<void>> submitPayment({
    required String projectId,
    required String receiptPath,
  }) =>
      safeAsyncCall(() async {});

  @override
  Future<Result<PaymentQuoteModel>> getPaymentQuote(String projectId) =>
      safeAsyncCall(() async => const PaymentQuoteModel(
            amountDue: 14000,
            baseFee: 10000,
            vat: 1200,
            total: 11200,
            currency: 'SAR',
            bankName: 'Saudi National Bank',
            iban: 'SA00 1000 0000 0000 0000 0000',
            accountName: 'Arcova Real Estate',
          ));
}
