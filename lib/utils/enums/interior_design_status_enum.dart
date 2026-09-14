import 'package:flutter/material.dart';

/// All lifecycle stages an Interior Design request passes through.
///
/// Matches the Acrova stage-gate model:
/// 1: Awaiting Pricing
/// 2: Awaiting Payment
/// 3: Payment Under Review
/// 4: In Progress
/// 5: Concept Ready
/// 6: Revision In Progress
/// 7: Completed
enum InteriorDesignStatus {
  awaitingPricing(1),
  awaitingPayment(2),
  paymentUnderReview(3),
  inProgress(4),
  conceptReady(5),
  revisionInProgress(6),
  completed(7);

  const InteriorDesignStatus(this.id);

  final int id;

  /// Returns the corresponding [InteriorDesignStatus] for a given integer [id],
  /// or `null` if the id does not match any status.
  static InteriorDesignStatus? fromId(int? id) {
    if (id == null) return null;
    for (final status in InteriorDesignStatus.values) {
      if (status.id == id) return status;
    }
    return null;
  }

  /// Resolves [InteriorDesignStatus] from an int id, numeric string, or name string.
  /// Returns `null` if value cannot be mapped.
  static InteriorDesignStatus? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return fromId(parsed);
      for (final status in InteriorDesignStatus.values) {
        if (status.name.toLowerCase() == value.toLowerCase()) {
          return status;
        }
      }
    }
    return null;
  }

  static InteriorDesignStatus? fromJson(dynamic json) => fromValue(json);
}

extension InteriorDesignStatusX on InteriorDesignStatus {
  // ── Labels ──────────────────────────────────────────────────────────────────

  String get displayLabel {
    switch (this) {
      case InteriorDesignStatus.awaitingPricing:
        return 'Awaiting Pricing';
      case InteriorDesignStatus.awaitingPayment:
        return 'Awaiting Payment';
      case InteriorDesignStatus.paymentUnderReview:
        return 'Payment Under Review';
      case InteriorDesignStatus.inProgress:
        return 'In Progress';
      case InteriorDesignStatus.conceptReady:
        return 'Concepts Ready';
      case InteriorDesignStatus.revisionInProgress:
        return 'Revision In Progress';
      case InteriorDesignStatus.completed:
        return 'Completed';
    }
  }

  String get displayLabelAr {
    switch (this) {
      case InteriorDesignStatus.awaitingPricing:
        return 'في انتظار التسعير';
      case InteriorDesignStatus.awaitingPayment:
        return 'في انتظار الدفع';
      case InteriorDesignStatus.paymentUnderReview:
        return 'الدفع قيد المراجعة';
      case InteriorDesignStatus.inProgress:
        return 'قيد التنفيذ';
      case InteriorDesignStatus.conceptReady:
        return 'المفاهيم جاهزة';
      case InteriorDesignStatus.revisionInProgress:
        return 'مراجعة جارية';
      case InteriorDesignStatus.completed:
        return 'مكتمل';
    }
  }

  // ── Colors ──────────────────────────────────────────────────────────────────

  /// Background color for the status chip.
  Color get chipBackground {
    switch (this) {
      case InteriorDesignStatus.awaitingPricing:
      case InteriorDesignStatus.awaitingPayment:
        return const Color(0xFFFFF3CD); // amber-light
      case InteriorDesignStatus.paymentUnderReview:
        return const Color(0xFFD1ECF1); // info-light
      case InteriorDesignStatus.inProgress:
        return const Color(0xFFCCE5FF); // blue-light
      case InteriorDesignStatus.conceptReady:
        return const Color(0xFFE2E3E5); // platinum-light
      case InteriorDesignStatus.revisionInProgress:
        return const Color(0xFFF8D7DA); // red-light
      case InteriorDesignStatus.completed:
        return const Color(0xFFD4EDDA); // green-light
    }
  }

  /// Text / icon color inside the status chip.
  Color get chipForeground {
    switch (this) {
      case InteriorDesignStatus.awaitingPricing:
      case InteriorDesignStatus.awaitingPayment:
        return const Color(0xFF856404); // amber-dark
      case InteriorDesignStatus.paymentUnderReview:
        return const Color(0xFF0C5460); // info-dark
      case InteriorDesignStatus.inProgress:
        return const Color(0xFF004085); // blue-dark
      case InteriorDesignStatus.conceptReady:
        return const Color(0xFF383D41); // dark grey
      case InteriorDesignStatus.revisionInProgress:
        return const Color(0xFF721C24); // red-dark
      case InteriorDesignStatus.completed:
        return const Color(0xFF155724); // green-dark
    }
  }

  // ── Lifecycle Metrics ────────────────────────────────────────────────────────

  /// Progression ratio from 0.14 to 1.0 based on ordinal stage.
  double get progressRatio => id / InteriorDesignStatus.values.length;

  /// Percentage value (0 - 100).
  int get progressPercentage => (progressRatio * 100).round();

  /// Whether this is a terminal lifecycle state.
  bool get isTerminal => this == InteriorDesignStatus.completed;

  /// Whether user action (e.g. payment) is required.
  bool get requiresAction => this == InteriorDesignStatus.awaitingPayment;
}
