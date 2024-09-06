extension IntExtensions on int? {
  int get value => this ?? 0;

  String spValue(String titleIfLessThanOrEqualTo1, String titleIfGreaterThan1) => value <= 1 ? titleIfLessThanOrEqualTo1 : titleIfGreaterThan1;
}
