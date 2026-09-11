import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  PaymentHistoryCubit({
    required BaseBillingRepo billingRepo,
  })  : _billingRepo = billingRepo,
        super(const PaymentHistoryState());

  final BaseBillingRepo _billingRepo;

  Future<void> fetchPayments() async {
    emit(state.copyWith(status: PaymentHistoryStatus.loading));
    final result = await _billingRepo.getPayments();
    result.when(
      success: (payments) {
        emit(state.copyWith(
          status: PaymentHistoryStatus.success,
          payments: payments,
          filteredPayments: _filterPayments(payments, state.selectedFilter),
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          status: PaymentHistoryStatus.failure,
          error: error,
        ));
      },
    );
  }

  void updateFilter(String filter) {
    emit(state.copyWith(
      selectedFilter: filter,
      filteredPayments: _filterPayments(state.payments, filter),
    ));
  }

  List<PaymentModel> _filterPayments(List<PaymentModel> payments, String filter) {
    if (filter == 'All') return payments;
    return payments.where((p) => p.status.displayName == filter).toList();
  }
}
