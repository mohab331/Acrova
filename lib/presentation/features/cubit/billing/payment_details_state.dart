import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class PaymentDetailsState extends Equatable {
  const PaymentDetailsState({
    this.status = CubitStatus.initial,
    this.paymentId,
    this.payment,
    this.error,
  });

  final CubitStatus status;
  final String? paymentId;
  final PaymentModel? payment;
  final AppErrorModel? error;

  bool get isLoading =>
      status == CubitStatus.loading || status == CubitStatus.initial;
  bool get isSuccess => status == CubitStatus.success;
  bool get isError => status == CubitStatus.error;

  PaymentDetailsState copyWith({
    CubitStatus? status,
    String? paymentId,
    PaymentModel? payment,
    AppErrorModel? error,
  }) {
    return PaymentDetailsState(
      status: status ?? this.status,
      paymentId: paymentId ?? this.paymentId,
      payment: payment ?? this.payment,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, paymentId, payment, error];
}
