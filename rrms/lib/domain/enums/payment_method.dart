import 'package:rrms/_all.dart';

enum PaymentMethod {
  paypal(0),
  slip(1);

  final int value;

  const PaymentMethod([this.value = 0]);

  static PaymentMethod? parse(int? index) => PaymentMethod.values.firstOrDefault((x) => x.value == index);
}
