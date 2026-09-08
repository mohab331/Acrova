import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'make_payment_state.dart';

class MakePaymentCubit extends Cubit<MakePaymentState> {
  MakePaymentCubit() : super(const MakePaymentState());

  void setReceiptImage(XFile image) {
    emit(state.copyWith(receiptImage: image));
  }

  void removeReceiptImage() {
    emit(state.copyWith(clearReceiptImage: true));
  }

  Future<void> submitPayment() async {
    if (state.receiptImage == null) return;
    
    emit(state.copyWith(status: MakePaymentStatus.uploading));
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    emit(state.copyWith(status: MakePaymentStatus.success));
  }
}
