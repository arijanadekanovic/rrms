import 'package:rrms/_all.dart';

class PaymentAddRequestModel {
  final double? amount;
  final int? residentId;
  String? slipUrl;
  final PaymentMethod? paymentMethod;
  String? payPalPaymentId;

  final FileInfo? slip;

  PaymentAddRequestModel({
    this.amount,
    this.residentId,
    this.slipUrl,
    this.paymentMethod,
    this.payPalPaymentId,
    this.slip,
  });

  PaymentAddRequestModel copyWith({
    double? amount,
    int? residentId,
    String? slipUrl,
    PaymentMethod? paymentMethod,
    String? payPalPaymentId,
    FileInfo? slip,
  }) {
    return PaymentAddRequestModel(
      amount: amount ?? this.amount,
      residentId: residentId ?? this.residentId,
      slipUrl: slipUrl ?? this.slipUrl,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      payPalPaymentId: payPalPaymentId ?? this.payPalPaymentId,
      slip: slip ?? this.slip,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (amount != null) 'amount': amount,
      if (residentId != null) 'residentId': residentId,
      if (slipUrl != null) 'slipUrl': slipUrl,
      if (paymentMethod != null) 'paymentMethod': paymentMethod?.value,
      if (payPalPaymentId != null) 'payPalPaymentId': payPalPaymentId?.value,
    };
  }
}
