enum DeliverableType {
  image(1, 'image'),
  video(2, 'video'),
  pdf(3, 'pdf'),
  document(4, 'document'),
  other(5, 'other');

  final int id;
  final String value;

  const DeliverableType(this.id, this.value);

  /// Resolves an integer ID to [DeliverableType?].
  static DeliverableType? fromId(int? id) {
    if (id == null) return null;
    for (final item in DeliverableType.values) {
      if (item.id == id) return item;
    }
    return null;
  }

  /// Resolves dynamic string or integer input to [DeliverableType?].
  static DeliverableType? fromValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return fromId(value);

    final str = value.toString().trim();
    final parsedInt = int.tryParse(str);
    if (parsedInt != null) {
      final match = fromId(parsedInt);
      if (match != null) return match;
    }

    for (final item in DeliverableType.values) {
      if (item.value.toLowerCase() == str.toLowerCase() ||
          item.name.toLowerCase() == str.toLowerCase()) {
        return item;
      }
    }
    return null;
  }
}

extension DeliverableTypeX on DeliverableType {
  String get jsonKey => value;

  static DeliverableType? fromJson(dynamic key) {
    return DeliverableType.fromValue(key);
  }
}
