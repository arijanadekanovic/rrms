import 'package:rrms/_all.dart';

class PushNotificationsState implements Event {
  final List<PushNotificationModel> items;

  PushNotificationModel? get lastNotification => items.lastOrDefault();

  PushNotificationModel? get notificationToOpen {
    final last = lastNotification;

    return last?.type == PushNotificationType.openedApp ? last : null;
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
