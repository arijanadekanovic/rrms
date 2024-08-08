import 'package:rrms/_all.dart';

GoRouter appRouter = GoRouter(
  errorBuilder: (_, state) => const AppNavigation(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => const AppNavigation(),
      routes: <RouteBase>[
        GoRoute(
          path: SignUpPage.route.withoutFirstSlash,
          builder: (_, state) => const SignUpPage(),
        ),
      ],
    ),
  ],
);

extension _RouterStringNullableExtensions on String? {
  String get withoutFirstSlash => value.replaceFirst('/', '');
}
