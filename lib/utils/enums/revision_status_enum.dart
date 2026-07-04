/// Lifecycle status of a customer revision request.
enum RevisionStatus {
  inProgress,
  completed,
}

extension RevisionStatusX on RevisionStatus {
  String get displayLabel {
    switch (this) {
      case RevisionStatus.inProgress:
        return 'In Progress';
      case RevisionStatus.completed:
        return 'Completed';
    }
  }

  String get displayLabelAr {
    switch (this) {
      case RevisionStatus.inProgress:
        return 'قيد التنفيذ';
      case RevisionStatus.completed:
        return 'مكتمل';
    }
  }

  String get jsonKey {
    switch (this) {
      case RevisionStatus.inProgress:
        return 'in_progress';
      case RevisionStatus.completed:
        return 'completed';
    }
  }

  bool get isInProgress => this == RevisionStatus.inProgress;

  static RevisionStatus fromJson(String value) {
    return RevisionStatus.values.firstWhere(
      (e) => e.jsonKey == value,
      orElse: () => RevisionStatus.inProgress,
    );
  }
}
