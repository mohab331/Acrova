import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/presentation/features/ui/billing/payment_history/cubit/payment_history_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/payment_filter_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  PaymentHistoryCubit({required BaseBillingRepo billingRepo})
    : _billingRepo = billingRepo,
      super(const PaymentHistoryState());

  final BaseBillingRepo _billingRepo;

  Future<void> fetchPayments() async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await _billingRepo.getPayments();
    result.when(
      success: (payments) {
        emit(
          state.copyWith(
            status: CubitStatus.success,
            payments: payments,
            filteredPayments: _filterPayments(payments, state.selectedFilter),
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(status: CubitStatus.error, error: error));
      },
    );
  }

  void updateFilter(PaymentFilter filter) {
    emit(
      state.copyWith(
        selectedFilter: filter,
        filteredPayments: _filterPayments(state.payments, filter),
      ),
    );
  }

  List<PaymentModel> _filterPayments(
    List<PaymentModel> payments,
    PaymentFilter filter,
  ) {
    if (filter == PaymentFilter.all) return payments;
    return payments
        .where((p) => p.status?.name.toLowerCase() == filter.name.toLowerCase())
        .toList();
  }
}
