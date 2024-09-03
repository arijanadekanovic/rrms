import 'package:rrms/_all.dart';

class PushNotificationsAppWidgetListener extends StatefulWidget {
  final Widget? child;

  const PushNotificationsAppWidgetListener({
    super.key,
    this.child,
  });

  @override
  State<PushNotificationsAppWidgetListener> createState() => _PushNotificationsAppWidgetListenerState();
}

class _PushNotificationsAppWidgetListenerState extends State<PushNotificationsAppWidgetListener> {
  @override
  void initState() {
    super.initState();

    _maybeOpenNotificationDetails(context.read<PushNotificationsCubit>().state.notificationToOpen);
  }

  void _maybeOpenNotificationDetails(PushNotificationModel? notification) {
    final isAuthenticated = context.read<AuthCubit>().state.status == AuthStateStatus.authenticated;

    print('notification != null && isAuthenticated: ${notification != null} | ${isAuthenticated}');

    if (notification != null && isAuthenticated) {
      // TODO: PUSH CHAT DETAILS PAGE
      print('NEW NOTIFICATION HERE');
      // appRouter.go(NotificationDetailsPage.route, extra: notification);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PushNotificationsCubit, PushNotificationsState>(
      listener: (context, pushNotificationsState) => _maybeOpenNotificationDetails(pushNotificationsState.notificationToOpen),
      child: widget.child,
    );
  }
}
