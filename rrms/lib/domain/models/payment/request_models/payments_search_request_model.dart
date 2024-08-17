class PaymentsSearchRequestModel {
  final DateTime? fromDateUtc;
  final DateTime? toDateUtc;

  PaymentsSearchRequestModel({
    this.fromDateUtc,
    this.toDateUtc,
  });

  PaymentsSearchRequestModel copyWith({
    DateTime? fromDateUtc,
    DateTime? toDateUtc,
  }) {
    return PaymentsSearchRequestModel(
      fromDateUtc: fromDateUtc ?? this.fromDateUtc,
      toDateUtc: toDateUtc ?? this.toDateUtc,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if(fromDateUtc != null) 'fromDateUtc': fromDateUtc,
      if(toDateUtc != null) 'toDateUtc': toDateUtc,
    };
  }
}
