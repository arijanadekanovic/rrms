// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rrms/_all.dart';

enum PushNotificationType {
  standard(1),
  foregroundWhileAppIsLive(2),
  backgroundWhileAppIsLive(3),
  openedApp(4);

  final int value;

  const PushNotificationType([this.value = 1]);
}

class PushNotificationModel {
  final ChatMessageResponseModel? chatMessage;
  final NotificationResponseModel? notification;
  final PushNotificationType type;

  PushNotificationModel({
    this.chatMessage,
    this.notification,
    required this.type,
  });

  PushNotificationModel copyWith({
    ChatMessageResponseModel? chatMessage,
    NotificationResponseModel? notification,
    PushNotificationType? type,
  }) {
    return PushNotificationModel(
      chatMessage: chatMessage ?? this.chatMessage,
      notification: notification ?? this.notification,
      type: type ?? this.type,
    );
  }

  factory PushNotificationModel.fromJson(Map<String, dynamic> map) {
    return PushNotificationModel(
      chatMessage: map.parse('chatMessage', ChatMessageResponseModel.fromJson),
      notification: map.parse('notification', NotificationResponseModel.fromJson),
      type: PushNotificationType.standard,
    );
  }
}
