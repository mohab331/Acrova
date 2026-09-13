import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/data/models/request/billing/get_payment_quote_request_model.dart';
import 'package:acrova/data/models/request/billing/submit_payment_request_model.dart';
import 'package:acrova/domain/repository/billing/base_billing_repo.dart';
import 'package:acrova/presentation/features/ui/billing/make_payment/cubit/make_payment_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/logging/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MakePaymentCubit extends Cubit<MakePaymentState> {
  MakePaymentCubit({
    required BaseBillingRepo billingRepo,
    required BaseImagePickerService baseImagePickerService,
  }) : _billingRepo = billingRepo,
       _baseImagePickerService = baseImagePickerService,
       super(const MakePaymentState());

  final BaseBillingRepo _billingRepo;
  final BaseImagePickerService _baseImagePickerService;

  Future<void> fetchQuote({String? projectId}) async {
    emit(state.copyWith(fetchQuoteStatus: CubitStatus.loading));
    final result = await _billingRepo.getPaymentQuote(
      GetPaymentQuoteRequestModel(projectId: projectId ?? ''),
    );
    result.when(
      success: (quote) => emit(
        state.copyWith(fetchQuoteStatus: CubitStatus.success, quote: quote),
      ),
      failure: (error) => emit(
        state.copyWith(
          fetchQuoteStatus: CubitStatus.error,
          fetchQuoteError: error,
        ),
      ),
    );
  }

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.gallery) {
        return await _baseImagePickerService.pickFromGallery();
      } else {
        return await _baseImagePickerService.pickFromCamera();
      }
    } catch (e, s) {
      AppLogger.instance.logError('pickImage error', error: e, stackTrace: s);
      return null;
    }
  }

  void setReceiptImage(XFile image) {
    emit(state.copyWith(receiptImage: image));
  }

  void removeReceiptImage() {
    emit(state.copyWith(clearReceiptImage: true));
  }

  Future<void> submitPayment({String? projectId, String? notes}) async {
    if (state.receiptImage == null) return;

    emit(state.copyWith(submittingStatus: CubitStatus.loading));
    final result = await _billingRepo.submitPayment(
      SubmitPaymentRequestModel(
        projectId: projectId ?? '',
        receiptPath: state.receiptImage!.path,
      ),
    );
    result.when(
      success: (_) =>
          emit(state.copyWith(submittingStatus: CubitStatus.success)),
      failure: (error) => emit(
        state.copyWith(
          submittingStatus: CubitStatus.error,
          submittingError: error,
        ),
      ),
    );
  }
}
