import 'package:equatable/equatable.dart';

/// Free-revision allowance for the current project phase.
class RevisionQuotaModel extends Equatable {
  const RevisionQuotaModel({
    required this.used,
    required this.total,
    required this.paidCost,
    this.currency = 'SAR',
  });

  final int used;
  final int total;

  /// Cost of an additional paid revision once the free allowance is exhausted.
  final num paidCost;
  final String currency;

  int get remaining => (total - used).clamp(0, total);
  bool get hasFreeRemaining => remaining > 0;

  factory RevisionQuotaModel.fromJson(Map<String, dynamic> json) =>
      RevisionQuotaModel(
        used: json['used'] as int? ?? 0,
        total: json['total'] as int? ?? 0,
        paidCost: json['paid_cost'] as num? ?? 0,
        currency: json['currency'] as String? ?? 'SAR',
      );

  Map<String, dynamic> toJson() => {
        'used': used,
        'total': total,
        'paid_cost': paidCost,
        'currency': currency,
      };

  @override
  List<Object?> get props => [used, total, paidCost, currency];
}
