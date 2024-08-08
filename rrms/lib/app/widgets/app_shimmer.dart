import 'package:rrms/_all.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const AppShimmer([
    this.height = 0,
    this.width = 0,
    this.radius = 4,
  ]);

  static Widget generate(int length, Widget child, [double padding = 0.0]) => Column(
        children: List.generate(
          length,
          (_) => Padding(
            padding: EdgeInsets.only(bottom: padding),
            child: child,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.appTheme.cardBackgroundColor,
      highlightColor: context.appTheme.shimmerHighlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: context.appTheme.cardBackgroundColor,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
