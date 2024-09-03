import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rrms/_all.dart';

abstract class PushNotificationsService {
  late StreamController<PushNotificationModel> pushNotifications;
  Future<void> init();
  Future<void> dispose();
}

class PushNotificationsServiceImpl implements PushNotificationsService {
  final RestApiClient restApiClient;

  StreamSubscription? _firebaseMessagingSubscription;

  PushNotificationsServiceImpl({
    required this.restApiClient,
  });

  @override
  late StreamController<PushNotificationModel> pushNotifications = StreamController<PushNotificationModel>.broadcast();

  @override
  Future<void> init() async {
    logger.debug('FCM-TOKEN: ${(await _token).value}');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingOnBackgroundMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingOnMessageOpenedAppHandler);
    FirebaseMessaging.onMessage.listen(_firebaseMessagingOnMessageHandler);

    _firebaseMessagingSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((newToken) => _sendFCM(newToken));

    try {
      final message = await FirebaseMessaging.instance.getInitialMessage();

      if (message != null) {
        // final notification = PushNotificationModel.fromMap(message.data);
        final notification = PushNotificationModel(
          chatMessage: ChatMessageResponseModel.fromJson(message.data),
          type: PushNotificationType.openedApp,
        );

        pushNotifications.add(notification);
      }

      await _sendFCM();
    } catch (e) {
      logger.error(e.toString());
    }
  }

  @override
  Future<void> dispose() async {
    await pushNotifications.close();
    await _firebaseMessagingSubscription?.cancel();
  }

  Future<void> _sendFCM([String? newToken]) async {
    restApiClient.exceptionHandler.exceptionOptions.disable();

    final firebaseTokenId = newToken ?? await _token;

    await restApiClient.patch(
      '/api/account/update-fcm-token',
      data: {
        'fcmToken': firebaseTokenId,
      },
    );
  }

  Future<String?> get _token async {
    try {
      final notificationSettings = await FirebaseMessaging.instance.requestPermission();

      return switch (notificationSettings.authorizationStatus) {
        AuthorizationStatus.authorized => await FirebaseMessaging.instance.getToken(),
        AuthorizationStatus.denied => null,
        AuthorizationStatus.notDetermined => null,
        AuthorizationStatus.provisional => await FirebaseMessaging.instance.getToken(),
      };
    } catch (e) {
      logger.error(e.toString());

      return null;
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingOnBackgroundMessageHandler(RemoteMessage message) async {}

void _firebaseMessagingOnMessageHandler(RemoteMessage message) {
  logger.debug('HANDLING [ON MESSAGE] WITH MESSAGE ID: ${message.messageId} | ${message.data}');

  _firebaseMessagingAddNotification(
    PushNotificationModel(
      chatMessage: ChatMessageResponseModel.fromJson(message.data),
      type: PushNotificationType.foregroundWhileAppIsLive,
    ),
    // PushNotificationModel.fromMap(message.data).copyWith(
    //   type: PushNotificationType.foregroundWhileAppIsLive,
    // ),
  );
}

void _firebaseMessagingOnMessageOpenedAppHandler(RemoteMessage message) {
  logger.debug('HANDLING [ON MESSAGE OPENED APP] WITH MESSAGE ID: ${message.messageId} | ${message.data}');

  _firebaseMessagingAddNotification(
    PushNotificationModel(
      chatMessage: ChatMessageResponseModel.fromJson(message.data),
      type: PushNotificationType.foregroundWhileAppIsLive,
    ),
    // PushNotificationModel.fromMap(message.data).copyWith(
    //   type: PushNotificationType.openedApp,
    // ),
  );
}

void _firebaseMessagingAddNotification(PushNotificationModel notification) {
  try {
    services.get<PushNotificationsService>().pushNotifications.add(notification);
  } catch (e) {
    logger.error(e.toString());
  }
}
