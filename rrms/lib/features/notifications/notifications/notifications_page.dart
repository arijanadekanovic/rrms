import 'package:rrms/_all.dart';

class NotificationsPage extends StatelessWidget {
  static const route = '/notifications';

  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const RRMSAppBar(
        title: 'Notifications',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocProvider(
          create: (context) => services.get<NotificationsCubit>()..load(),
          child: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, notificationsState) {
              if (notificationsState.status == NotificationsStateStatus.loading && notificationsState.notifications.isNullOrEmpty) {
                return Loader();
                // return NotificationsShimmer();
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                itemCount: notificationsState.notifications.count,
                itemBuilder: (context, index) {
                  return NotificationListTile(notification: notificationsState.notifications[index]);
                },
                separatorBuilder: (BuildContext context, int index) => const Gap(15),
              );
            },
          ),
        ),
      ),
    );
  }
}
