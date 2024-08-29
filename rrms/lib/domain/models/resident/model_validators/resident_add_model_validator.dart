import 'package:rrms/_all.dart';

class ResidentAddRequestModelValidator {
  final ValueRequiredValidator valueRequiredValidator;

  ResidentAddRequestModelValidator({
    required this.valueRequiredValidator,
  });

  String? contractStartDate(ResidentAddRequestModel? model) => valueRequiredValidator.validate(model?.contractStartDate);
  String? contractEndDate(ResidentAddRequestModel? model) => valueRequiredValidator.validate(model?.contractEndDate);

  bool validate(model) => ![
        contractStartDate(model),
        contractEndDate(model),
      ].any((x) => x != null);
}
