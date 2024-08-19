import 'package:rrms/_all.dart';

import '../features/notifications/notifications_page.dart';

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
        GoRoute(
          path: ResidenceDetailsPage.route.withoutFirstSlash,
          builder: (_, state) => ResidenceDetailsPage(
            residence: state.extra as ResidenceResponseModel,
          ),
        ),
        GoRoute(
          path: NotificationsPage.route.withoutFirstSlash,
          builder: (_, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: ProfileUpdatePage.route.withoutFirstSlash,
          builder: (_, state) => const ProfileUpdatePage(),
        ),
      ],
    ),
  ],
);

extension _RouterStringNullableExtensions on String? {
  String get withoutFirstSlash => value.replaceFirst('/', '');
}
