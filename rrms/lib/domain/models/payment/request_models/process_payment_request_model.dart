class ProcessPaymentRequestModel {
  final double? amount;

  ProcessPaymentRequestModel({
    this.amount,
  });

  ProcessPaymentRequestModel copyWith({
    double? amount,
  }) {
    return ProcessPaymentRequestModel(
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if(amount != null) 'amount': amount,
    };
  }
}
