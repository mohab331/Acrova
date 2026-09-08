import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum MakePaymentStatus { initial, uploading, success, failure }

class MakePaymentState extends Equatable {
  const MakePaymentState({
    this.status = MakePaymentStatus.initial,
    this.receiptImage,
  });

  final MakePaymentStatus status;
  final XFile? receiptImage;

  MakePaymentState copyWith({
    MakePaymentStatus? status,
    XFile? receiptImage,
    bool clearReceiptImage = false,
  }) {
    return MakePaymentState(
      status: status ?? this.status,
      receiptImage: clearReceiptImage ? null : (receiptImage ?? this.receiptImage),
    );
  }

  @override
  List<Object?> get props => [status, receiptImage];
}
