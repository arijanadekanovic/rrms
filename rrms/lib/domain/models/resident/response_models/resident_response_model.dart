import 'package:rrms/_all.dart';

class ResidentResponseModel {
  final int? id;
  final DateTime? contractStartDate;
  final DateTime? contractEndDate;
  final ResidentStatus? status;
  final String? userFullName;
  final String? userId;
  final int? residenceId;

  ResidentResponseModel({
    this.id,
    this.contractStartDate,
    this.contractEndDate,
    this.status,
    this.userFullName,
    this.userId,
    this.residenceId,
  });

  factory ResidentResponseModel.fromJson(Map<String, dynamic> json) {
    return ResidentResponseModel(
      id: json.parseValue('id'),
      contractStartDate: json.parseDate('contractStartDateUtc'),
      contractEndDate: json.parseDate('contractEndDateUtc'),
      status: json.parseEnum('status', ResidentStatus.parse),
      userFullName: json.parseValue('userFullName'),
      userId: json.parseValue('userId'),
      residenceId: json.parseValue('residenceId'),
    );
  }
}
