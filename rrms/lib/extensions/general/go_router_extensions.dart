import 'package:rrms/_all.dart';

extension GoRouterX on GoRouter {
  BuildContext? get context => routerDelegate.navigatorKey.currentContext;
}
