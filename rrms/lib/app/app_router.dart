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
        GoRoute(
          path: ResidenceDetailsPage.route.withoutFirstSlash,
          builder: (_, state) => ResidenceDetailsPage(
            residence: state.extra as ResidenceResponseModel,
          ),
        ),
        GoRoute(
          path: MyResidenceDetailsPage.route.withoutFirstSlash,
          builder: (_, state) => MyResidenceDetailsPage(
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
        GoRoute(
          path: ResidenceAddPage.route.withoutFirstSlash,
          builder: (_, state) => const ResidenceAddPage(),
        ),
        GoRoute(
          path: ResidenceUpdatePage.route.withoutFirstSlash,
          builder: (_, state) => ResidenceUpdatePage(id: state.extra as int),
        ),
        GoRoute(
          path: ChatMessagesPage.route.withoutFirstSlash,
          builder: (_, state) => ChatMessagesPage(
            searchModel: state.extra as ChatMessagesSearchRequestModel,
          ),
        ),
      ],
    ),
  ],
);

extension _RouterStringNullableExtensions on String? {
  String get withoutFirstSlash => value.replaceFirst('/', '');
}
