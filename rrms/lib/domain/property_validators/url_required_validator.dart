import 'package:rrms/_all.dart';

class UrlRequiredValidator {
  final TextRequiredValidator textRequiredValidator;

  UrlRequiredValidator({
    required this.textRequiredValidator,
  });

  String? validate(dynamic value, [String? validationMessage]) {
    final textRequiredValidatorResult = textRequiredValidator.validate(value, validationMessage);

    if (textRequiredValidatorResult.isNotNullOrEmpty) {
      return textRequiredValidatorResult;
    }

    // CASES FOR VALID URL:
    // https://www.google.com/
    // https://www.google.com
    // http://www.google.com
    // www.google.com
    // google.com
    RegExp regExp = RegExp(r'^(https?://)?'
        r'(www\.)?'
        r'([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*\.)+[a-zA-Z]{2,}'
        r'(/\S*)?$');

    final isValid = regExp.hasMatch(value);

    return isValid ? null : (validationMessage ?? translations.url_is_not_valid);
  }
}
