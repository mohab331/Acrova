import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum MakePaymentStatus { initial, loading, uploading, success, failure }

class MakePaymentState extends Equatable {
  const MakePaymentState({
    this.status = MakePaymentStatus.initial,
    this.receiptImage,
    this.quote,
    this.error,
  });

  final MakePaymentStatus status;
  final XFile? receiptImage;
  final PaymentQuoteModel? quote;
  final AppErrorModel? error;

  MakePaymentState copyWith({
    MakePaymentStatus? status,
    XFile? receiptImage,
    bool clearReceiptImage = false,
    PaymentQuoteModel? quote,
    AppErrorModel? error,
  }) {
    return MakePaymentState(
      status: status ?? this.status,
      receiptImage: clearReceiptImage ? null : (receiptImage ?? this.receiptImage),
      quote: quote ?? this.quote,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, receiptImage, quote, error];
}
