import '../base_request_model.dart';

class GetPaymentQuoteRequestModel extends BaseRequestModel {
  const GetPaymentQuoteRequestModel({
    required this.projectId,
  });

  final String projectId;

  @override
  Map<String, dynamic> toJson() => {
    'project_id': projectId,
  };

  @override
  List<Object?> get props => [projectId];

  @override
  String toString() {
    return 'GetPaymentQuoteRequestModel(projectId: $projectId)';
  }
}
