import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:equatable/equatable.dart';

enum PaymentDetailsStatus { initial, loading, success, failure }

class PaymentDetailsState extends Equatable {
  const PaymentDetailsState({
    this.status = PaymentDetailsStatus.initial,
    this.payment,
    this.error,
  });

  final PaymentDetailsStatus status;
  final PaymentModel? payment;
  final AppErrorModel? error;

  bool get isLoading => status == PaymentDetailsStatus.loading || status == PaymentDetailsStatus.initial;

  PaymentDetailsState copyWith({
    PaymentDetailsStatus? status,
    PaymentModel? payment,
    AppErrorModel? error,
  }) {
    return PaymentDetailsState(
      status: status ?? this.status,
      payment: payment ?? this.payment,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, payment, error];
}
