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
    this.mainApiUrl = 'https://10.0.2.2:5001',
    this.storageApiUrl = 'https://10.0.2.2:5003',
    this.resetStorage = false,
    this.appName = 'RRMS',
    this.payPalAppSettings = const PayPalAppSettings(
      clientId: 'AbHQr8FP8YjRNclQTc7-nfHsyFLP0l0DFp-UCsJhfWtI0E-DYDaukjciqqFbJhefRLoMDTTVSrO3fAqH',
      secretKey: 'EASMvGL_wHPZGj9KVn3pDt5gIsdYRuvXgP_bZdKlC6u4PmV1WKGbWwcA1o3zQZxaMZj9oPdfHzPD9R14',
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
