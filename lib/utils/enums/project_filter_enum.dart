enum ProjectFilter {
  all(0),
  active(1),
  completed(2);

  final int id;
  const ProjectFilter(this.id);

  static ProjectFilter? fromId(int? id) {
    if (id == null) return null;
    for (final item in ProjectFilter.values) {
      if (item.id == id) return item;
    }
    return null;
  }
}
