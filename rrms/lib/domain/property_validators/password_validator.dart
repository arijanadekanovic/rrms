import 'package:rrms/_all.dart';

class PasswordValidator {
  String? validate(String? value) {
    if (value.isNullOrEmpty) return translations.password_is_required;

    return null;
  }
}
