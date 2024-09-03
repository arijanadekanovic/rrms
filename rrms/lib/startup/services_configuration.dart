import 'package:rrms/_all.dart';

class ServicesConfiguration {
  static Future<void> configure() async {
    services.registerSingleton<Toast>(ToastImpl());
    services.registerSingleton<Logger>(ConsoleLoggerImpl());
    services.registerSingleton<Debouncer>(DebouncerImpl());
    services.registerSingleton<MediaStorageService>(MediaStorageServiceImpl(restApiClient: services.get<RestApiClient>()));
    services.registerSingleton<PushNotificationsService>(PushNotificationsServiceImpl(restApiClient: services.get<RestApiClient>()));
  }
}
