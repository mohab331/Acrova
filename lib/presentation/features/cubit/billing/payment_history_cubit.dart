import 'package:acrova/data/data_source/base/base_billing_data_source.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/core/error/error_codes_enum.dart';
import 'package:acrova/presentation/features/cubit/billing/payment_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  PaymentHistoryCubit({
    required BaseBillingDataSource billingDataSource,
  })  : _billingDataSource = billingDataSource,
        super(const PaymentHistoryState());

  final BaseBillingDataSource _billingDataSource;

  Future<void> fetchPayments() async {
    emit(state.copyWith(status: PaymentHistoryStatus.loading, error: null));
    try {
      final payments = await _billingDataSource.getPayments();
      emit(state.copyWith(
        status: PaymentHistoryStatus.success,
        payments: payments,
        filteredPayments: _filterPayments(payments, state.selectedFilter),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PaymentHistoryStatus.failure,
        error: const AppErrorModel(
          code: ErrorCodesEnum.network,
          title: 'Failed to Load',
          message: 'A connection issue occurred while fetching your ledger. Please verify your network and retry.',
        ),
      ));
    }
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
