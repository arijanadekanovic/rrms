import 'package:rrms/_all.dart';

class PermissionRationaleMessages {
  final String title;
  final String description;
  final String? additionalDescription;
  final String actionDescription;
  final String cancel;
  final String okay;

  PermissionRationaleMessages({
    required this.title,
    required this.description,
    this.additionalDescription,
    required this.actionDescription,
    required this.cancel,
    required this.okay,
  });

  factory PermissionRationaleMessages.basic({
    required String description,
    String? additionalDescription,
  }) =>
      PermissionRationaleMessages(
        title: translations.permission_required,
        description: description,
        additionalDescription: additionalDescription,
        actionDescription: translations.allow_this_permission_in_your_app_settings,
        cancel: translations.cancel,
        okay: translations.go_to_settings,
      );
}
