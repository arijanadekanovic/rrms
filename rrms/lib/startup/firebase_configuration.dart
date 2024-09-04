import 'package:firebase_core/firebase_core.dart';
import 'package:rrms/_all.dart';

class FirebaseConfiguration {
  static Future<void> configure() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
}
