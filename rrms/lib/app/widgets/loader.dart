import 'package:rrms/_all.dart';

class Loader extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const Loader({
    super.key,
    this.width,
    this.height,
    this.color,
  });

  const Loader.sm({
    super.key,
    this.width = 16,
    this.height = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color ?? context.theme.primaryColor),
        ),
      ),
    );
  }
}
