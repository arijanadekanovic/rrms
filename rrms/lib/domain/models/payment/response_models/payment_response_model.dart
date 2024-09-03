import 'package:rrms/_all.dart';

class PaymentResponseModel {
  final double? amount;
  final String? residenceName;
  final String? residentName;
  final DateTime? paymentDate;
  final String? slipUrl;
  final PaymentMethod? paymentMethod;

  PaymentResponseModel({
    this.amount,
    this.residenceName,
    this.residentName,
    this.paymentDate,
    this.slipUrl,
    this.paymentMethod,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      amount: json.parseDouble('amount'),
      residenceName: json.parseValue('residenceName'),
      residentName: json.parseValue('residentName'),
      paymentDate: json.parseDate('paymentDateUtc'),
      slipUrl: json.parseValue('slipUrl'),
      paymentMethod: json.parseEnum('paymentMethod', PaymentMethod.parse),
    );
  }
}
