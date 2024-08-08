import 'package:rrms/_all.dart';

class SignUpRequestModelValidator {
  final TextRequiredValidator textRequiredValidator;
  final EmailValidator emailValidator;
  final PasswordValidator passwordValidator;

  SignUpRequestModelValidator({
    required this.textRequiredValidator,
    required this.emailValidator,
    required this.passwordValidator,
  });

  String? email(SignUpRequestModel? model) => emailValidator.validate(model?.email);
  String? username(SignUpRequestModel? model) => textRequiredValidator.validate(model?.username);
  String? password(SignUpRequestModel? model) => passwordValidator.validate(model?.password);
  String? firstName(SignUpRequestModel? model) => textRequiredValidator.validate(model?.firstName);
  String? lastName(SignUpRequestModel? model) => textRequiredValidator.validate(model?.lastName);

  bool validate(model) => ![
        email(model),
        username(model),
        password(model),
        firstName(model),
        lastName(model),
      ].any((x) => x != null);
}
