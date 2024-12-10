import 'package:rrms/_all.dart';

class AppSettings {
  final AppSettingsApiUrl apiUrlMobile;
  final AppSettingsApiUrl apiUrlDesktop;
  final bool resetStorage;
  final String appName;
  final PayPalAppSettings payPalAppSettings;
  final LoggingOptions loggingOptions;

  AppSettings({
    this.apiUrlMobile = const AppSettingsApiUrl(
      mainApiUrl: 'https://10.0.2.2:5001',
      storageApiUrl: 'https://10.0.2.2:5003',
    ),
    this.apiUrlDesktop = const AppSettingsApiUrl(
      mainApiUrl: 'https://localhost:5001',
      storageApiUrl: 'https://localhost:5003',
    ),
    this.resetStorage = false,
    this.appName = 'RRMS',
    this.payPalAppSettings = const PayPalAppSettings(
      clientId: 'AbHQr8FP8YjRNclQTc7-nfHsyFLP0l0DFp-UCsJhfWtI0E-DYDaukjciqqFbJhefRLoMDTTVSrO3fAqH',
      secretKey: 'EASMvGL_wHPZGj9KVn3pDt5gIsdYRuvXgP_bZdKlC6u4PmV1WKGbWwcA1o3zQZxaMZj9oPdfHzPD9R14',
    ),
    this.loggingOptions = const LoggingOptions(),
  });

  String get mainApiUrl => _isMobile
      ? apiUrlMobile.mainApiUrl
      : _isDesktop
          ? apiUrlDesktop.mainApiUrl
          : '<UNSUPPORTED PLATFORM>';

  String get storageApiUrl => _isMobile
      ? apiUrlMobile.storageApiUrl
      : _isDesktop
          ? apiUrlDesktop.storageApiUrl
          : '<UNSUPPORTED PLATFORM>';

  bool get _isDesktop => Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  bool get _isMobile => Platform.isAndroid || Platform.isIOS;
}

class AppSettingsApiUrl {
  final String mainApiUrl;
  final String storageApiUrl;

  const AppSettingsApiUrl({
    required this.mainApiUrl,
    required this.storageApiUrl,
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
