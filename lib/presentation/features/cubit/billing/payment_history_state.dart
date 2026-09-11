import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/payment_filter_enum.dart';
import 'package:equatable/equatable.dart';

class PaymentHistoryState extends Equatable {
  const PaymentHistoryState({
    this.status = CubitStatus.initial,
    this.payments = const [],
    this.filteredPayments = const [],
    this.selectedFilter = PaymentFilter.all,
    this.error,
  });

  final CubitStatus status;
  final List<PaymentModel> payments;
  final List<PaymentModel> filteredPayments;
  final PaymentFilter selectedFilter;
  final AppErrorModel? error;

  bool get isLoading =>
      status == CubitStatus.loading || status == CubitStatus.initial;
  bool get isSuccess => status == CubitStatus.success;
  bool get isError => status == CubitStatus.error;
  bool get isEmpty => status == CubitStatus.success && filteredPayments.isEmpty;

  PaymentHistoryState copyWith({
    CubitStatus? status,
    List<PaymentModel>? payments,
    List<PaymentModel>? filteredPayments,
    PaymentFilter? selectedFilter,
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
  List<Object?> get props => [
    status,
    payments,
    filteredPayments,
    selectedFilter,
    error,
  ];
}
