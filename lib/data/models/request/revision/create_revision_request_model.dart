import '../base_request_model.dart';

/// Payload for submitting a new revision request.
class CreateRevisionRequestModel extends BaseRequestModel {
  const CreateRevisionRequestModel({
    required this.details,
    this.deliverableRef,
    this.attachmentPaths = const [],
    this.isPaid = false,
  });

  final String details;
  final String? deliverableRef;
  final List<String> attachmentPaths;

  /// Whether this is a paid revision (free allowance exhausted).
  final bool isPaid;

  @override
  Map<String, dynamic> toJson() => {
    'details': details,
    if (deliverableRef != null) 'deliverable_ref': deliverableRef,
    'attachment_paths': attachmentPaths,
    'is_paid': isPaid,
  };

  @override
  List<Object?> get props => [details, deliverableRef, attachmentPaths, isPaid];

  @override
  String toString() {
    return 'CreateRevisionRequestModel('
        'details: $details, '
        'deliverableRef: $deliverableRef, '
        'isPaid: $isPaid'
        ')';
  }
}
