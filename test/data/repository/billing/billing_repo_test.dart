import 'package:acrova/core/config/mock_config.dart';
import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/data/repository/billing/billing_repo_impl.dart';
import 'package:acrova/data/repository/mock/mock_repositories.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeBillingDataSource implements BaseBillingDataSource {
  @override
  Future<List<PaymentModel>> getPayments() async => [
        PaymentModel(
          id: 'PAY-001',
          projectId: 'PROJ-001',
          projectName: 'Al-Yasmeen Estate',
          amount: 140000.0,
          currency: 'SAR',
          date: DateTime(2024, 1, 1),
          status: PaymentStatus.success,
          transactionId: 'TXN-001',
          bankName: 'Al Rajhi Bank',
          iban: 'SA0000000000000000000000',
          accountName: 'Acrova Ltd',
        ),
      ];

  @override
  Future<PaymentModel> getPaymentDetails(String paymentId) async {
    if (paymentId == 'PAY-001') {
      return PaymentModel(
        id: 'PAY-001',
        projectId: 'PROJ-001',
        projectName: 'Al-Yasmeen Estate',
        amount: 140000.0,
        currency: 'SAR',
        date: DateTime(2024, 1, 1),
        status: PaymentStatus.success,
        transactionId: 'TXN-001',
        bankName: 'Al Rajhi Bank',
        iban: 'SA0000000000000000000000',
        accountName: 'Acrova Ltd',
      );
    }
    throw Exception('Payment not found');
  }
}

void main() {
  group('BillingRepoImpl', () {
    late BillingRepoImpl repository;
    late _FakeBillingDataSource fakeDataSource;

    setUp(() {
      fakeDataSource = _FakeBillingDataSource();
      repository = BillingRepoImpl(dataSource: fakeDataSource);
    });

    test('getPayments returns Success with list of payments', () async {
      final result = await repository.getPayments();

      expect(result, isA<Success<List<PaymentModel>>>());
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
      final result = await repository.getPaymentDetails('PAY-001');

      expect(result, isA<Success<PaymentModel>>());
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

    test('getPaymentDetails returns Failure for non-existent payment id', () async {
      final result = await repository.getPaymentDetails('INVALID-ID');

      expect(result, isA<Failure<PaymentModel>>());
    });
  });

  group('MockBillingRepo with MockConfig scenarios', () {
    late MockBillingRepo mockRepo;

    setUp(() {
      mockRepo = MockBillingRepo();
      MockConfig.reset();
    });

    tearDown(() {
      MockConfig.reset();
    });

    test('returns Success data when scenario is success', () async {
      MockConfig.setScenario(MockRepositoryKey.billing, MockScenario.success);

      final paymentsResult = await mockRepo.getPayments();
      expect(paymentsResult, isA<Success<List<PaymentModel>>>());

      final quoteResult = await mockRepo.getPaymentQuote('proj_001');
      expect(quoteResult, isA<Success<PaymentQuoteModel>>());
    });

    test('returns empty data when scenario is empty', () async {
      MockConfig.setScenario(MockRepositoryKey.billing, MockScenario.empty);

      final paymentsResult = await mockRepo.getPayments();
      expect(paymentsResult, isA<Success<List<PaymentModel>>>());
      paymentsResult.when(
        success: (payments) => expect(payments, isEmpty),
        failure: (_) => fail('Expected success with empty list'),
      );
    });

    test('returns Failure when scenario is error', () async {
      MockConfig.setScenario(MockRepositoryKey.billing, MockScenario.error);

      final paymentsResult = await mockRepo.getPayments();
      expect(paymentsResult, isA<Failure<List<PaymentModel>>>());

      final quoteResult = await mockRepo.getPaymentQuote('proj_001');
      expect(quoteResult, isA<Failure<PaymentQuoteModel>>());
    });
  });
}
