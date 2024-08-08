import 'package:rrms/_all.dart';

AppSettings appSettings = services.get<AppSettings>();

class AppSettingsConfiguration {
  static void configure() {
    switch (environment) {
      case Environment.mock:
        services.registerSingleton<AppSettings>(mockAppSettings);
        break;
      case Environment.development:
        services.registerSingleton<AppSettings>(developmentAppSettings);
        break;
      case Environment.staging:
        services.registerSingleton<AppSettings>(stagingAppSettings);
        break;
      case Environment.production:
        services.registerSingleton<AppSettings>(productionAppSettings);
        break;
    }
  }
}
