import 'package:acrova/utils/enums/payment_status_enum.dart';
import 'package:equatable/equatable.dart';

export 'package:acrova/utils/enums/payment_status_enum.dart';

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
        status: PaymentStatus.fromValue(json['status']),
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
    'status_id': status?.id,
    'status': status?.id,
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
