import 'package:rrms/_all.dart';

enum AppRole {
  superadmin('SuperAdmin'),
  landlord('Landlord'),
  resident('Resident');

  final String name;

  const AppRole(this.name);

  static AppRole? parse(String? value) => values.firstOrDefault((x) => x.name == value);

  String get title => switch (this) {
        AppRole.superadmin => translations.superadmin,
        AppRole.landlord => translations.landlord,
        AppRole.resident => translations.resident,
      };
}
