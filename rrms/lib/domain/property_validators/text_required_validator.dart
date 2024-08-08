import 'package:rrms/_all.dart';

class TextRequiredValidator {
  String? validate(String? value, [String? validationMessage]) {
    if (value.isNullOrEmpty) {
      return validationMessage ?? translations.required;
    }

    return null;
  }
}
