import 'package:equatable/equatable.dart';

/// Free-revision allowance for the current project phase.
class RevisionQuotaResponseModel extends Equatable {
  const RevisionQuotaResponseModel({
    this.used,
    this.total,
    this.paidCost,
    this.currency,
  });

  final int? used;
  final int? total;

  /// Cost of an additional paid revision once the free allowance is exhausted.
  final num? paidCost;
  final String? currency;

  int get remaining => ((total ?? 0) - (used ?? 0)).clamp(0, (total ?? 0));
  bool get hasFreeRemaining => remaining > 0;

  factory RevisionQuotaResponseModel.fromJson(Map<String, dynamic> json) =>
      RevisionQuotaResponseModel(
        used: int.tryParse(json['used'].toString()),
        total: int.tryParse(json['total'].toString()),
        paidCost: json['paid_cost'] as num?,
        currency: json['currency']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'used': used,
    'total': total,
    'paid_cost': paidCost,
    'currency': currency,
  };

  @override
  List<Object?> get props => [used, total, paidCost, currency];

  @override
  String toString() {
    return 'RevisionQuotaResponseModel('
        'used: $used, '
        'total: $total, '
        'remaining: $remaining'
        ')';
  }
}
