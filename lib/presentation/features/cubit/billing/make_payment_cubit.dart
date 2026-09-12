import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/presentation/features/cubit/billing/make_payment_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MakePaymentCubit extends Cubit<MakePaymentState> {
  MakePaymentCubit({required BaseBillingRepo billingRepo})
    : _billingRepo = billingRepo,
      super(const MakePaymentState());

  final BaseBillingRepo _billingRepo;

  Future<void> fetchQuote({String? projectId}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await _billingRepo.getPaymentQuote(projectId ?? '');
    result.when(
      success: (quote) =>
          emit(state.copyWith(status: CubitStatus.success, quote: quote)),
      failure: (error) =>
          emit(state.copyWith(status: CubitStatus.error, error: error)),
    );
  }

  void setReceiptImage(XFile image) {
    emit(state.copyWith(receiptImage: image));
  }

  void removeReceiptImage() {
    emit(state.copyWith(clearReceiptImage: true));
  }

  Future<void> submitPayment({String? projectId, String? notes}) async {
    if (state.receiptImage == null) return;

    emit(state.copyWith(isSubmitting: true));
    final result = await _billingRepo.submitPayment(
      projectId: projectId ?? '',
      receiptPath: state.receiptImage!.path,
    );
    result.when(
      success: (_) => emit(
        state.copyWith(isSubmitting: false, status: CubitStatus.success),
      ),
      failure: (error) => emit(
        state.copyWith(
          isSubmitting: false,
          status: CubitStatus.error,
          error: error,
        ),
      ),
    );
  }
}
