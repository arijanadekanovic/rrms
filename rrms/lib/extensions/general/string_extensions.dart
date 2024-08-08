import 'package:rrms/_all.dart';

extension AppStringNullableExtensions on String? {
  String get value => this ?? '';
  int get count => value.length;
  String or(String other) => isNotNullOrEmpty ? value : other;
  bool get isNullOrEmpty => value.trim() == '';
  bool get isNotNullOrEmpty => !isNullOrEmpty;
  bool get isNumeric => value.isNotNullOrEmpty && double.tryParse(value.value) != null;
  String cut([int maxLength = 10, bool withDots = true]) => this == null
      ? value
      : count < maxLength
          ? value
          : '${this?.substring(0, maxLength)}${withDots ? '...' : ''}';
  String get trimSpaces => value.replaceAll(RegExp(r'\s+'), ' ');
  String trimIfOnlyChar(String char) => value.split('').any((x) => x != char && x != ' ') ? value : '';
  Color toColor() => Color(hexToInteger('FF$value'));
  bool get isImageFileType => _imageFileExtensions.any((extension) => value.endsWith(extension));
}

bool isNullOrEmpty(String? text) => text.isNullOrEmpty;
bool isNotNullOrEmpty(String? text) => text.isNotNullOrEmpty;
int hexToInteger(String hex) => int.parse(hex, radix: 16);

List<String> _imageFileExtensions = [
  '.jpg',
  '.jpeg',
  '.png',
  '.gif',
];
