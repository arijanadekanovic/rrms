import 'package:rrms/_all.dart';

class ResidenceAddRequestModelValidator {
  final ValueRequiredValidator valueRequiredValidator;
  final TextRequiredValidator textRequiredValidator;

  ResidenceAddRequestModelValidator({
    required this.valueRequiredValidator,
    required this.textRequiredValidator,
  });

  String? name(ResidenceAddRequestModel? model) => textRequiredValidator.validate(model?.name);
  String? address(ResidenceAddRequestModel? model) => textRequiredValidator.validate(model?.address);
  String? rooms(ResidenceAddRequestModel? model) => valueRequiredValidator.validate(model?.rooms);
  String? size(ResidenceAddRequestModel? model) => valueRequiredValidator.validate(model?.size);
  String? rentPrice(ResidenceAddRequestModel? model) => valueRequiredValidator.validate(model?.rentPrice);
  String? type(ResidenceAddRequestModel? model) => valueRequiredValidator.validate(model?.type);
  String? cityId(ResidenceAddRequestModel? model) => valueRequiredValidator.validate(model?.cityId);

  bool validate(model) => ![
        name(model),
        address(model),
        rooms(model),
        size(model),
        rentPrice(model),
        type(model),
        cityId(model),
      ].any((x) => x != null);
}
