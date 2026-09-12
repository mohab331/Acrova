import 'package:equatable/equatable.dart';

/// Free-revision allowance for the current project phase.
class RevisionQuotaModel extends Equatable {
  const RevisionQuotaModel({
    required this.used,
    required this.total,
    required this.paidCost,
    this.currency = 'SAR',
  });

  final int? used;
  final int? total;

  /// Cost of an additional paid revision once the free allowance is exhausted.
  final num? paidCost;
  final String? currency;

  int get remaining => ((total ?? 0) - (used ?? 0)).clamp(0, (total ?? 0));
  bool get hasFreeRemaining => remaining > 0;

  factory RevisionQuotaModel.fromJson(Map<String, dynamic> json) =>
      RevisionQuotaModel(
        used: json['used'],
        total: json['total'],
        paidCost: json['paid_cost'],
        currency: json['currency'],
      );

  @override
  List<Object?> get props => [used, total, paidCost, currency];
}
