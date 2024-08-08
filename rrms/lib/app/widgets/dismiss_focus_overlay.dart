import 'package:flutter/widgets.dart';

class DismissFocusOverlay extends StatelessWidget {
  final Widget? child;

  const DismissFocusOverlay({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: child,
    );
  }
}
