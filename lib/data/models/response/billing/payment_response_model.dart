import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum PaymentStatus {
  success('success'),
  pending('pending'),
  rejected('rejected');

  final String value;
  const PaymentStatus(this.value);

  static PaymentStatus? fromValue(String? value) {
    if (value == null) return null;
    for (final item in PaymentStatus.values) {
      if (item.value.toLowerCase() == value.toLowerCase() ||
          item.name.toLowerCase() == value.toLowerCase()) {
        return item;
      }
    }
    return null;
  }
}

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

  Color get color {
    switch (this) {
      case PaymentStatus.success:
        return Resources.colors.luxurySuccess;
      case PaymentStatus.rejected:
        return Resources.colors.luxuryError;
      case PaymentStatus.pending:
        return Resources.colors.luxuryWarning;
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentStatus.success:
        return Icons.check_circle;
      case PaymentStatus.rejected:
        return Icons.error;
      case PaymentStatus.pending:
        return Icons.schedule;
    }
  }

  Color get backgroundColor => color.withValues(alpha: 0.1);

  static PaymentStatus? fromString(String? status) {
    return PaymentStatus.fromValue(status);
  }
}

class PaymentResponseModel extends Equatable {
  const PaymentResponseModel({
    this.id,
    this.projectId,
    this.projectName,
    this.amount,
    this.currency,
    this.status,
    this.date,
    this.transactionId,
    this.bankName,
    this.iban,
    this.accountName,
    this.receiptUrl,
    this.rejectionReason,
  });

  final String? id;
  final String? projectId;
  final String? projectName;
  final double? amount;
  final String? currency;
  final PaymentStatus? status;
  final DateTime? date;
  final String? transactionId;
  final String? bankName;
  final String? iban;
  final String? accountName;
  final String? receiptUrl;
  final String? rejectionReason;

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      PaymentResponseModel(
        id: json['id']?.toString(),
        projectId: json['projectId']?.toString(),
        projectName: json['projectName']?.toString(),
        amount: (json['amount'] as num?)?.toDouble(),
        currency: json['currency']?.toString(),
        status: PaymentStatusX.fromString(json['status']?.toString()),
        date: json['date'] != null
            ? DateTime.tryParse(json['date'].toString())
            : null,
        transactionId: json['transactionId']?.toString(),
        bankName: json['bankName']?.toString(),
        iban: json['iban']?.toString(),
        accountName: json['accountName']?.toString(),
        receiptUrl: json['receiptUrl']?.toString(),
        rejectionReason: json['rejectionReason']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'projectName': projectName,
    'amount': amount,
    'currency': currency,
    'status': status?.displayName.toLowerCase(),
    'date': date?.toIso8601String(),
    'transactionId': transactionId,
    'bankName': bankName,
    'iban': iban,
    'accountName': accountName,
    if (receiptUrl != null) 'receiptUrl': receiptUrl,
    if (rejectionReason != null) 'rejectionReason': rejectionReason,
  };

  PaymentResponseModel copyWith({
    String? id,
    String? projectId,
    String? projectName,
    double? amount,
    String? currency,
    PaymentStatus? status,
    DateTime? date,
    String? transactionId,
    String? bankName,
    String? iban,
    String? accountName,
    String? receiptUrl,
    String? rejectionReason,
  }) {
    return PaymentResponseModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      date: date ?? this.date,
      transactionId: transactionId ?? this.transactionId,
      bankName: bankName ?? this.bankName,
      iban: iban ?? this.iban,
      accountName: accountName ?? this.accountName,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

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

  @override
  String toString() {
    return 'PaymentResponseModel('
        'id: $id, '
        'projectName: $projectName, '
        'amount: $amount, '
        'currency: $currency, '
        'status: $status'
        ')';
  }
}
