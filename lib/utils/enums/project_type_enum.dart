/// Type of project the customer is commissioning.
enum ProjectType {
  residentialVilla,
  commercialBuilding,
  mixedUse,
}

extension ProjectTypeX on ProjectType {
  String get displayLabel {
    switch (this) {
      case ProjectType.residentialVilla:   return 'Residential Villa';
      case ProjectType.commercialBuilding: return 'Commercial Building';
      case ProjectType.mixedUse:           return 'Mixed Use';
    }
  }

  String get displayLabelAr {
    switch (this) {
      case ProjectType.residentialVilla:   return 'فيلا سكنية';
      case ProjectType.commercialBuilding: return 'مبنى تجاري';
      case ProjectType.mixedUse:           return 'متعدد الاستخدامات';
    }
  }

  String get jsonKey {
    switch (this) {
      case ProjectType.residentialVilla:   return 'residential_villa';
      case ProjectType.commercialBuilding: return 'commercial_building';
      case ProjectType.mixedUse:           return 'mixed_use';
    }
  }

  static ProjectType fromJson(String value) {
    return ProjectType.values.firstWhere(
      (e) => e.jsonKey == value,
      orElse: () => ProjectType.residentialVilla,
    );
  }
}
