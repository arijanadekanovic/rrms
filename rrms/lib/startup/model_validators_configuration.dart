import 'package:rrms/_all.dart';

class ModelValidatorsConfiguration {
  static void configure() {
    services.registerSingleton<EmailValidator>(EmailValidator());
    services.registerSingleton<PasswordValidator>(PasswordValidator());
    services.registerSingleton<PhoneNumberValidator>(PhoneNumberValidator());
    services.registerSingleton<TextRequiredValidator>(TextRequiredValidator());

    final textRequiredValidator = services.get<TextRequiredValidator>();
    final passwordValidator = services.get<PasswordValidator>();
    final phoneNumberValidator = services.get<PhoneNumberValidator>();
    final emailValidator = services.get<EmailValidator>();

    services.registerSingleton<SignInRequestModelValidator>(SignInRequestModelValidator(textRequiredValidator: textRequiredValidator, passwordValidator: passwordValidator));
    services.registerSingleton<AccountUpdateRequestModelValidator>(AccountUpdateRequestModelValidator(textRequiredValidator: textRequiredValidator, phoneNumberValidator: phoneNumberValidator));
    services.registerSingleton<SignUpRequestModelValidator>(SignUpRequestModelValidator(textRequiredValidator: textRequiredValidator, emailValidator: emailValidator, passwordValidator: passwordValidator));
  }
}
