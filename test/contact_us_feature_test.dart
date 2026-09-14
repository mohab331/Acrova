import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/core/error/error_codes_enum.dart';
import 'package:acrova/data/data_source/base/base_contact_us_data_source.dart';
import 'package:acrova/data/data_source/remote/services/contact_us/constants/contact_us_endpoints.dart';
import 'package:acrova/data/models/request/contact_us/submit_inquiry_request_model.dart';
import 'package:acrova/data/repository/contact_us/contact_us_repo_impl.dart';
import 'package:acrova/domain/repository/contact_us/base_contact_us_repo.dart';
import 'package:acrova/presentation/features/ui/contact_us/cubit/contact_us_cubit.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/result.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeContactUsDataSource implements BaseContactUsDataSource {
  FakeContactUsDataSource({this.shouldThrow = false});

  final bool shouldThrow;
  SubmitInquiryRequestModel? lastRequest;

  @override
  Future<void> submitInquiry(SubmitInquiryRequestModel request) async {
    lastRequest = request;
    if (shouldThrow) {
      throw const AppErrorModel(
        code: ErrorCodesEnum.serverError,
        title: 'Server Error',
        message: 'Server error',
      );
    }
  }
}

class FakeContactUsRepo implements BaseContactUsRepo {
  FakeContactUsRepo({this.result = const Success(null)});

  final Result<void> result;
  SubmitInquiryRequestModel? lastRequest;

  @override
  Future<Result<void>> submitInquiry(SubmitInquiryRequestModel request) async {
    lastRequest = request;
    return result;
  }
}

void main() {
  group('ContactUsEndpoints', () {
    test('submitInquiry endpoint has correct path', () {
      expect(ContactUsEndpoints.submitInquiry, '/submitInquiry');
    });
  });

  group('SubmitInquiryRequestModel', () {
    test('toJson produces expected structure', () {
      const model = SubmitInquiryRequestModel(
        email: 'test@acrova.com',
        mobileNumber: '+966501234567',
        details: 'Need assistance with design phase',
      );

      final json = model.toJson();
      expect(json['email'], 'test@acrova.com');
      expect(json['mobile_number'], '+966501234567');
      expect(json['details'], 'Need assistance with design phase');
    });

    test('props and toString contain expected values', () {
      const model1 = SubmitInquiryRequestModel(
        email: 'a@b.com',
        mobileNumber: '123',
        details: 'abc',
      );
      const model2 = SubmitInquiryRequestModel(
        email: 'a@b.com',
        mobileNumber: '123',
        details: 'abc',
      );

      expect(model1, equals(model2));
      expect(model1.toString(), contains('a@b.com'));
    });
  });

  group('ContactUsRepoImpl', () {
    test('delegates submitInquiry to data source on success', () async {
      final fakeDataSource = FakeContactUsDataSource();
      final repo = ContactUsRepoImpl(dataSource: fakeDataSource);

      const request = SubmitInquiryRequestModel(
        email: 'test@example.com',
        mobileNumber: '+966500000000',
        details: 'Test inquiry details',
      );

      final result = await repo.submitInquiry(request);

      expect(result.isSuccess, isTrue);
      expect(fakeDataSource.lastRequest, request);
    });

    test('returns failure when data source throws', () async {
      final fakeDataSource = FakeContactUsDataSource(shouldThrow: true);
      final repo = ContactUsRepoImpl(dataSource: fakeDataSource);

      const request = SubmitInquiryRequestModel(
        email: 'test@example.com',
        mobileNumber: '+966500000000',
        details: 'Test inquiry details',
      );

      final result = await repo.submitInquiry(request);

      expect(result.isFailure, isTrue);
    });
  });

  group('ContactUsCubit', () {
    String resolveError(ContactUsFieldError code) {
      return switch (code) {
        ContactUsFieldError.emailInvalid => 'Invalid email address.',
        ContactUsFieldError.detailsRequired => 'Please describe your issue.',
      };
    }

    test('initial state has provided or default values', () {
      final repo = FakeContactUsRepo();
      final cubit = ContactUsCubit(
        contactUsRepo: repo,
        email: 'user@acrova.com',
        mobileNumber: '0501234567',
      );

      expect(cubit.state.email, 'user@acrova.com');
      expect(cubit.state.mobileNumber, '0501234567');
      expect(cubit.state.details, '');
      expect(cubit.state.cubitStatus, CubitStatus.initial);
      expect(cubit.state.isSubmitting, isFalse);
    });

    test('updates fields properly', () {
      final repo = FakeContactUsRepo();
      final cubit = ContactUsCubit(contactUsRepo: repo);

      cubit.updateEmail('hello@acrova.com');
      expect(cubit.state.email, 'hello@acrova.com');
      expect(cubit.state.emailError, isNull);

      cubit.updateMobile('+966512345678');
      expect(cubit.state.mobileNumber, '+966512345678');

      cubit.updateDetails('Some details');
      expect(cubit.state.details, 'Some details');
      expect(cubit.state.detailsError, isNull);
    });

    test('validates required details and valid email before submitting', () async {
      final repo = FakeContactUsRepo();
      final cubit = ContactUsCubit(contactUsRepo: repo);

      // Submit with empty fields
      await cubit.submit(resolve: resolveError);

      expect(cubit.state.emailError, 'Invalid email address.');
      expect(cubit.state.detailsError, 'Please describe your issue.');
      expect(repo.lastRequest, isNull);
      expect(cubit.state.cubitStatus, CubitStatus.initial);
    });

    test('submits inquiry and transitions to success', () async {
      final repo = FakeContactUsRepo();
      final cubit = ContactUsCubit(
        contactUsRepo: repo,
        email: 'client@acrova.com',
        mobileNumber: '+966500000000',
      );

      cubit.updateDetails('Inquiry description here');
      await cubit.submit(resolve: resolveError);

      expect(cubit.state.cubitStatus, CubitStatus.success);
      expect(cubit.state.isSuccess, isTrue);
      expect(repo.lastRequest?.email, 'client@acrova.com');
      expect(repo.lastRequest?.details, 'Inquiry description here');
    });

    test('submits inquiry and transitions to error on failure', () async {
      const error = AppErrorModel(
        code: ErrorCodesEnum.serverError,
        title: 'Server Error',
        message: 'Submission failed',
      );
      final repo = FakeContactUsRepo(result: const Failure(error));
      final cubit = ContactUsCubit(
        contactUsRepo: repo,
        email: 'client@acrova.com',
      );

      cubit.updateDetails('Need help');
      await cubit.submit(resolve: resolveError);

      expect(cubit.state.cubitStatus, CubitStatus.error);
      expect(cubit.state.isError, isTrue);
      expect(cubit.state.appErrorModel, error);
    });
  });
}
