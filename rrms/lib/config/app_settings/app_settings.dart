import 'package:rrms/_all.dart';

class AppSettings {
  final String mainApiUrl;
  final String storageApiUrl;
  final bool resetStorage;
  final String appName;
  final LoggingOptions loggingOptions;

  AppSettings({
    this.mainApiUrl = '<URL>',
    this.storageApiUrl = '<URL>',
    this.resetStorage = false,
    this.appName = 'RRMS',
    this.loggingOptions = const LoggingOptions(),
  });
}
