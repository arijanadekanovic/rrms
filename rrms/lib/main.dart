import '_all.dart';

Future<void> main() async {
  await Startup.configure();
  runApp(const App());
}
