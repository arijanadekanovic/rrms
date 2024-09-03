import 'package:firebase_core/firebase_core.dart';
import 'package:rrms/_all.dart';

class AppSettings {
  final String mainApiUrl;
  final String storageApiUrl;
  final bool resetStorage;
  final String appName;
  final LoggingOptions loggingOptions;

  FirebaseOptions? get firebaseOptions {
    if (Platform.isAndroid) {
      return FirebaseOptions(
        apiKey: 'AIzaSyDQoIU0f7TeDA5IAZ7BTyxFx6QV3QJWKb8',
        appId: '1:1065194357789:android:10074071b5de7a7b96b2f4',
        messagingSenderId: '1065194357789',
        projectId: 'rrms-d79d6',
        storageBucket: 'rrms-d79d6.appspot.com',
      );
    }

    return null;
  }

  AppSettings({
    this.mainApiUrl = '<URL>',
    this.storageApiUrl = '<URL>',
    this.resetStorage = false,
    this.appName = 'RRMS',
    this.loggingOptions = const LoggingOptions(),
  });
}
