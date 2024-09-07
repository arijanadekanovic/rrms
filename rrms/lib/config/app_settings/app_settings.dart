// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rrms/_all.dart';

class AppSettings {
  final String mainApiUrl;
  final String storageApiUrl;
  final bool resetStorage;
  final String appName;
  final PayPalAppSettings payPalAppSettings;
  final LoggingOptions loggingOptions;

  AppSettings({
    this.mainApiUrl = '<URL>',
    this.storageApiUrl = '<URL>',
    this.resetStorage = false,
    this.appName = 'RRMS',
    this.payPalAppSettings = const PayPalAppSettings(
      clientId: '<CLIENT_ID>',
      secretKey: '<SECRET_KEY>',
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
