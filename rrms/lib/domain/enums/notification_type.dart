import 'package:rrms/_all.dart';

enum NotificationType {
  payRentSoon(0),
  rentPaid(1);

  final int value;

  const NotificationType([this.value = 0]);

  static NotificationType? parse(int? index) => NotificationType.values.firstOrDefault((x) => x.value == index);

  String get title => switch (this) {
        NotificationType.payRentSoon => 'Pay rent soon',
        NotificationType.rentPaid => 'Rent paid',
      };

  Color color(AppThemeData appTheme) => switch (this) {
        NotificationType.payRentSoon => appTheme.warning,
        NotificationType.rentPaid => appTheme.success,
      };
}
