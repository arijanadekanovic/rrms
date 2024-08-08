import 'package:rrms/_all.dart';

class AppVisibilityContainer extends StatelessWidget {
  final bool? visible;
  final Widget child;

  const AppVisibilityContainer({
    super.key,
    this.visible = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible.value) {
      return const SizedBox();
    }

    return child;
  }
}
