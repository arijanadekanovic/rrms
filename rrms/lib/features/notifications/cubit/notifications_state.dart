import 'package:rrms/_all.dart';

enum NotificationsStateStatus {
  loading,
  loaded,
}

class NotificationsState {
  final NotificationsStateStatus status;
  final List<NotificationResponseModel> notifications;

  NotificationsState({
    required this.status,
    required this.notifications,
  });

  factory NotificationsState.initial() => NotificationsState(
        status: NotificationsStateStatus.loaded,
        notifications: [],
      );

  NotificationsState copyWith({
    NotificationsStateStatus? status,
    List<NotificationResponseModel>? notifications,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
    );
  }
}
