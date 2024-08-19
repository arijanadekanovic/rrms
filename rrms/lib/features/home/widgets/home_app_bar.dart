import 'package:rrms/_all.dart';

import '../../notifications/notifications_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RRMSAppBar(
      primary: true,
      child: Row(
        children: [
          // TODO: Maybe refactor this logo to align to design
          Image.asset(
            AppAssets.logo,
            height: 30,
            width: 30,
          ),
          const Gap(10),
          Text(
            appSettings.appName,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Push new notifications list page here
            context.push(NotificationsPage.route);
          },
          icon: Icon(
            Icons.notifications_none_rounded,
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
