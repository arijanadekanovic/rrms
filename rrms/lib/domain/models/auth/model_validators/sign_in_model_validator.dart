import 'package:rrms/_all.dart';

class SignInRequestModelValidator {
  final TextRequiredValidator textRequiredValidator;
  final PasswordValidator passwordValidator;

  SignInRequestModelValidator({
    required this.textRequiredValidator,
    required this.passwordValidator,
  });

  String? emailOrUserName(SignInRequestModel? model) => textRequiredValidator.validate(model?.emailOrUserName);
  String? password(SignInRequestModel? model) => passwordValidator.validate(model?.password);

  bool validate(model) => ![
        emailOrUserName(model),
        password(model),
      ].any((x) => x != null);
}
