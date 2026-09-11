import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:equatable/equatable.dart';

enum PaymentHistoryStatus { initial, loading, success, failure }

class PaymentHistoryState extends Equatable {
  const PaymentHistoryState({
    this.status = PaymentHistoryStatus.initial,
    this.payments = const [],
    this.filteredPayments = const [],
    this.selectedFilter = 'All',
    this.error,
  });

  final PaymentHistoryStatus status;
  final List<PaymentModel> payments;
  final List<PaymentModel> filteredPayments;
  final String selectedFilter;
  final AppErrorModel? error;

  bool get isLoading => status == PaymentHistoryStatus.loading || status == PaymentHistoryStatus.initial;
  bool get isEmpty => status == PaymentHistoryStatus.success && filteredPayments.isEmpty;

  PaymentHistoryState copyWith({
    PaymentHistoryStatus? status,
    List<PaymentModel>? payments,
    List<PaymentModel>? filteredPayments,
    String? selectedFilter,
    AppErrorModel? error,
  }) {
    return PaymentHistoryState(
      status: status ?? this.status,
      payments: payments ?? this.payments,
      filteredPayments: filteredPayments ?? this.filteredPayments,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, payments, filteredPayments, selectedFilter, error];
}
