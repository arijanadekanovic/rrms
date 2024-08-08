import 'package:rrms/_all.dart';

class Clickable extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final BorderRadius? borderRadius;
  final Color? splashColor;

  const Clickable({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        child,
        Positioned.fill(
          child: Material(
            borderRadius: borderRadius,
            color: Colors.transparent,
            child: InkWell(
              splashColor: splashColor,
              borderRadius: borderRadius,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
