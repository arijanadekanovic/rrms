import 'package:rrms/_all.dart';

class PhoneNumberValidator {
  String? validate(String? value, [bool isRequired = false]) {
    if (isRequired && value.isNullOrEmpty) {
      return translations.required;
    }

    if (!_isPhoneNumber(value)) {
      return 'Phone number is not valid';
    }

    return null;
  }

  // Valid phone number: +38761589885
  // Valid phone number: +387 61 589 885
  // Valid phone number: 061589885
  // Valid phone number: 061 589 885

  // Invalid phone number: 1 589 885
  // Invalid phone number: abasas5131a
  // Invalid phone number: +Adas32das2

  // Seems that this (+38761589885) is invalid phone number based on the provided regex, but it's actually a valid number

  bool _isPhoneNumber(String? value) {
    final pattern = r'^(?:\+387)?\s?\d{2,3}\s?\d{2,3}\s?\d{2,4}\s?\d{0,3}$';
    return value != null && RegExp(pattern).hasMatch(value.trim());
  }
}
