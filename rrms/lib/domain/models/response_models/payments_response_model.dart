import 'package:rrms/_all.dart';

class PaymentsResponseModel {
  final double? amount;
  final String? residenceName;
  final String? residentName;
  final DateTime? paymentDate;

  PaymentsResponseModel({
    this.amount,
    this.residenceName,
    this.residentName,
    this.paymentDate,
  });

  factory PaymentsResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentsResponseModel(
      amount: json.parseDouble('amount'),
      residenceName: json.parseValue('residenceName'),
      residentName: json.parseValue('residentName'),
      paymentDate: json.parseDate('paymentDate'),
    );
  }
}
