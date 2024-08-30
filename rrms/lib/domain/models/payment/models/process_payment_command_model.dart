import 'package:rrms/_all.dart';

class ProcessPaymentCommandModel {
  final double? amount;
  final int? residentId;

  ProcessPaymentCommandModel({
    this.amount,
    this.residentId,
  });

  ProcessPaymentCommandModel copyWith({
    double? amount,
    int? residentId,
  }) {
    return ProcessPaymentCommandModel(
      amount: amount ?? this.amount,
      residentId: residentId ?? this.residentId,
    );
  }

  factory ProcessPaymentCommandModel.fromJson(Map<String, dynamic> json) {
    return ProcessPaymentCommandModel(
      amount: json.parseDouble('amount'),
      residentId: json.parseValue('residentId'),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if(amount != null) 'amount': amount,
      if(residentId != null) 'residentId': residentId,
    };
  }
}
