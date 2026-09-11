import 'package:acrova/data/models/revision/revision_model.dart';
import 'package:equatable/equatable.dart';

/// Navigation arguments for Project Detail Page.
class ProjectDetailArgs extends Equatable {
  const ProjectDetailArgs({required this.id, this.title});

  final String id;
  final String? title;

  @override
  List<Object?> get props => [id, title];
}

/// Navigation arguments for Interior Design Phase 1 Page.
class InteriorDesignArgs extends Equatable {
  const InteriorDesignArgs({required this.projectId});

  final String projectId;

  @override
  List<Object?> get props => [projectId];
}

/// Navigation arguments for Payment Details Page.
class PaymentDetailsArgs extends Equatable {
  const PaymentDetailsArgs({required this.paymentId});

  final String paymentId;

  @override
  List<Object?> get props => [paymentId];
}

/// Navigation arguments for Payment Success Page.
class PaymentSuccessArgs extends Equatable {
  const PaymentSuccessArgs({required this.amount, this.referenceNumber});

  final String amount;
  final String? referenceNumber;

  @override
  List<Object?> get props => [amount, referenceNumber];
}

/// Navigation arguments for Revision Detail Page.
class RevisionDetailArgs extends Equatable {
  const RevisionDetailArgs({this.revision, this.revisionId})
    : assert(
        revision != null || revisionId != null,
        'Either revision or revisionId must be provided',
      );

  final RevisionModel? revision;
  final String? revisionId;

  @override
  List<Object?> get props => [revision, revisionId];
}
