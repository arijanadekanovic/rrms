import 'package:rrms/_all.dart';

enum NotificationType {
  payRentSoon(0),
  rentPaid(1);

  final int value;

  const NotificationType([this.value = 0]);

  static NotificationType? parse(int? index) => NotificationType.values.firstOrDefault((x) => x.value == index);
}
