import 'package:flutter/material.dart';

/// All 8 lifecycle stages a project passes through.
///
/// Matches the SRS stage-gate model — do NOT reorder; ordinal is used for
/// progress calculation.
enum ProjectStatus {
  /// Accountant reviewing complexity and setting price
  awaitingPricing,

  /// Customer sees price; awaiting bank-transfer payment
  awaitingPayment,

  /// Customer uploaded receipt; accountant verifying
  paymentUnderReview,

  /// Ops assigning engineer to the project
  awaitingEngineeringAssignment,

  /// Assigned engineer is actively working
  awaitingEngineering,

  /// Deliverables ready — customer can view / download
  deliverablesReady,

  /// Customer-requested revision in progress
  revisionInProgress,

  /// Project fully completed
  completed,
}

extension ProjectStatusX on ProjectStatus {
  // ── Labels ──────────────────────────────────────────────────────────────────

  String get displayLabel {
    switch (this) {
      case ProjectStatus.awaitingPricing:
        return 'Awaiting Pricing';
      case ProjectStatus.awaitingPayment:
        return 'Awaiting Payment';
      case ProjectStatus.paymentUnderReview:
        return 'Payment Under Review';
      case ProjectStatus.awaitingEngineeringAssignment:
        return 'Awaiting Assignment';
      case ProjectStatus.awaitingEngineering:
        return 'In Progress';
      case ProjectStatus.deliverablesReady:
        return 'Deliverables Ready';
      case ProjectStatus.revisionInProgress:
        return 'Revision In Progress';
      case ProjectStatus.completed:
        return 'Completed';
    }
  }

  String get displayLabelAr {
    switch (this) {
      case ProjectStatus.awaitingPricing:
        return 'في انتظار التسعير';
      case ProjectStatus.awaitingPayment:
        return 'في انتظار الدفع';
      case ProjectStatus.paymentUnderReview:
        return 'الدفع قيد المراجعة';
      case ProjectStatus.awaitingEngineeringAssignment:
        return 'في انتظار التعيين';
      case ProjectStatus.awaitingEngineering:
        return 'قيد التنفيذ';
      case ProjectStatus.deliverablesReady:
        return 'المخرجات جاهزة';
      case ProjectStatus.revisionInProgress:
        return 'مراجعة جارية';
      case ProjectStatus.completed:
        return 'مكتمل';
    }
  }

  // ── Colors ─────────────────────────────────────────────────────────────────

  /// Background color for the status chip.
  Color get chipBackground {
    switch (this) {
      case ProjectStatus.awaitingPricing:
      case ProjectStatus.awaitingPayment:
      case ProjectStatus.awaitingEngineeringAssignment:
        return const Color(0xFFFFF3CD); // amber-light
      case ProjectStatus.paymentUnderReview:
        return const Color(0xFFD1ECF1); // info-light
      case ProjectStatus.awaitingEngineering:
        return const Color(0xFFCCE5FF); // blue-light
      case ProjectStatus.deliverablesReady:
        return const Color(0xFFD4EDDA); // green-light
      case ProjectStatus.revisionInProgress:
        return const Color(0xFFF8D7DA); // red-light
      case ProjectStatus.completed:
        return const Color(0xFFD6D6D6); // grey-light
    }
  }

  /// Text / icon color inside the status chip.
  Color get chipForeground {
    switch (this) {
      case ProjectStatus.awaitingPricing:
      case ProjectStatus.awaitingPayment:
      case ProjectStatus.awaitingEngineeringAssignment:
        return const Color(0xFF856404); // amber-dark
      case ProjectStatus.paymentUnderReview:
        return const Color(0xFF0C5460); // info-dark
      case ProjectStatus.awaitingEngineering:
        return const Color(0xFF004085); // blue-dark
      case ProjectStatus.deliverablesReady:
        return const Color(0xFF155724); // green-dark
      case ProjectStatus.revisionInProgress:
        return const Color(0xFF721C24); // red-dark
      case ProjectStatus.completed:
        return const Color(0xFF383838); // grey-dark
    }
  }

  // ── Progress ───────────────────────────────────────────────────────────────

  /// Overall completion ratio (0.0 – 1.0) for the linear progress indicator.
  double get progressRatio {
    final total = ProjectStatus.values.length - 1; // 7 transitions
    return index / total;
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  bool get isTerminal => this == ProjectStatus.completed;

  bool get isPendingCustomerAction =>
      this == ProjectStatus.awaitingPayment ||
      this == ProjectStatus.deliverablesReady;

  bool get isWaiting =>
      this == ProjectStatus.awaitingPricing ||
      this == ProjectStatus.awaitingEngineeringAssignment ||
      this == ProjectStatus.paymentUnderReview;

  // ── Serialisation ──────────────────────────────────────────────────────────

  static const _jsonMap = {
    'awaiting_pricing':                ProjectStatus.awaitingPricing,
    'awaiting_payment':                ProjectStatus.awaitingPayment,
    'payment_under_review':            ProjectStatus.paymentUnderReview,
    'awaiting_engineering_assignment': ProjectStatus.awaitingEngineeringAssignment,
    'awaiting_engineering':            ProjectStatus.awaitingEngineering,
    'deliverables_ready':              ProjectStatus.deliverablesReady,
    'revision_in_progress':            ProjectStatus.revisionInProgress,
    'completed':                       ProjectStatus.completed,
  };

  String get jsonKey => _jsonMap.entries
      .firstWhere((e) => e.value == this)
      .key;

  static ProjectStatus fromJson(String value) =>
      _jsonMap[value] ?? ProjectStatus.awaitingPricing;
}
