import 'package:equatable/equatable.dart';

class PaymentQuoteResponseModel extends Equatable {
  const PaymentQuoteResponseModel({
    this.projectId,
    this.amountDue,
    this.baseFee,
    this.vat,
    this.total,
    this.currency,
    this.bankName,
    this.iban,
    this.accountName,
  });

  final String? projectId;
  final double? amountDue;
  final double? baseFee;
  final double? vat;
  final double? total;
  final String? currency;
  final String? bankName;
  final String? iban;
  final String? accountName;

  factory PaymentQuoteResponseModel.fromJson(Map<String, dynamic> json) =>
      PaymentQuoteResponseModel(
        projectId: json['projectId']?.toString(),
        amountDue: (json['amountDue'] as num?)?.toDouble(),
        baseFee: (json['baseFee'] as num?)?.toDouble(),
        vat: (json['vat'] as num?)?.toDouble(),
        total: (json['total'] as num?)?.toDouble(),
        currency: json['currency']?.toString(),
        bankName: json['bankName']?.toString(),
        iban: json['iban']?.toString(),
        accountName: json['accountName']?.toString(),
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

  @override
  String toString() {
    return 'PaymentQuoteResponseModel('
        'projectId: $projectId, '
        'amountDue: $amountDue, '
        'total: $total, '
        'currency: $currency'
        ')';
  }
}
