import 'package:acrova/data/models/response/billing/payment_response_model.dart';
import 'package:acrova/data/models/response/portfolio/portfolio_item_response_model.dart';
import 'package:acrova/data/models/response/portfolio/walkthrough_response_model.dart';
import 'package:acrova/data/models/response/profile/user_profile_response_model.dart';
import 'package:acrova/data/models/response/project/project_response_model.dart';
import 'package:acrova/data/models/response/revision/revision_response_model.dart';
import 'package:equatable/equatable.dart';

/// Navigation arguments for Project Detail Page.
class ProjectDetailArgs extends Equatable {
  const ProjectDetailArgs({this.id, this.title, this.project});

  final String? id;
  final String? title;
  final ProjectResponseModel? project;

  @override
  List<Object?> get props => [id, title, project];
}

/// Navigation arguments for Interior Design Phase 1 Page.
class InteriorDesignArgs extends Equatable {
  const InteriorDesignArgs({this.projectId});

  final String? projectId;

  @override
  List<Object?> get props => [projectId];
}

/// Navigation arguments for Portfolio Detail Page.
class PortfolioDetailArgs extends Equatable {
  const PortfolioDetailArgs({this.portfolioItem, this.portfolioId});

  final PortfolioItemResponseModel? portfolioItem;
  final String? portfolioId;

  @override
  List<Object?> get props => [portfolioItem, portfolioId];
}

/// Navigation arguments for Edit Profile Page.
class EditProfileArgs extends Equatable {
  const EditProfileArgs({this.profile});

  final UserProfileResponseModel? profile;

  @override
  List<Object?> get props => [profile];
}

/// Navigation arguments for Contact Us Page.
class ContactUsArgs extends Equatable {
  const ContactUsArgs({this.email, this.mobileNumber});

  final String? email;
  final String? mobileNumber;

  @override
  List<Object?> get props => [email, mobileNumber];
}

/// Navigation arguments for Revision Detail Page.
class RevisionDetailArgs extends Equatable {
  const RevisionDetailArgs({this.revision, this.revisionId});

  final RevisionResponseModel? revision;
  final String? revisionId;

  @override
  List<Object?> get props => [revision, revisionId];
}

/// Navigation arguments for Walkthrough Page.
class WalkthroughArgs extends Equatable {
  const WalkthroughArgs({this.walkthrough});

  final WalkthroughResponseModel? walkthrough;

  @override
  List<Object?> get props => [walkthrough];
}

/// Navigation arguments for Payment Details Page.
class PaymentDetailsArgs extends Equatable {
  const PaymentDetailsArgs({this.paymentId, this.payment});

  final String? paymentId;
  final PaymentResponseModel? payment;

  @override
  List<Object?> get props => [paymentId, payment];
}

/// Navigation arguments for Payment Success Page.
class PaymentSuccessArgs extends Equatable {
  const PaymentSuccessArgs({this.amount, this.referenceNumber});

  final String? amount;
  final String? referenceNumber;

  @override
  List<Object?> get props => [amount, referenceNumber];
}

/// Navigation arguments for Make Payment Page.
class MakePaymentArgs extends Equatable {
  const MakePaymentArgs({this.projectId, this.stage});

  final String? projectId;
  final String? stage;

  @override
  List<Object?> get props => [projectId, stage];
}

/// Navigation arguments for PDF Viewer Page.
class PdfViewerArgs extends Equatable {
  const PdfViewerArgs({required this.title, required this.urlOrAsset});

  final String title;
  final String urlOrAsset;

  @override
  List<Object?> get props => [title, urlOrAsset];
}

/// Navigation arguments for Image Viewer Page.
class ImageViewerArgs extends Equatable {
  const ImageViewerArgs({required this.title, required this.urlOrAsset});

  final String title;
  final String urlOrAsset;

  @override
  List<Object?> get props => [title, urlOrAsset];
}
