import 'package:rrms/_all.dart';

class AccountUpdateRequestModelValidator {
  final TextRequiredValidator textRequiredValidator;
  final PhoneNumberValidator phoneNumberValidator;

  AccountUpdateRequestModelValidator({
    required this.textRequiredValidator,
    required this.phoneNumberValidator,
  });

  String? firstName(AccountUpdateRequestModel? model) => textRequiredValidator.validate(model?.firstName);
  String? lastName(AccountUpdateRequestModel? model) => textRequiredValidator.validate(model?.lastName);
  String? phoneNumber(AccountUpdateRequestModel? model) => phoneNumberValidator.validate(model?.phoneNumber);

  bool validate(model) => ![
        firstName(model),
        lastName(model),
        phoneNumber(model),
      ].any((x) => x != null);
}
