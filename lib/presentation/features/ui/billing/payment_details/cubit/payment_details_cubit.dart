import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/presentation/features/ui/billing/payment_details/cubit/payment_details_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsState> {
  PaymentDetailsCubit({required BaseBillingRepo billingRepo})
    : _billingRepo = billingRepo,
      super(const PaymentDetailsState());

  final BaseBillingRepo _billingRepo;

  Future<void> fetchPaymentDetails([String? paymentId]) async {
    final id = paymentId ?? state.paymentId;
    if (id == null || id.isEmpty) return;

    emit(state.copyWith(status: CubitStatus.loading, paymentId: id));
    final result = await _billingRepo.getPaymentDetails(id);
    result.when(
      success: (payment) {
        emit(state.copyWith(status: CubitStatus.success, payment: payment));
      },
      failure: (error) {
        emit(state.copyWith(status: CubitStatus.error, error: error));
      },
    );
  }
}
