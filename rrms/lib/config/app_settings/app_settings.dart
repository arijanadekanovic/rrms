import 'package:rrms/_all.dart';

class AppSettings {
  final String mainApiUrl;
  final String storageApiUrl;
  final bool resetStorage;
  final String appName;
  final PayPalAppSettings payPalAppSettings;
  final LoggingOptions loggingOptions;

  AppSettings({
    this.mainApiUrl = const String.fromEnvironment('mainApiUrl'),
    this.storageApiUrl = const String.fromEnvironment('storageApiUrl'),
    this.resetStorage = false,
    this.appName = 'RRMS',
    this.payPalAppSettings = const PayPalAppSettings(
      clientId: const String.fromEnvironment('paypalClientId'),
      secretKey: const String.fromEnvironment('paypalSecretKey'),
    ),
    this.loggingOptions = const LoggingOptions(),
  });
}

class PayPalAppSettings {
  final String clientId;
  final String secretKey;

  const PayPalAppSettings({
    required this.clientId,
    required this.secretKey,
  });
}
