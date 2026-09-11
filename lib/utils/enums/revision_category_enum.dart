/// Category of a requested revision (matches the request-form chips).
enum RevisionCategory {
  layout,
  materials,
  dimensions,
  structural,
  exterior,
  interior,
}

extension RevisionCategoryX on RevisionCategory {
  String get jsonKey => name;

  static RevisionCategory? fromJson(String? value) {
    if (value == null) return null;
    for (final c in RevisionCategory.values) {
      if (c.name == value) return c;
    }
    return null;
  }
}
