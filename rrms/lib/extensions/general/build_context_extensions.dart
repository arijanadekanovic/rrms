import 'package:rrms/_all.dart';

extension AppBuildContextX on BuildContext {
  void popToBottom() {
    while (appRouter.canPop()) {
      appRouter.pop();
    }
  }

  void unfocus() => FocusManager.instance.primaryFocus?.unfocus();
}
