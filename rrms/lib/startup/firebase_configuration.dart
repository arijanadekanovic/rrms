import 'package:firebase_core/firebase_core.dart';
import 'package:rrms/startup/app_settings_configuration.dart';

class FirebaseConfiguration {
  static Future configure() async {
    await Firebase.initializeApp(options: appSettings.firebaseOptions);
  }
}
