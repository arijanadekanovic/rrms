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
      body: Text('Notifications Page'),
    );
  }
}
