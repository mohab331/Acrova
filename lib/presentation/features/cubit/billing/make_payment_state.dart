import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class MakePaymentState extends Equatable {
  const MakePaymentState({
    this.status = CubitStatus.initial,
    this.receiptImage,
    this.quote,
    this.error,
    this.isSubmitting = false,
  });

  final CubitStatus status;
  final XFile? receiptImage;
  final PaymentQuoteModel? quote;
  final AppErrorModel? error;
  final bool isSubmitting;

  bool get isLoading =>
      status == CubitStatus.loading || status == CubitStatus.initial;
  bool get isSuccess => status == CubitStatus.success;
  bool get isError => status == CubitStatus.error;

  MakePaymentState copyWith({
    CubitStatus? status,
    XFile? receiptImage,
    bool clearReceiptImage = false,
    PaymentQuoteModel? quote,
    AppErrorModel? error,
    bool? isSubmitting,
  }) {
    return MakePaymentState(
      status: status ?? this.status,
      receiptImage: clearReceiptImage
          ? null
          : (receiptImage ?? this.receiptImage),
      quote: quote ?? this.quote,
      error: error ?? this.error,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, receiptImage, quote, error, isSubmitting];
}
