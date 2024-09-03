import 'package:rrms/_all.dart';

class PaymentResponseModel {
  final double? amount;
  final String? residenceName;
  final String? residentName;
  final DateTime? paymentDateUtc;
  final String? slipUrl;
  final PaymentMethod? paymentMethod;

  PaymentResponseModel({
    this.amount,
    this.residenceName,
    this.residentName,
    this.paymentDateUtc,
    this.slipUrl,
    this.paymentMethod,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      amount: json.parseDouble('amount'),
      residenceName: json.parseValue('residenceName'),
      residentName: json.parseValue('residentName'),
      paymentDateUtc: json.parseDate('paymentDateUtc'),
      slipUrl: json.parseValue('slipUrl'),
      paymentMethod: json.parseEnum('paymentMethod', PaymentMethod.parse),
    );
  }
}
