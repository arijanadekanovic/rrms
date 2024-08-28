class ResidentAddRequestModel {
  final DateTime? contractStartDateUtc;
  final DateTime? contractEndDateUtc;
  final int? residenceId;

  ResidentAddRequestModel({
    this.contractStartDateUtc,
    this.contractEndDateUtc,
    this.residenceId,
  });

  ResidentAddRequestModel copyWith({
    DateTime? contractStartDateUtc,
    DateTime? contractEndDateUtc,
    int? residenceId,
  }) {
    return ResidentAddRequestModel(
      contractStartDateUtc: contractStartDateUtc ?? this.contractStartDateUtc,
      contractEndDateUtc: contractEndDateUtc ?? this.contractEndDateUtc,
      residenceId: residenceId ?? this.residenceId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (contractStartDateUtc != null) 'contractStartDateUtc': contractStartDateUtc,
      if (contractEndDateUtc != null) 'contractEndDateUtc': contractEndDateUtc,
      if (residenceId != null) 'residenceId': residenceId,
    };
  }
}
