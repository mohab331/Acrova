import 'package:acrova/core/error/app_error_model.dart';
import 'package:acrova/data/models/billing/payment_model.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class MakePaymentState extends Equatable {
  const MakePaymentState({
    this.fetchQuoteStatus = CubitStatus.initial,
    this.submittingStatus = CubitStatus.initial,
    this.receiptImage,
    this.quote,
    this.submittingError,
    this.fetchQuoteError,
  });

  final CubitStatus submittingStatus;
  final CubitStatus fetchQuoteStatus;
  final XFile? receiptImage;
  final PaymentQuoteModel? quote;
  final AppErrorModel? submittingError;
  final AppErrorModel? fetchQuoteError;

  bool get isLoading =>
      fetchQuoteStatus == CubitStatus.loading ||
      fetchQuoteStatus == CubitStatus.initial;
  bool get isSuccess => fetchQuoteStatus == CubitStatus.success;
  bool get isError => fetchQuoteStatus == CubitStatus.error;

  MakePaymentState copyWith({
    CubitStatus? submittingStatus,
    CubitStatus? fetchQuoteStatus,
    XFile? receiptImage,
    bool clearReceiptImage = false,
    PaymentQuoteModel? quote,
    AppErrorModel? submittingError,
    AppErrorModel? fetchQuoteError,
  }) {
    return MakePaymentState(
      fetchQuoteStatus: fetchQuoteStatus ?? this.fetchQuoteStatus,
      submittingStatus: submittingStatus ?? this.submittingStatus,
      receiptImage: clearReceiptImage
          ? null
          : (receiptImage ?? this.receiptImage),
      quote: quote ?? this.quote,
      fetchQuoteError: fetchQuoteError ?? this.fetchQuoteError,
      submittingError: submittingError ?? this.submittingError,
    );
  }

  @override
  List<Object?> get props => [
    fetchQuoteStatus,
    submittingStatus,
    fetchQuoteError,
    submittingError,
    receiptImage,
    quote,
  ];
}
