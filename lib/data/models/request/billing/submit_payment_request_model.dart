import '../base_request_model.dart';

class SubmitPaymentRequestModel extends BaseRequestModel {
  const SubmitPaymentRequestModel({
    required this.projectId,
    required this.receiptPath,
    this.notes,
  });

  final String projectId;
  final String receiptPath;
  final String? notes;

  @override
  Map<String, dynamic> toJson() => {
    'project_id': projectId,
    'receipt_path': receiptPath,
    if (notes != null) 'notes': notes,
  };

  @override
  List<Object?> get props => [projectId, receiptPath, notes];

  @override
  String toString() {
    return 'SubmitPaymentRequestModel('
        'projectId: $projectId, '
        'receiptPath: $receiptPath, '
        'notes: $notes'
        ')';
  }
}
