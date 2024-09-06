import 'package:rrms/_all.dart';

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
          Image.asset(
            AppAssets.logo,
            height: 70,
            width: 70,
          ),
          const Gap(10),
          Text(
            appSettings.appName,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => context.push(NotificationsPage.route),
          icon: Icon(
            Icons.notifications_none_rounded,
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
