import 'package:rrms/_all.dart';

enum ResidenceType {
  apartment(0),
  house(1),
  land(2),
  bussinessSpace(3);

  final int value;

  const ResidenceType([this.value = 0]);

  static ResidenceType? parse(int? index) => ResidenceType.values.firstOrDefault((x) => x.value == index);
}
