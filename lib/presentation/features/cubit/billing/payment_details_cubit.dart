import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/core/error/error_codes_enum.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsState> {
  PaymentDetailsCubit({
    required BaseBillingDataSource billingDataSource,
  })  : _billingDataSource = billingDataSource,
        super(const PaymentDetailsState());

  final BaseBillingDataSource _billingDataSource;

  Future<void> fetchPaymentDetails(String paymentId) async {
    emit(state.copyWith(status: PaymentDetailsStatus.loading, error: null));
    try {
      final payment = await _billingDataSource.getPaymentDetails(paymentId);
      emit(state.copyWith(
        status: PaymentDetailsStatus.success,
        payment: payment,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PaymentDetailsStatus.failure,
        error: const AppErrorModel(
          code: ErrorCodesEnum.notFound,
          title: 'Payment Not Found',
          message: 'Unable to retrieve details for this transaction.',
        ),
      ));
    }
  }
}
