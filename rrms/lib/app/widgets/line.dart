import 'package:rrms/_all.dart';

enum LineOrientation { vertical, horizontal }

class Line extends StatelessWidget {
  final LineOrientation? orientation;
  final double? thickness;
  final double? lenght;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const Line.vertical({super.key, this.thickness, this.lenght, this.color, this.padding, this.borderRadius}) : orientation = LineOrientation.vertical;
  const Line.horizontal({super.key, this.thickness, this.lenght, this.color, this.padding, this.borderRadius}) : orientation = LineOrientation.horizontal;

  @override
  Widget build(BuildContext context) {
    final child = () {
      final decoration = BoxDecoration(color: color ?? context.appTheme.separator, borderRadius: borderRadius);

      if (orientation == LineOrientation.vertical) {
        return Container(decoration: decoration, width: thickness ?? 1, height: lenght);
      }

      return Container(decoration: decoration, height: thickness ?? 1, width: lenght);
    }();

    return padding != null ? Padding(padding: padding!, child: child) : child;
  }
}
