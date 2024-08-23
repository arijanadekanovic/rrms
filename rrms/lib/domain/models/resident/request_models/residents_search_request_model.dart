class ResidentsSearchRequestModel {
  final int? residenceId;

  ResidentsSearchRequestModel({
    this.residenceId,
  });

  ResidentsSearchRequestModel copyWith({
    int? residenceId,
  }) {
    return ResidentsSearchRequestModel(
      residenceId: residenceId ?? this.residenceId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if(residenceId != null) 'residenceId': residenceId,
    };
  }
}
