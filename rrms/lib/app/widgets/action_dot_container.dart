import 'package:rrms/_all.dart';

class ActionDotContainer extends StatelessWidget {
  final bool visible;
  final Widget child;

  const ActionDotContainer({
    super.key,
    this.visible = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        child,
        if (visible)
          Positioned(
            top: 0,
            right: -10,
            child: Dot(
              activeColor: context.theme.primaryColor,
              size: 10,
            ),
          ),
      ],
    );
  }
}
