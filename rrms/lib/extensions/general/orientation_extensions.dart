import 'package:rrms/_all.dart';

extension OrientationExtensions on Orientation {
  bool get isPortait => this == Orientation.portrait;
  bool get isLandscape => this == Orientation.landscape;
}
