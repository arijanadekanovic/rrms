extension AppStringNullableExtensions on String? {
  String get value => this ?? '';
  bool get isNullOrEmpty => value.trim() == '';
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
