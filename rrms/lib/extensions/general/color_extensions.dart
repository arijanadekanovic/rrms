import 'package:rrms/_all.dart';

extension HexColor on Color {
  String toHex({bool leadingHashSign = true, bool leadingOpacity = true}) => ''
      '${leadingHashSign ? '#' : ''}'
      '${leadingOpacity ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
