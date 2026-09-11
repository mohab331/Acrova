import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_details_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/helpers/safe_async_call.dart';
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
    await safeCubitCall<PaymentModel>(
      call: () => _billingRepo.getPaymentDetails(id),
      onSuccess: (payment) {
        emit(state.copyWith(status: CubitStatus.success, payment: payment));
      },
      onError: (error) {
        emit(state.copyWith(status: CubitStatus.error, error: error));
      },
    );
  }
}
