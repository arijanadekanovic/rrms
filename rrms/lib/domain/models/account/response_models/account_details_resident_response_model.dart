import 'package:rrms/_all.dart';

class AccountDetailsResidentResponseModel {
  final int? residentId;
  final int? residenceId;
  final double? residencePrice;

  AccountDetailsResidentResponseModel({
    this.residentId,
    this.residenceId,
    this.residencePrice,
  });

  factory AccountDetailsResidentResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountDetailsResidentResponseModel(
      residentId: json.parseValue('residentId'),
      residenceId: json.parseValue('residenceId'),
      residencePrice: json.parseDouble('residencePrice'),
    );
  }
}
