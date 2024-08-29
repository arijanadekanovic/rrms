import 'package:rrms/_all.dart';

class ResidentAddRequestModel {
  final DateTime? contractStartDate;
  final DateTime? contractEndDate;
  final int? residenceId;

  ResidentAddRequestModel({
    this.contractStartDate,
    this.contractEndDate,
    this.residenceId,
  });

  ResidentAddRequestModel copyWith({
    DateTime? contractStartDate,
    DateTime? contractEndDate,
    int? residenceId,
  }) {
    return ResidentAddRequestModel(
      contractStartDate: contractStartDate ?? this.contractStartDate,
      contractEndDate: contractEndDate ?? this.contractEndDate,
      residenceId: residenceId ?? this.residenceId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (contractStartDate != null) 'contractStartDateUtc': contractStartDate?.toUtc().toJson(),
      if (contractEndDate != null) 'contractEndDateUtc': contractEndDate?.toUtc().toJson(),
      if (residenceId != null) 'residenceId': residenceId,
    };
  }
}
