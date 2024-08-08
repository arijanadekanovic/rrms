import 'package:rrms/_all.dart';

extension AppBuildContextX on BuildContext {
  Future<T?> popToBottomAndPushReplacement<T>(String location) async {
    while (appRouter.canPop()) {
      appRouter.pop();
    }

    return await appRouter.pushReplacement(location);
  }

  void popToBottom() {
    while (appRouter.canPop()) {
      appRouter.pop();
    }
  }

  void unfocus() => FocusManager.instance.primaryFocus?.unfocus();
}
