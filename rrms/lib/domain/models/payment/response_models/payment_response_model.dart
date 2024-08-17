import 'package:rrms/_all.dart';

class PaymentResponseModel {
  final double? amount;
  final String? residenceName;
  final String? residentName;
  final DateTime? paymentDate;

  PaymentResponseModel({
    this.amount,
    this.residenceName,
    this.residentName,
    this.paymentDate,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      amount: json.parseDouble('amount'),
      residenceName: json.parseValue('residenceName'),
      residentName: json.parseValue('residentName'),
      paymentDate: json.parseDate('paymentDateUtc'),
    );
  }
}
