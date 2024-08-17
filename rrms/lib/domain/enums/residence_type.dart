import 'package:rrms/_all.dart';

enum ResidenceType {
  residencetype0(0),
  residencetype1(1),
  residencetype2(2),
  residencetype3(3);

  final int value;

  const ResidenceType([this.value = 0]);

  static ResidenceType? parse(int? index) => ResidenceType.values.firstOrDefault((x) => x.value == index);
}
