class PaymentSearchRequestModel {
  final int? residenceId;

  PaymentSearchRequestModel({
    this.residenceId,
  });

  PaymentSearchRequestModel copyWith({
    int? residenceId,
  }) {
    return PaymentSearchRequestModel(
      residenceId: residenceId ?? this.residenceId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (residenceId != null) 'residenceId': residenceId,
    };
  }
}
