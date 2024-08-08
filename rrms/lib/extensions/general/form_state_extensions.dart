import 'package:rrms/_all.dart';

extension AppFormStateX on GlobalKey<FormState> {
  bool validate() => currentState?.validate() ?? false;
}
