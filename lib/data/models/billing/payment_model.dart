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

  static PaymentStatus fromString(String status) {
    return PaymentStatus.fromValue(status) ?? PaymentStatus.pending;
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
    if (receiptUrl != null) 'receiptUrl': receiptUrl,
    if (rejectionReason != null) 'rejectionReason': rejectionReason,
  };

  PaymentModel copyWith({
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
    return PaymentModel(
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
}

class PaymentQuoteModel extends Equatable {
  const PaymentQuoteModel({
    required this.projectId,
    required this.amountDue,
    required this.baseFee,
    required this.vat,
    required this.total,
    required this.currency,
    required this.bankName,
    required this.iban,
    required this.accountName,
  });

  final String projectId;
  final double amountDue;
  final double baseFee;
  final double vat;
  final double total;
  final String currency;
  final String bankName;
  final String iban;
  final String accountName;

  factory PaymentQuoteModel.fromJson(Map<String, dynamic> json) =>
      PaymentQuoteModel(
        projectId: json['projectId'] as String,
        amountDue: (json['amountDue'] as num).toDouble(),
        baseFee: (json['baseFee'] as num).toDouble(),
        vat: (json['vat'] as num).toDouble(),
        total: (json['total'] as num).toDouble(),
        currency: json['currency'] as String? ?? 'SAR',
        bankName: json['bankName'] as String,
        iban: json['iban'] as String,
        accountName: json['accountName'] as String,
      );

  Map<String, dynamic> toJson() => {
    'projectId': projectId,
    'amountDue': amountDue,
    'baseFee': baseFee,
    'vat': vat,
    'total': total,
    'currency': currency,
    'bankName': bankName,
    'iban': iban,
    'accountName': accountName,
  };

  @override
  List<Object?> get props => [
    projectId,
    amountDue,
    baseFee,
    vat,
    total,
    currency,
    bankName,
    iban,
    accountName,
  ];
}
