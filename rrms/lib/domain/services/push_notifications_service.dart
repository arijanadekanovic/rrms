import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rrms/_all.dart';

abstract class PushNotificationsService {
  late StreamController<NotificationResponseModel> pushNotifications;
  Future<void> init();
  Future<void> dispose();
}

class PushNotificationsServiceImpl implements PushNotificationsService {
  final RestApiClient restApiClient;
  final DeviceInfoService deviceInfoService;

  StreamSubscription? _firebaseMessagingSubscription;

  PushNotificationsServiceImpl({
    required this.restApiClient,
    required this.deviceInfoService,
  });

  @override
  late StreamController<NotificationResponseModel> pushNotifications = StreamController<NotificationResponseModel>.broadcast();

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
        final notification = NotificationResponseModel.fromMap(message.data);

        pushNotifications.add(
          notification.copyWith(
            notificationReceiveType: NotificationReceiveType.openedApp,
          ),
        );
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
    final deviceIdentifier = deviceInfoService.signature();

    logger.debug('DEVICE-IDENTIFIER: $deviceIdentifier');

    await restApiClient.post(
      '${appSettings.notificationsApiUrl}/api/users/enable-push-notifications',
      data: {
        'firebaseTokenId': firebaseTokenId,
        'deviceIdentifier': deviceIdentifier,
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
  logger.debug('HANDLING [ON MESSAGE] WITH MESSAGE ID: ${message.messageId}');

  _firebaseMessagingAddNotification(
    NotificationResponseModel.fromMap(message.data).copyWith(
      notificationReceiveType: NotificationReceiveType.foregroundWhileAppIsLive,
    ),
  );
}

void _firebaseMessagingOnMessageOpenedAppHandler(RemoteMessage message) {
  logger.debug('HANDLING [ON MESSAGE OPENED APP] WITH MESSAGE ID: ${message.messageId}');

  _firebaseMessagingAddNotification(
    NotificationResponseModel.fromMap(message.data).copyWith(
      notificationReceiveType: NotificationReceiveType.openedApp,
    ),
  );
}

void _firebaseMessagingAddNotification(NotificationResponseModel notification) {
  try {
    services.get<PushNotificationsService>().pushNotifications.add(notification);
  } catch (e) {
    logger.error(e.toString());
  }
}

class MockPushNotificationsServiceImpl implements PushNotificationsService {
  @override
  late StreamController<NotificationResponseModel> pushNotifications = StreamController<NotificationResponseModel>.broadcast();

  @override
  Future<void> init() async {}

  @override
  Future<void> dispose() async {
    await pushNotifications.close();
  }
}
