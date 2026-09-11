import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsState> {
  PaymentDetailsCubit({
    required BaseBillingRepo billingRepo,
  })  : _billingRepo = billingRepo,
        super(const PaymentDetailsState());

  final BaseBillingRepo _billingRepo;

  Future<void> fetchPaymentDetails(String paymentId) async {
    emit(state.copyWith(status: PaymentDetailsStatus.loading));
    final result = await _billingRepo.getPaymentDetails(paymentId);
    result.when(
      success: (payment) {
        emit(state.copyWith(
          status: PaymentDetailsStatus.success,
          payment: payment,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          status: PaymentDetailsStatus.failure,
          error: error,
        ));
      },
    );
  }
}
