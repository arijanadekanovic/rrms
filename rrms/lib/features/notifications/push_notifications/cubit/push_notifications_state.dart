import 'package:rrms/_all.dart';

class PushNotificationsState {
  final List<PushNotificationModel> items;

  PushNotificationModel? get notificationToOpen {
    final lastNotification = items.lastOrDefault();

    return lastNotification?.type == PushNotificationType.openedApp ? lastNotification : null;
  }

  PushNotificationsState({
    required this.items,
  });

  factory PushNotificationsState.initial() => PushNotificationsState(
        items: [],
      );

  PushNotificationsState copyWith({
    List<PushNotificationModel>? items,
  }) =>
      PushNotificationsState(
        items: items ?? this.items,
      );
}
