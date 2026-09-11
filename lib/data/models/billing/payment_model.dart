import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum PaymentStatus { success, pending, rejected }

extension PaymentStatusX on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.success:
        return 'Success';
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.rejected:
        return 'Rejected';
    }
  }

  String localizedName(BuildContext context) {
    switch (this) {
      case PaymentStatus.success:
        return context.localization.paymentStatusSuccess;
      case PaymentStatus.pending:
        return context.localization.paymentStatusPending;
      case PaymentStatus.rejected:
        return context.localization.paymentStatusRejected;
    }
  }

  static PaymentStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return PaymentStatus.success;
      case 'pending':
        return PaymentStatus.pending;
      case 'rejected':
        return PaymentStatus.rejected;
      default:
        return PaymentStatus.pending;
    }
  }
}

class PaymentModel extends Equatable {
  const PaymentModel({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.amount,
    required this.currency,
    required this.status,
    required this.date,
    required this.transactionId,
    required this.bankName,
    required this.iban,
    required this.accountName,
    this.receiptUrl,
    this.rejectionReason,
  });

  final String id;
  final String projectId;
  final String projectName;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final DateTime date;
  final String transactionId;
  final String bankName;
  final String iban;
  final String accountName;
  final String? receiptUrl;
  final String? rejectionReason;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'] as String,
        projectId: json['projectId'] as String,
        projectName: json['projectName'] as String,
        amount: (json['amount'] as num).toDouble(),
        currency: json['currency'] as String? ?? 'SAR',
        status: PaymentStatusX.fromString(json['status'] as String),
        date: DateTime.parse(json['date'] as String),
        transactionId: json['transactionId'] as String,
        bankName: json['bankName'] as String,
        iban: json['iban'] as String,
        accountName: json['accountName'] as String,
        receiptUrl: json['receiptUrl'] as String?,
        rejectionReason: json['rejectionReason'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'projectId': projectId,
        'projectName': projectName,
        'amount': amount,
        'currency': currency,
        'status': status.displayName.toLowerCase(),
        'date': date.toIso8601String(),
        'transactionId': transactionId,
        'bankName': bankName,
        'iban': iban,
        'accountName': accountName,
        'receiptUrl': receiptUrl,
        'rejectionReason': rejectionReason,
      };

  @override
  List<Object?> get props => [
        id,
        projectId,
        projectName,
        amount,
        currency,
        status,
        date,
        transactionId,
        bankName,
        iban,
        accountName,
        receiptUrl,
        rejectionReason,
      ];
}

class PaymentQuoteModel extends Equatable {
  const PaymentQuoteModel({
    required this.amountDue,
    required this.baseFee,
    required this.vat,
    required this.total,
    required this.bankName,
    required this.iban,
    required this.accountName,
    this.currency = 'SAR',
  });

  final double amountDue;
  final double baseFee;
  final double vat;
  final double total;
  final String bankName;
  final String iban;
  final String accountName;
  final String currency;

  @override
  List<Object?> get props => [
        amountDue,
        baseFee,
        vat,
        total,
        bankName,
        iban,
        accountName,
        currency,
      ];
}
