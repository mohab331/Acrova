import 'package:acrova/utils/enums/revision_category_enum.dart';

import '../base_request_model.dart';

export 'package:acrova/utils/enums/revision_category_enum.dart';

/// Payload for submitting a new revision request.
class CreateRevisionRequestModel extends BaseRequestModel {
  const CreateRevisionRequestModel({
    required this.details,
    this.deliverableRef,
    this.attachmentPaths = const [],
    this.isPaid = false,
    this.category,
  });

  final String details;
  final String? deliverableRef;
  final List<String> attachmentPaths;

  /// Whether this is a paid revision (free allowance exhausted).
  final bool isPaid;

  final RevisionCategory? category;

  @override
  Map<String, dynamic> toJson() => {
    'details': details,
    if (deliverableRef != null) 'deliverable_ref': deliverableRef,
    'attachment_paths': attachmentPaths,
    'is_paid': isPaid,
    if (category != null) ...{
      'category_id': category!.id,
      'category': category!.id,
    },
  };

  @override
  List<Object?> get props => [
    details,
    deliverableRef,
    attachmentPaths,
    isPaid,
    category,
  ];

  @override
  String toString() {
    return 'CreateRevisionRequestModel('
        'details: $details, '
        'category: $category, '
        'deliverableRef: $deliverableRef, '
        'isPaid: $isPaid'
        ')';
  }
}
