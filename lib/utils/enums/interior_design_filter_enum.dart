/// Filter tabs for Interior Design requests list.
enum InteriorDesignFilter {
  all(0),
  active(1),
  completed(2);

  final int id;
  const InteriorDesignFilter(this.id);

  static InteriorDesignFilter? fromId(int? id) {
    if (id == null) return null;
    for (final item in InteriorDesignFilter.values) {
      if (item.id == id) return item;
    }
    return null;
  }

  static InteriorDesignFilter? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);
    final str = value.toString().trim().toLowerCase();
    final parsedInt = int.tryParse(str);
    if (parsedInt != null) return fromId(parsedInt);
    for (final item in InteriorDesignFilter.values) {
      if (item.name.toLowerCase() == str) return item;
    }
    return null;
  }
}
