import 'package:rrms/_all.dart';

class NotificationListTile extends StatelessWidget {
  final NotificationResponseModel notification;

  const NotificationListTile({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.appTheme.cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                size: 18,
                color: notification.type?.color(context.appTheme),
              ),
              Gap(5),
              Text(
                notification.title.value,
                style: context.textStyle.t14600,
              ),
            ],
          ),
          Gap(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(notification.description.value),
              ),
              Gap(15),
              Text(
                notification.type?.title ?? '',
                style: context.textStyle.t12500.withColor(notification.type?.color(context.appTheme) ?? context.textStyle.color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
