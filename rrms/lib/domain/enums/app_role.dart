import 'package:rrms/_all.dart';

enum AppRole {
  superadmin('SUPERADMIN'),
  landlord('LANDLORD'),
  resident('RESIDENT');

  final String name;

  const AppRole(this.name);

  static AppRole parse(String? value) => values.firstOrDefault((x) => x.name == value) ?? AppRole.resident;

  String get title => switch (this) {
        AppRole.superadmin => translations.superadmin,
        AppRole.landlord => translations.landlord,
        AppRole.resident => translations.resident,
      };
}
