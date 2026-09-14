/// Category of a requested revision (matches the request-form chips).
enum RevisionCategory {
  layout(1, 'layout'),
  materials(2, 'materials'),
  dimensions(3, 'dimensions'),
  structural(4, 'structural'),
  exterior(5, 'exterior'),
  interior(6, 'interior');

  final int id;
  final String value;
  const RevisionCategory(this.id, this.value);

  static RevisionCategory? fromId(int? id) {
    if (id == null) return null;
    for (final item in RevisionCategory.values) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  static RevisionCategory? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final parsed = int.tryParse(value.toString());
    if (parsed != null) return fromId(parsed);
    for (final item in RevisionCategory.values) {
      if (item.value.toLowerCase() == value.toString().toLowerCase() ||
          item.name.toLowerCase() == value.toString().toLowerCase()) {
        return item;
      }
    }
    return null;
  }
}

extension RevisionCategoryX on RevisionCategory {
  String get jsonKey => value;

  static RevisionCategory? fromJson(dynamic value) =>
      RevisionCategory.fromValue(value);
}
