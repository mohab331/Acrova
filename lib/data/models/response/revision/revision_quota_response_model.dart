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
        used: _parseInt(json['used']),
        total: _parseInt(json['total']),
        paidCost: json['paid_cost'] as num?,
        currency: json['currency']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'used': used,
    'total': total,
    'paid_cost': paidCost,
    'currency': currency,
  };

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

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
