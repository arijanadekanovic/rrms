import 'package:rrms/_all.dart';

GetIt services = GetIt.instance;
Environment environment = () {
  final env = const String.fromEnvironment('environment').toLowerCase();

  return env.isNotNullOrEmpty ? Environment.values.byName(env) : Environment.production;
}();

class Startup {
  static Future configure() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await RestApiClient.initFlutter();

    AppSettingsConfiguration.configure();
    FirebaseConfiguration.configure();
    await StorageConfiguration.configure();
    ModelValidatorsConfiguration.configure();
    await ApiClientConfiguration.configure();
    await ServicesConfiguration.configure();
    await RepositoriesConfiguration.configure();
    StateManagementConfiguration.configure();
  }
}
