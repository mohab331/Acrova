/// Type of project the customer is commissioning.
enum ProjectType {
  villa,
  houseApartment,
  commercial,
}

extension ProjectTypeX on ProjectType {
  String get displayLabel {
    switch (this) {
      case ProjectType.villa:          return 'Villa';
      case ProjectType.houseApartment: return 'House / Apartment';
      case ProjectType.commercial:     return 'Commercial';
    }
  }

  String get displayLabelAr {
    switch (this) {
      case ProjectType.villa:          return 'فيلا';
      case ProjectType.houseApartment: return 'منزل / شقة';
      case ProjectType.commercial:     return 'تجاري';
    }
  }

  String get jsonKey {
    switch (this) {
      case ProjectType.villa:          return 'villa';
      case ProjectType.houseApartment: return 'house_apartment';
      case ProjectType.commercial:     return 'commercial';
    }
  }

  static ProjectType fromJson(String value) {
    return ProjectType.values.firstWhere(
      (e) => e.jsonKey == value,
      orElse: () => ProjectType.villa,
    );
  }
}
