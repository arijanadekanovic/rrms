import 'package:rrms/_all.dart';

class LanguageModel {
  final String name;
  final String shortName;
  final Locale locale;

  LanguageModel({
    required String code,
    required this.name,
    required this.shortName,
  }) : locale = Locale(code);

  @override
  bool operator ==(other) => other is LanguageModel && other.locale.languageCode == locale.languageCode;

  @override
  int get hashCode => locale.languageCode.hashCode;
}
