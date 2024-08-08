extension IntExtensions on int? {
  bool between(
    int min,
    int max, {
    bool startInclusive = true,
    bool endInclusive = true,
  }) {
    if (this == null) return false;

    if (startInclusive && endInclusive) return this! >= min && this! <= max;
    if (!startInclusive && endInclusive) return this! > min && this! <= max;
    if (startInclusive && !endInclusive) return this! >= min && this! < max;
    if (!startInclusive && !endInclusive) return this! > min && this! < max;

    return false;
  }

  int get value => this ?? 0;

  String spValue(String titleIfLessThan1, String titleIfGreaterThan1) => value <= 1 ? titleIfLessThan1 : titleIfGreaterThan1;
  int? get orNull => this == 0 ? null : this;
}
