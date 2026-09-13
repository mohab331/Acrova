import 'package:acrova/core/config/mock_config.dart';
import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/models/request/billing/get_payment_details_request_model.dart';
import 'package:acrova/data/models/request/billing/get_payment_quote_request_model.dart';
import 'package:acrova/data/models/request/billing/submit_payment_request_model.dart';
import 'package:acrova/data/models/response/billing/payment_quote_response_model.dart';
import 'package:acrova/data/models/response/billing/payment_response_model.dart';
import 'package:acrova/data/repository/billing/billing_repo_impl.dart';
import 'package:acrova/data/repository/mock/mock_repositories.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubBillingDataSource implements BaseBillingDataSource {
  String? submittedProjectId;
  String? submittedReceiptPath;

  @override
  Future<List<PaymentResponseModel>> getPayments() async => [
    PaymentResponseModel(
      id: 'PAY-001',
      projectId: 'PROJ-001',
      projectName: 'Al-Yasmeen Estate',
      amount: 140000.0,
      currency: 'SAR',
      date: DateTime(2024),
      status: PaymentStatus.success,
      transactionId: 'TXN-001',
      bankName: 'Al Rajhi Bank',
      iban: 'SA0000000000000000000000',
      accountName: 'Acrova Ltd',
    ),
  ];

  @override
  Future<PaymentResponseModel> getPaymentDetails(
    GetPaymentDetailsRequestModel request,
  ) async {
    if (request.paymentId == 'PAY-001') {
      return PaymentResponseModel(
        id: 'PAY-001',
        projectId: 'PROJ-001',
        projectName: 'Al-Yasmeen Estate',
        amount: 140000.0,
        currency: 'SAR',
        date: DateTime(2024),
        status: PaymentStatus.success,
        transactionId: 'TXN-001',
        bankName: 'Al Rajhi Bank',
        iban: 'SA0000000000000000000000',
        accountName: 'Acrova Ltd',
      );
    }
    throw Exception('Payment not found');
  }

  @override
  Future<PaymentQuoteResponseModel> getPaymentQuote(
    GetPaymentQuoteRequestModel request,
  ) async =>
      PaymentQuoteResponseModel(
        projectId: request.projectId,
        amountDue: 14000,
        baseFee: 10000,
        vat: 1200,
        total: 11200,
        currency: 'SAR',
        bankName: 'Saudi National Bank',
        iban: 'SA0000000000000000000000',
        accountName: 'Acrova Ltd',
      );

  @override
  Future<void> submitPayment(SubmitPaymentRequestModel request) async {
    submittedProjectId = request.projectId;
    submittedReceiptPath = request.receiptPath;
  }
}

void main() {
  group('BillingRepoImpl', () {
    late BillingRepoImpl repository;
    late _StubBillingDataSource stubDataSource;

    setUp(() {
      stubDataSource = _StubBillingDataSource();
      repository = BillingRepoImpl(dataSource: stubDataSource);
    });

    test('getPayments returns Success with list of payments', () async {
      final result = await repository.getPayments();

      expect(result, isA<Success<List<PaymentResponseModel>>>());
      result.when(
        success: (payments) {
          expect(payments, isNotEmpty);
          expect(payments.first.id, equals('PAY-001'));
        },
        failure: (error) {
          fail('Expected success but got failure: ${error.message}');
        },
      );
    });

    test('getPaymentDetails returns Success for valid payment id', () async {
      final result = await repository.getPaymentDetails(
        const GetPaymentDetailsRequestModel(paymentId: 'PAY-001'),
      );

      expect(result, isA<Success<PaymentResponseModel>>());
      result.when(
        success: (payment) {
          expect(payment.id, equals('PAY-001'));
          expect(payment.projectName, equals('Al-Yasmeen Estate'));
          expect(payment.amount, equals(140000.0));
        },
        failure: (error) {
          fail('Expected success but got failure: ${error.message}');
        },
      );
    });

    test(
      'getPaymentDetails returns Failure for non-existent payment id',
      () async {
        final result = await repository.getPaymentDetails(
          const GetPaymentDetailsRequestModel(paymentId: 'INVALID-ID'),
        );

        expect(result, isA<Failure<PaymentResponseModel>>());
      },
    );

    test('delegates payment quote retrieval to the data source', () async {
      final result = await repository.getPaymentQuote(
        const GetPaymentQuoteRequestModel(projectId: 'PROJ-001'),
      );

      expect(result, isA<Success<PaymentQuoteResponseModel>>());
      result.when(
        success: (quote) => expect(quote.amountDue, equals(14000)),
        failure: (error) =>
            fail('Expected success but got failure: ${error.message}'),
      );
    });

    test('delegates receipt submission to the data source', () async {
      final result = await repository.submitPayment(
        const SubmitPaymentRequestModel(
          projectId: 'PROJ-001',
          receiptPath: '/tmp/receipt.jpg',
        ),
      );

      expect(result, isA<Success<void>>());
      expect(stubDataSource.submittedProjectId, equals('PROJ-001'));
      expect(stubDataSource.submittedReceiptPath, equals('/tmp/receipt.jpg'));
    });
  });

  group('MockBillingRepo with MockConfig scenarios', () {
    late MockBillingRepo mockRepo;

    setUp(() {
      mockRepo = MockBillingRepo();
      MockConfig.reset();
    });

    tearDown(MockConfig.reset);

    test('returns Success data when scenario is success', () async {
      MockConfig.setScenario(MockRepositoryKey.billing, MockScenario.success);

      final paymentsResult = await mockRepo.getPayments();
      expect(paymentsResult, isA<Success<List<PaymentResponseModel>>>());

      final quoteResult = await mockRepo.getPaymentQuote(
        const GetPaymentQuoteRequestModel(projectId: 'proj_001'),
      );
      expect(quoteResult, isA<Success<PaymentQuoteResponseModel>>());
    });

    test('returns empty data when scenario is empty', () async {
      MockConfig.setScenario(MockRepositoryKey.billing, MockScenario.empty);

      final paymentsResult = await mockRepo.getPayments();
      expect(paymentsResult, isA<Success<List<PaymentResponseModel>>>());
      paymentsResult.when(
        success: (payments) => expect(payments, isEmpty),
        failure: (_) => fail('Expected success with empty list'),
      );
    });

    test('returns Failure when scenario is error', () async {
      MockConfig.setScenario(MockRepositoryKey.billing, MockScenario.error);

      final paymentsResult = await mockRepo.getPayments();
      expect(paymentsResult, isA<Failure<List<PaymentResponseModel>>>());

      final quoteResult = await mockRepo.getPaymentQuote(
        const GetPaymentQuoteRequestModel(projectId: 'proj_001'),
      );
      expect(quoteResult, isA<Failure<PaymentQuoteResponseModel>>());
    });
  });
}
