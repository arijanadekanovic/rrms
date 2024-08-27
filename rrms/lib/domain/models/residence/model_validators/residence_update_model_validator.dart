import 'package:rrms/_all.dart';

class ResidenceUpdateRequestModelValidator {
  final ValueRequiredValidator valueRequiredValidator;
  final TextRequiredValidator textRequiredValidator;

  ResidenceUpdateRequestModelValidator({
    required this.valueRequiredValidator,
    required this.textRequiredValidator,
  });

  String? name(ResidenceUpdateRequestModel? model) => textRequiredValidator.validate(model?.name);
  String? address(ResidenceUpdateRequestModel? model) => textRequiredValidator.validate(model?.address);
  String? rooms(ResidenceUpdateRequestModel? model) => valueRequiredValidator.validate(model?.rooms);
  String? size(ResidenceUpdateRequestModel? model) => valueRequiredValidator.validate(model?.size);
  String? rentPrice(ResidenceUpdateRequestModel? model) => valueRequiredValidator.validate(model?.rentPrice);
  String? type(ResidenceUpdateRequestModel? model) => valueRequiredValidator.validate(model?.type);
  String? cityId(ResidenceUpdateRequestModel? model) => valueRequiredValidator.validate(model?.cityId);

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
