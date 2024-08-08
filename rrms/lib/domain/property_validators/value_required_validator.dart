import 'package:rrms/_all.dart';

class ValueRequiredValidator {
  String? validate(dynamic value, [String? validationMessage]) {
    if (value == null) {
      return validationMessage ?? translations.required;
    }

    return null;
  }
}
