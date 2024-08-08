import 'package:rrms/_all.dart';

class EmailValidator {
  String? validate(String? value) {
    if (value.isNullOrEmpty) {
      return translations.email_is_required;
    }

    if (!_isEmail(value)) {
      return translations.email_is_not_valid;
    }

    return null;
  }

  bool _isEmail(String? value) => value.isNotNullOrEmpty && RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value.value);
}
